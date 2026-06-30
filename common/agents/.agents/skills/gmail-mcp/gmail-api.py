#!/usr/bin/env python3
"""
Gmail REST API helper for pi.
Manages OAuth token refresh and provides clean CLI commands.
Credentials stored in ~/.gmail-mcp/credentials.json

Usage:
  gmail-api.py list-labels [--max N]
  gmail-api.py search <query> [--max N] [--page-token TOKEN]
  gmail-api.py thread <id>
  gmail-api.py message <id>
  gmail-api.py list-drafts [--max N] [--query <q>]
  gmail-api.py draft-create --to ADDR [--cc ADDR] [--subject TEXT] --body TEXT
  gmail-api.py label-create <name>
  gmail-api.py modify-message <id> --add-labels IDS --remove-labels IDS
  gmail-api.py modify-thread <id> --add-labels IDS --remove-labels IDS
"""

import json
import os
import sys
import time
import urllib.error
import urllib.request

CRED_PATH = os.path.expanduser("~/.pi/agent/skills/gmail-mcp/credentials.json")
TOKEN_URI = "https://oauth2.googleapis.com/token"
API_BASE = "https://gmail.googleapis.com/gmail/v1/users/me"


def load_credentials():
    try:
        with open(CRED_PATH) as f:
            return json.load(f)
    except FileNotFoundError:
        die("credentials not found — run the OAuth setup first")


def save_credentials(creds):
    os.makedirs(os.path.dirname(CRED_PATH), exist_ok=True)
    with open(CRED_PATH, "w") as f:
        json.dump(creds, f, indent=2)


def refresh_token(creds):
    data = urllib.parse.urlencode({
        "client_id": creds["client_id"],
        "client_secret": creds["client_secret"],
        "refresh_token": creds["refresh_token"],
        "grant_type": "refresh_token",
    }).encode()
    req = urllib.request.Request(TOKEN_URI, data=data)
    req.add_header("Content-Type", "application/x-www-form-urlencoded")
    try:
        with urllib.request.urlopen(req) as resp:
            t = json.loads(resp.read().decode())
        creds["access_token"] = t["access_token"]
        creds["expires_at"] = int(time.time()) + t.get("expires_in", 3600) - 60
        save_credentials(creds)
        return creds["access_token"]
    except urllib.error.HTTPError as e:
        body = e.read().decode()
        die(f"token refresh failed ({e.code}): {body}")


def get_token():
    creds = load_credentials()
    if creds.get("expires_at", 0) < time.time():
        return refresh_token(creds)
    return creds["access_token"]


def api_get(path):
    token = get_token()
    req = urllib.request.Request(f"{API_BASE}/{path}")
    req.add_header("Authorization", f"Bearer {token}")
    try:
        with urllib.request.urlopen(req) as resp:
            return json.loads(resp.read().decode())
    except urllib.error.HTTPError as e:
        body = e.read().decode()
        die(f"API error ({e.code}): {body}")


def api_post(path, body):
    token = get_token()
    data = json.dumps(body).encode()
    req = urllib.request.Request(f"{API_BASE}/{path}", data=data)
    req.add_header("Authorization", f"Bearer {token}")
    req.add_header("Content-Type", "application/json")
    try:
        with urllib.request.urlopen(req) as resp:
            return json.loads(resp.read().decode())
    except urllib.error.HTTPError as e:
        body = e.read().decode()
        die(f"API error ({e.code}): {body}")


def die(msg):
    print(f"gmail-api: {msg}", file=sys.stderr)
    sys.exit(1)


# ── CLI ──────────────────────────────────────────────────────────

def cmd_list_labels():
    max_results = parse_opt("--max", "20")
    result = api_get(f"labels?maxResults={max_results}")
    for label in result.get("labels", []):
        print(json.dumps(label))


def cmd_search():
    query = sys.argv[2] if len(sys.argv) > 2 else ""
    max_results = parse_opt("--max", "10")
    page_token = parse_opt("--page-token", None)
    path = f"threads?q={urllib.parse.quote(query)}&maxResults={max_results}"
    if page_token:
        path += f"&pageToken={urllib.parse.quote(page_token)}"
    result = api_get(path)
    print(json.dumps(result, indent=2))


def cmd_thread():
    thread_id = sys.argv[2] if len(sys.argv) > 2 else die("missing thread id")
    result = api_get(f"threads/{thread_id}")
    print(json.dumps(result, indent=2))


def cmd_message():
    msg_id = sys.argv[2] if len(sys.argv) > 2 else die("missing message id")
    result = api_get(f"messages/{msg_id}")
    print(json.dumps(result, indent=2))


def cmd_list_drafts():
    max_results = parse_opt("--max", "10")
    query = parse_opt("--query", None)
    path = f"drafts?maxResults={max_results}"
    if query:
        path += f"&q={urllib.parse.quote(query)}"
    result = api_get(path)
    for draft in result.get("drafts", []):
        print(json.dumps(draft))


def cmd_draft_create():
    to_addr = parse_opt("--to", None)
    if not to_addr:
        die("--to is required")
    subject = parse_opt("--subject", "")
    body_text = parse_opt("--body", "")
    cc = parse_opt("--cc", None)
    bcc = parse_opt("--bcc", None)

    # Build raw RFC 2822 message
    msg_lines = []
    msg_lines.append(f"To: {to_addr}")
    if cc:
        msg_lines.append(f"Cc: {cc}")
    if bcc:
        msg_lines.append(f"Bcc: {bcc}")
    msg_lines.append(f"Subject: {subject}")
    msg_lines.append("Content-Type: text/plain; charset=utf-8")
    msg_lines.append("")
    msg_lines.append(body_text)

    import base64
    raw = base64.urlsafe_b64encode("\r\n".join(msg_lines).encode()).decode()

    result = api_post("drafts", {
        "message": {
            "raw": raw,
            "labelIds": ["DRAFT"],
        }
    })
    print(json.dumps(result, indent=2))


def cmd_label_create():
    name = sys.argv[2] if len(sys.argv) > 2 else die("missing label name")
    result = api_post("labels", {"name": name})
    print(json.dumps(result, indent=2))


def cmd_modify_message():
    msg_id = sys.argv[2] if len(sys.argv) > 2 else die("missing message id")
    add_ids = parse_list_opt("--add-labels")
    remove_ids = parse_list_opt("--remove-labels")
    body = {}
    if add_ids:
        body["addLabelIds"] = add_ids
    if remove_ids:
        body["removeLabelIds"] = remove_ids
    if not body:
        die("specify --add-labels and/or --remove-labels")
    result = api_post(f"messages/{msg_id}/modify", body)
    print(json.dumps(result, indent=2))


def cmd_modify_thread():
    thread_id = sys.argv[2] if len(sys.argv) > 2 else die("missing thread id")
    add_ids = parse_list_opt("--add-labels")
    remove_ids = parse_list_opt("--remove-labels")
    body = {}
    if add_ids:
        body["addLabelIds"] = add_ids
    if remove_ids:
        body["removeLabelIds"] = remove_ids
    if not body:
        die("specify --add-labels and/or --remove-labels")
    result = api_post(f"threads/{thread_id}/modify", body)
    print(json.dumps(result, indent=2))


def parse_opt(flag, default):
    try:
        idx = sys.argv.index(flag)
        return sys.argv[idx + 1]
    except (ValueError, IndexError):
        return default


def parse_list_opt(flag):
    try:
        idx = sys.argv.index(flag)
        raw = sys.argv[idx + 1]
        return [x.strip() for x in raw.split(",") if x.strip()]
    except (ValueError, IndexError):
        return None


def cmd_reauth():
    """Run OAuth flow to get fresh tokens."""
    import http.server, subprocess

    try:
        with open(CRED_PATH) as f:
            creds = json.load(f)
    except (FileNotFoundError, json.JSONDecodeError):
        creds = {}

    client_id = creds.get("client_id") or os.environ.get("GMAIL_MCP_CLIENT_ID")
    client_secret = creds.get("client_secret") or os.environ.get("GMAIL_MCP_CLIENT_SECRET")
    if not client_id or not client_secret:
        die("Set GMAIL_MCP_CLIENT_ID and GMAIL_MCP_CLIENT_SECRET env vars, then retry.")

    redirect_uri = "http://localhost:4444/callback"
    scopes = [
        "https://www.googleapis.com/auth/gmail.readonly",
        "https://www.googleapis.com/auth/gmail.modify",
        "https://www.googleapis.com/auth/gmail.compose",
        "https://www.googleapis.com/auth/gmail.labels",
    ]

    captured_code = None

    class Handler(http.server.BaseHTTPRequestHandler):
        def do_GET(self):
            nonlocal captured_code
            qs = urllib.parse.urlparse(self.path).query
            params = urllib.parse.parse_qs(qs)
            if "code" in params:
                captured_code = params["code"][0]
                self.send_response(200)
                self.send_header("Content-Type", "text/html")
                self.end_headers()
                self.wfile.write(b"<html><body><h1>Auth OK - close this tab</h1></body></html>")
            elif "error" in params:
                captured_code = f"ERROR:{params['error'][0]}"
                self.send_response(400)
                self.end_headers()
        def log_message(self, *a): pass

    params = {
        "client_id": client_id, "redirect_uri": redirect_uri,
        "response_type": "code", "scope": " ".join(scopes),
        "access_type": "offline", "prompt": "consent",
    }
    auth_url = f"https://accounts.google.com/o/oauth2/v2/auth?{urllib.parse.urlencode(params)}"
    print("Opening browser...", file=sys.stderr, flush=True)
    subprocess.run(["open", auth_url], check=False)

    server = http.server.HTTPServer(("0.0.0.0", 4444), Handler)
    server.timeout = 180
    try:
        while captured_code is None:
            server.handle_request()
    finally:
        server.server_close()

    if not captured_code or captured_code.startswith("ERROR:"):
        die(f"Auth failed: {captured_code}")

    print("Exchanging code for tokens...", file=sys.stderr, flush=True)
    data = urllib.parse.urlencode({
        "code": captured_code, "client_id": client_id,
        "client_secret": client_secret, "redirect_uri": redirect_uri,
        "grant_type": "authorization_code",
    }).encode()
    req = urllib.request.Request(TOKEN_URI, data=data)
    req.add_header("Content-Type", "application/x-www-form-urlencoded")
    try:
        with urllib.request.urlopen(req) as resp:
            tokens = json.loads(resp.read().decode())
    except urllib.error.HTTPError as e:
        die(f"Token exchange failed ({e.code}): {e.read().decode()}")

    creds["refresh_token"] = tokens["refresh_token"]
    creds["access_token"] = tokens["access_token"]
    creds["expires_at"] = int(time.time()) + tokens.get("expires_in", 3600) - 60
    save_credentials(creds)

    # Verify
    req2 = urllib.request.Request(
        f"{API_BASE}/profile",
        headers={"Authorization": f"Bearer {tokens['access_token']}"}
    )
    try:
        with urllib.request.urlopen(req2, timeout=10) as resp:
            profile = json.loads(resp.read().decode())
        print(f"Re-authenticated as {profile.get('emailAddress', '?')}")
    except urllib.error.HTTPError as e:
        die(f"Gmail API test failed ({e.code}): {e.read().decode()[:300]}")


COMMANDS = {
    "reauth": cmd_reauth,
    "list-labels": cmd_list_labels,
    "search": cmd_search,
    "thread": cmd_thread,
    "message": cmd_message,
    "list-drafts": cmd_list_drafts,
    "draft-create": cmd_draft_create,
    "label-create": cmd_label_create,
    "modify-message": cmd_modify_message,
    "modify-thread": cmd_modify_thread,
}

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("gmail-api — Gmail REST API helper", file=sys.stderr)
        print("Commands:", ", ".join(COMMANDS), file=sys.stderr)
        sys.exit(1)

    cmd = sys.argv[1]
    fn = COMMANDS.get(cmd)
    if not fn:
        die(f"unknown command: {cmd} (available: {', '.join(COMMANDS)})")
    fn()
