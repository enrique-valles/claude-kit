# claude-hub

Personal plugin marketplace and MCP configuration hub for Claude Code and Claude Desktop.

Clone this repo on any machine, run one script, and get full plugin and MCP parity across all your Claude setups.

## What's included

### Plugins (Claude Code CLI)

| Plugin | Description | Source |
|---|---|---|
| `superpowers` | Composable skills for AI coding agents | [obra/superpowers](https://github.com/obra/superpowers) |
| `frontend-design` | Distinctive, production-grade UI skill | [anthropics/skills](https://github.com/anthropics/skills/tree/main/skills/frontend-design) |
| `ui-ux-pro-max` | AI design intelligence — 67 styles, 161 palettes | [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) |

### MCP Servers (Claude Code CLI + Claude Desktop)

| Server | Description |
|---|---|
| `context7` | Up-to-date library docs in context |
| `github` | GitHub API access (issues, PRs, repos) |

## Setup on a new machine

### 1. Clone the repo

```bash
git clone https://github.com/quiquevalles15/claude-hub
cd claude-hub
```

### 2. Run setup script

```bash
chmod +x setup-desktop.sh
./setup-desktop.sh
```

This:
- Merges MCP servers into Claude Desktop config (`~/Library/Application Support/Claude/claude_desktop_config.json` on macOS)
- Prompts to add MCPs to Claude Code CLI via `claude mcp add`
- Prints plugin install commands

### 3. Add the marketplace in Claude Code

```
/plugin marketplace add quiquevalles15/claude-hub
```

### 4. Install plugins

```
/plugin install superpowers@quique-claude-hub
/plugin install frontend-design@quique-claude-hub
/plugin install ui-ux-pro-max@quique-claude-hub
```

### 5. Set your GitHub token

Edit `~/Library/Application Support/Claude/claude_desktop_config.json` and replace `YOUR_GITHUB_TOKEN` with a token from [github.com/settings/tokens](https://github.com/settings/tokens).

## Updating

```bash
git pull
./setup-desktop.sh    # re-run if MCP configs changed
```

For plugin updates in Claude Code:
```
/plugin marketplace update quique-claude-hub
/plugin update superpowers@quique-claude-hub
```

## Compatibility

| App | Plugins | MCPs |
|---|---|---|
| Claude Code CLI | ✅ via marketplace | ✅ via `claude mcp add` |
| Claude Desktop | ❌ no plugin system | ✅ via `setup-desktop.sh` |
| Claude Web | ❌ | ❌ |

## Adding more plugins

Edit `.claude-plugin/marketplace.json` and add an entry under `plugins`. Use `"source": { "source": "github", "repo": "owner/repo" }` for GitHub repos, or `"./plugins/my-plugin"` for local wrappers when the upstream repo lacks a plugin manifest.

## Adding more MCP servers

Add entries to `mcp/mcp.json` under `mcpServers`, then re-run `./setup-desktop.sh`.
