---
name: gmail-mcp
description: >-
  Gmail integration via official REST API and helper script.
  Search and read email threads, create drafts, manage labels.
  Cannot send emails; drafts must be reviewed manually in Gmail.
---

# Gmail via REST API

You have a helper script at `~/.pi/agent/skills/gmail-mcp/gmail-api.py` that handles OAuth token refresh and calls the official Gmail REST API. The agent can **search and read emails**, **create drafts**, and **manage labels** — but **cannot send emails** (drafts require manual review in Gmail).

## Workflow

1. **Discover labels** (needed before labeling operations):
   ```bash
   python3 ~/.pi/agent/skills/gmail-mcp/gmail-api.py list-labels --max 20
   ```

2. **Search emails** by Gmail query syntax:
   ```bash
   python3 ~/.pi/agent/skills/gmail-mcp/gmail-api.py search "QUERY" --max N
   ```

3. **Get full thread details** (body, headers, attachments) using a thread ID from search:
   ```bash
   python3 ~/.pi/agent/skills/gmail-mcp/gmail-api.py thread "THREAD_ID"
   ```

4. **Get a single message** by message ID:
   ```bash
   python3 ~/.pi/agent/skills/gmail-mcp/gmail-api.py message "MESSAGE_ID"
   ```

5. **Create a draft** (sits in Drafts, you send manually):
   ```bash
   python3 ~/.pi/agent/skills/gmail-mcp/gmail-api.py draft-create --to "user@example.com" --subject "Subject" --body "Email body text"
   ```

## Commands

### Reading

#### `list-labels` — List all Gmail labels
Returns label ID, name, and type (system/user).
```bash
python3 ~/.pi/agent/skills/gmail-mcp/gmail-api.py list-labels --max 20
```

#### `search` — Search email threads
Uses Gmail search syntax. Returns thread IDs, snippets, and estimated count. Does NOT return full bodies — use `thread` for that.
```bash
python3 ~/.pi/agent/skills/gmail-mcp/gmail-api.py search "is:unread newer_than:7d" --max 10
python3 ~/.pi/agent/skills/gmail-mcp/gmail-api.py search "from:alice@example.com subject:invoice" --max 5
python3 ~/.pi/agent/skills/gmail-mcp/gmail-api.py search "has:attachment is:starred" --max 5
```
Pagination: use `--page-token TOKEN` from the `nextPageToken` field of previous results.

#### `thread` — Get full thread by ID
Returns all messages in the thread with headers (From, To, Subject, Date), body, and attachment info.
```bash
python3 ~/.pi/agent/skills/gmail-mcp/gmail-api.py thread "THREAD_ID_FROM_SEARCH"
```

#### `message` — Get a single message
```bash
python3 ~/.pi/agent/skills/gmail-mcp/gmail-api.py message "MESSAGE_ID"
```

### Drafts

#### `draft-create` — Create a draft email
Creates a draft in Gmail. Returns the draft ID. **Does not send** — manually review and send from Gmail.
```bash
python3 ~/.pi/agent/skills/gmail-mcp/gmail-api.py draft-create --to "alice@example.com" --subject "Project Update" --body "Here is the latest status..."
```
Optional flags: `--cc ADDRESS`, `--bcc ADDRESS`

#### `list-drafts` — List drafts
```bash
python3 ~/.pi/agent/skills/gmail-mcp/gmail-api.py list-drafts --max 10
python3 ~/.pi/agent/skills/gmail-mcp/gmail-api.py list-drafts --query "subject:draft search" --max 5
```

### Labels

#### `label-create` — Create a new label
```bash
python3 ~/.pi/agent/skills/gmail-mcp/gmail-api.py label-create "Important/ProjectX"
```

#### `modify-message` — Add or remove labels on a message
Labels are comma-separated IDs (use `list-labels` to find them). System labels: INBOX, TRASH, SPAM, STARRED, UNREAD, IMPORTANT, SENT, DRAFT.
```bash
python3 ~/.pi/agent/skills/gmail-mcp/gmail-api.py modify-message "MESSAGE_ID" --add-labels "STARRED,Label_123" --remove-labels "UNREAD"
```

#### `modify-thread` — Add or remove labels on a thread
```bash
python3 ~/.pi/agent/skills/gmail-mcp/gmail-api.py modify-thread "THREAD_ID" --add-labels "TRASH" --remove-labels "INBOX"
```

## Tips

- **Always run `list-labels` first** before using label IDs — user labels have opaque IDs like `Label_123`
- **Search first, then fetch.** `search` returns summaries (id + snippet). Use `thread` for full content.
- **Gmail search syntax** works in `search`: `from:`, `to:`, `subject:`, `is:unread`, `is:starred`, `newer_than:7d`, `older_than:1y`, `has:attachment`, `label:NAME`, `in:inbox`, `in:sent`, `-in:draft` to exclude drafts, etc.
- **Message bodies** in Gmail API responses may be base64-encoded. The `thread` output includes raw JSON — parse the `payload.body.data` or `payload.parts[].body.data` fields and decode from base64 for the actual content.
- **Token management** is automatic — the script refreshes the OAuth token before making API calls.
- **Re-authentication:** If the refresh token expires (e.g., after months of disuse), the api calls will fail with a token error. To re-auth, run:
  ```bash
  python3 ~/.pi/agent/skills/gmail-mcp/gmail-api.py reauth
  ```
  This opens a browser for Google consent and saves fresh tokens. Takes ~30 seconds.
- **Errors** are printed to stderr. Check stderr if a command fails silently.
