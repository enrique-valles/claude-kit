# Claude Hub

This repo is a personal plugin marketplace and MCP configuration hub for Claude. It keeps plugins, skills, and MCP servers in sync across machines.

## When asked to set up this hub

Run these steps in order. Ask before skipping any step.

**Step 1 — Wire MCP servers (Desktop + CLI)**

```bash
./setup-desktop.sh
```

This merges `mcp/mcp.json` into Claude Desktop's config and offers to run `claude mcp add` for Claude Code CLI. Let the user answer the interactive prompts.

**Step 2 — Add this repo as a Claude Code marketplace**

Tell the user to run in Claude Code:

```
/plugin marketplace add quiquevalles15/claude-hub
```

**Step 3 — Install all plugins**

Tell the user to run in Claude Code:

```
/plugin install superpowers@quique-claude-hub
/plugin install frontend-design@quique-claude-hub
/plugin install ui-ux-pro-max@quique-claude-hub
/plugin install caveman@quique-claude-hub
```

**Step 4 — Remind about the GitHub token**

The `github` MCP uses a placeholder token. The user must set the real one:

- **Claude Desktop**: edit `~/Library/Application Support/Claude/claude_desktop_config.json` and replace `YOUR_GITHUB_TOKEN`
- **Claude Code CLI**: the setup script prompted for it interactively in Step 1

---

## Repo layout

| Path | Purpose |
|---|---|
| `.claude-plugin/marketplace.json` | Plugin catalog — source of truth for which plugins this hub provides |
| `plugins/` | Local plugin wrappers for upstream skill files that lack a plugin manifest |
| `mcp/mcp.json` | MCP server definitions merged into Claude Desktop and Claude Code CLI |
| `setup-desktop.sh` | Reads `mcp/mcp.json`, wires Desktop config, prints CLI commands |

## Maintenance

See [CONTRIBUTING.md](CONTRIBUTING.md) to add plugins, skills, or MCP servers.
