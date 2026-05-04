# Claude Hub

This repo is a personal plugin marketplace and MCP configuration hub for Claude Code CLI. It keeps plugins, skills, and MCP servers in sync across machines.

## When asked to set up this hub

Run these steps in order. Ask before skipping any step.

**Step 1 — Add this repo as a Claude Code marketplace**

```
/plugin marketplace add quiquevalles15/claude-hub
```

**Step 2 — Install all plugins**

```
/plugin install superpowers@quique-claude-hub
/plugin install frontend-design@quique-claude-hub
/plugin install ui-ux-pro-max@quique-claude-hub
/plugin install caveman@quique-claude-hub
/plugin install diagnose@quique-claude-hub
/plugin install grill-me@quique-claude-hub
/plugin install zoom-out@quique-claude-hub
```

**Step 3 — Add MCP servers**

```bash
claude mcp add context7 -s user -- npx -y @upstash/context7-mcp

claude mcp add github -s user \
  -e GITHUB_PERSONAL_ACCESS_TOKEN=YOUR_GITHUB_TOKEN \
  -- docker run -i --rm -e GITHUB_PERSONAL_ACCESS_TOKEN ghcr.io/github/github-mcp-server
```

Remind the user to replace `YOUR_GITHUB_TOKEN` with a real token from [github.com/settings/tokens](https://github.com/settings/tokens).

---

## Repo layout

| Path | Purpose |
|---|---|
| `.claude-plugin/marketplace.json` | Plugin catalog — source of truth for which plugins this hub provides |
| `plugins/` | Local plugin wrappers for upstream skill files that lack a plugin manifest |
| `mcp/mcp.json` | MCP server definitions for reference (apply via `claude mcp add`) |

## Maintenance

See [CONTRIBUTING.md](CONTRIBUTING.md) to add plugins, skills, or MCP servers.
