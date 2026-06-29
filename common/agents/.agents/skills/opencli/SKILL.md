---
name: opencli
description: >
  Use OpenCLI to drive the user's logged-in Chrome browser, interact with 160+ websites
  (Twitter, Reddit, GitHub, YouTube, LinkedIn, etc.), control Electron desktop apps
  (Cursor, Codex, ChatGPT, etc.), or passthrough to external CLIs (gh, docker, vercel, etc.).
  OpenCLI turns any website into CLI commands — agents can click, type, extract, screenshot,
  capture network requests, and run pre-built adapter commands. Load this skill whenever the
  task involves browser automation, web scraping, interacting with a logged-in site,
  reading/posting to social media, or querying a website that has an OpenCLI adapter.
allowed-tools: Bash(opencli:*), Read, Edit, Write
---

# OpenCLI — Drive the Browser from CLI

OpenCLI turns any website, Electron desktop app, or external CLI into a uniform `opencli <site> <command>` surface. It reuses the user's real Chrome login state — no API keys, no token management, no re-authentication.

---

## Quick Start — Is OpenCLI Right for This Task?

Ask yourself:

1. Does the task involve a website, Electron app, or external tool (GitHub, Docker, Vercel, etc.)?
2. Does the user need logged-in access (social media, shopping, work tools)?
3. Would browser automation (click, type, extract, screenshot) solve it faster than hand-rolled `fetch`/`curl`?

If yes to any of the above, OpenCLI is likely the right tool.

---

## The Three Pillars

### 1. Site Adapters — `opencli <site> <command>`

Pre-built commands for 160+ websites and 10 desktop apps. These are the first thing to try — they handle authentication, selectors, and output formatting for you.

**Discover what's available (always run this first):**

```bash
opencli list                    # full table of 1250+ commands
opencli list -f json            # machine-readable, best for agents
opencli list | grep -i github   # find commands for a specific site
opencli <site> --help           # see a site's available commands
opencli <site> <command> --help # see positional args and flags
```

**Key site adapters (partial — always check `opencli list` for the full list):**

| Site | Sample Commands |
|------|----------------|
| **Twitter/X** | `search`, `tweet`, `timeline`, `user`, `dm` |
| **Reddit** | `search`, `read`, `comments`, `hot` |
| **GitHub** | `repo`, `search`, `issues`, `prs`, `notifications` |
| **YouTube** | `search`, `video`, `comments`, `transcript`, `channel` |
| **LinkedIn** | `search`, `profile`, `jobs`, `feed` |
| **Bilibili** | `search`, `video`, `user`, `danmaku` |
| **Wikipedia** | `search`, `read`, `summary` |
| **HackerNews** | `top`, `new`, `best`, `item` |
| **Stack Overflow** | `search`, `question`, `answers` |
| **Google** | `search` |
| **Claude/Gemini/Grok/DeepSeek/ChatGPT** | `ask`, `read`, `send` |
| **Discord** | `messages`, `channels`, `send` |
| **Steam** | `search`, `app`, `reviews` |
| **Amazon** | `search`, `product` |
| **Spotify** | `search`, `playlist`, `track` |

**Desktop app adapters** (drive Electron apps via CDP — the app must be running):
Cursor, Codex, Antigravity, ChatGPT Desktop, ChatWise, Discord, Doubao App, Trae CN, Trae SOLO

### 2. Browser Driving — `opencli browser <session> <command>`

When no adapter covers your task, drive Chrome directly. Every command returns a structured JSON envelope with `match_level` confidence.

**Prerequisites check:**

```bash
opencli doctor    # must be all green for browser commands
```

**Session lifecycle:**
- `<session>` is a required name (e.g., `work`, `research`, `twitter`). Reuse to keep tab state alive.
- `opencli browser <session> bind` — attaches the user's current Chrome tab to `<session>`. Use this for already-logged-in pages.
- `opencli browser <session> close` — release the session when done.

**Command reference:**

| Category | Commands | Purpose |
|----------|----------|---------|
| **Navigate** | `open <url>`, `back`, `tab list/new/select/close` | Page navigation |
| **Inspect** | `state`, `find --css`, `screenshot`, `frames` | See what's on the page. `state` gives `[N]` numeric refs. |
| **Read** | `get title/url/text/value/attributes/html`, `extract`, `eval` | Extract data |
| **Interact** | `click`, `type`, `fill`, `select`, `hover`, `focus`, `dblclick`, `check`, `uncheck`, `upload`, `drag`, `keys` | Drive the page |
| **Network** | `network`, `network --detail <key>`, `network --filter "field1,field2"` | Capture API responses |
| **Wait** | `wait selector/text/time/download/xhr` | Handle async loads |

**Critical rules for browser driving:**

1. **Always inspect before you act** — run `state` or `find` first. Never hard-code refs.
2. **Prefer numeric refs** (`[N]` from `state`) over CSS selectors — they survive mild DOM shifts.
3. **Check `match_level`** after writes: `exact` = good, `stable` = minor drift, `reidentified` = double-check.
4. **Re-`state` after page transitions** — old refs are invalid after navigation.
5. **Verify writes** — after `type`, run `get value`. Autocomplete and React controlled inputs silently eat characters.
6. **Prefer `network` over DOM scraping** — if the page fetches JSON, capture the API response instead of parsing rendered HTML.
7. **Use `compound` fields** — date/select/file inputs carry format info. Use it; don't regex-guess.
8. **`fill` for exact text, `type` for keyboard input** — `fill` sets value directly; `type` triggers autocomplete/IME.
9. **Chain with `&&`** when steps are atomic — keeps the browser session alive.
10. **Budget awareness** — `state` is medium cost, `get title/url` is tiny, `screenshot` is large. Use `find --css` for targeted queries.

**Minimal recipe — login and extract:**

```bash
opencli browser work open "https://example.com/login"
opencli browser work state                          # find [N] for email, password, submit
opencli browser work type 4 "user@example.com"
opencli browser work type 5 "password"
opencli browser work click 6                        # submit
opencli browser work wait selector ".dashboard" --timeout 15000
opencli browser work state                          # fresh refs
opencli browser work extract                        # get page content as markdown
```

**Bind to user's existing tab:**

```bash
opencli browser gmail bind          # bind current Chrome tab
opencli browser gmail state         # use it
opencli browser gmail unbind        # detach without closing
```

### 3. External CLI Passthrough — `opencli <tool>`

Wraps external command-line tools through the same entrypoint:

```bash
opencli gh pr list --limit 5        # GitHub CLI
opencli docker ps                    # Docker
opencli vercel list                  # Vercel
opencli gh --help                    # discover subcommands
```

Available: `gh`, `docker`, `vercel`, `wrangler`, `obsidian`, `discord`, `tg`, `lark-cli`, `wecom-cli`, `ntn` (Notion), `longbridge`, `dws`, `wx`

Manage: `opencli external install <name>`, `opencli external list`

---

## Universal Flags

| Flag | Effect |
|------|--------|
| `-f, --format <fmt>` | `json` (preferred for agents), `yaml`, `table`, `plain`, `md`, `csv` |
| `-v, --verbose` | Debug logs + stack traces |

**Always use `-f json` when parsing output programmatically.**

---

## Strategy Tags (from `opencli list`)

| Tag | Meaning | Browser Needed? |
|-----|---------|-----------------|
| `PUBLIC` | Pure HTTP, no auth | No |
| `COOKIE` | Uses Chrome login state | Yes |
| `INTERCEPT` | Captures a signed request | Yes |
| `UI` | Full DOM interaction | Yes |
| `LOCAL` | Local/dev endpoint | No |

Check the strategy before assuming a browser is needed.

---

## Output Formats

- **`json`** — pretty-printed, 2-space indent. Default choice for agents.
- **`plain`** — single primary field (good for piping).
- **`yaml`** — default when output is not a TTY.
- **`table`** — human-readable, color-coded.

---

## Environment Variables

| Variable | Default | Purpose |
|----------|---------|---------|
| `OPENCLI_BROWSER_CONNECT_TIMEOUT` | `45` | Seconds to wait for browser bridge |
| `OPENCLI_BROWSER_COMMAND_TIMEOUT` | `60` | Per-command timeout |
| `OPENCLI_WINDOW` | — | `foreground` or `background` |
| `OPENCLI_VERBOSE` | `false` | Verbose logging |
| `OPENCLI_CACHE_DIR` | `~/.opencli/cache` | Network capture cache |

---

## When Things Go Wrong

| Symptom | Fix |
|---------|-----|
| `opencli doctor` shows red | Browser bridge not connected. Install the Chrome extension or restart daemon: `opencli daemon restart` |
| Adapter command fails | Re-run with `--trace retain-on-failure`. The error envelope includes a path to the adapter source. |
| `selector_not_found` | Page mutated. `wait selector "..."` then retry. |
| `stale_ref` on every command | Reusing refs from a prior page — re-`state`. |
| `type` succeeds but value is wrong | React controlled input ate it. `get value` to verify, then `fill` instead. |
| Network cache seems stale | Bump `--ttl` down, or clear `~/.opencli/cache/browser-network/`. |
| Adapter returns `EMPTY_RESULT` but you know data exists | The adapter may rely on intercepting a client-side API call (e.g., a GraphQL `messengerConversations` request) that was never fired because the page was server-side rendered (SSR). Fall back to raw browser driving: `opencli browser <s> open <url>`, `wait time N`, then `extract` to read the server-rendered DOM directly. |

---

## Bundled OpenCLI Skills (Load When Needed)

OpenCLI ships specialized skills for deeper tasks. Load these from OpenCLI itself:

```bash
opencli skills read opencli-usage              # top-level orientation
opencli skills read opencli-browser            # driving a live browser
opencli skills read opencli-browser-sitemap    # using site sitemaps
opencli skills read opencli-adapter-author     # writing a new adapter
opencli skills read opencli-autofix            # fixing broken adapters
opencli skills read opencli-sitemap-author     # creating site sitemaps
```

You can load these on demand when a task requires deeper browser driving or adapter work.

---

## Key Don'ts

- **Don't hard-code adapter lists** — run `opencli list -f json` instead. There are 1250+ commands and growing.
- **Don't assume every adapter needs a browser** — check the `strategy` tag first.
- **Don't use `eval` for writes** — use `click`/`type`/`select`/`keys`. `eval` is read-only.
- **Don't reuse refs across page transitions** — re-`state` after every navigation.
- **Don't submit forms via `eval "document.forms[0].submit()"`** — modern sites drop this. Click the submit button instead.
- **Don't scrape DOM when the page has a JSON API** — use `browser network` instead. **Exception:** if the adapter failed with `EMPTY_RESULT` because the expected API call was never fired (common with SSR pages), fall back to `extract` to read the server-rendered DOM.
- **Don't screenshot for agents** — screenshots are for humans. Use `state` + `find` + `extract`.

---

## Quick Reference

```bash
# Discovery
opencli list -f json                          # all available commands
opencli <site> --help                         # site's commands
opencli browser <session> --help              # browser subcommands

# Health
opencli doctor                                # check browser bridge
opencli daemon status                         # check daemon

# Browser (ad-hoc)
opencli browser <s> open <url>                # navigate
opencli browser <s> state                     # snapshot with [N] refs
opencli browser <s> click <N>                 # interact by ref
opencli browser <s> extract                   # get page as markdown
opencli browser <s> network                   # capture API responses
opencli browser <s> screenshot                # visual (use sparingly)
opencli browser <s> close                     # release session
opencli browser <s> bind                      # attach to user's Chrome tab

# Adapters (pre-built)
opencli github search "topic" -f json         # search GitHub
opencli twitter search "query" -f json        # search Twitter/X
opencli youtube video <id> -f json            # get video metadata
opencli reddit hot -f json                    # Reddit front page
opencli hackernews top -f json                # HN top stories
opencli wikipedia read "Article" -f plain     # Wikipedia article

# External CLIs
opencli gh pr list                            # GitHub PRs via gh CLI
opencli docker ps                             # Docker containers
```
