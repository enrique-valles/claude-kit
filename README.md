# claude-hub

Personal plugin marketplace and MCP configuration hub for Claude Code and Claude Desktop.

Clone this repo on any machine, run one script, and get full plugin and MCP parity across all your Claude setups.

## What's included

### Plugins (Claude Code CLI)

Plugins bundle skills, agents, hooks, and MCP servers into installable units. Each plugin listed here is fetched from its upstream source when installed — nothing is copied into this repo except `frontend-design`, which needs a local wrapper because the upstream only ships a raw skill file.

| Plugin | What it provides | Source |
|---|---|---|
| `superpowers` | Skills for AI coding workflows (TDD, debugging, planning, code review…) | [obra/superpowers](https://github.com/obra/superpowers) |
| `frontend-design` | Skill for distinctive, production-grade UI — avoids generic AI aesthetics | [anthropics/skills](https://github.com/anthropics/skills/tree/main/skills/frontend-design) |
| `ui-ux-pro-max` | AI design intelligence — 67 styles, 161 palettes, 57 font pairings | [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) |

### Skills

Skills are model-invoked instructions inside a plugin. They activate automatically based on context — no slash command needed. The plugins above bundle the following skills:

| Skill | Plugin | When it activates |
|---|---|---|
| `frontend-design` | `frontend-design` | Building web components, pages, or any UI |
| `superpowers:*` | `superpowers` | Various — see [superpowers docs](https://github.com/obra/superpowers) |
| `ui-ux-pro-max:*` | `ui-ux-pro-max` | Design system generation and UI work |

To add a standalone skill (one not tied to an existing plugin), see [CONTRIBUTING.md](CONTRIBUTING.md).

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

Get a token at [github.com/settings/tokens](https://github.com/settings/tokens).

- **Claude Desktop**: after running `setup-desktop.sh`, edit `~/Library/Application Support/Claude/claude_desktop_config.json` and replace `YOUR_GITHUB_TOKEN`
- **Claude Code CLI**: the setup script prompts you to enter your token interactively when configuring the `github` MCP (leave blank to skip and add it later)

## Updating

```bash
git pull
./setup-desktop.sh    # re-run if MCP configs changed
```

For plugin updates in Claude Code:
```
/plugin marketplace update quique-claude-hub
/plugin update superpowers@quique-claude-hub
/plugin update frontend-design@quique-claude-hub
/plugin update ui-ux-pro-max@quique-claude-hub
```

## Compatibility

| App | Plugins | MCPs |
|---|---|---|
| Claude Code CLI | ✅ via marketplace | ✅ via `claude mcp add` |
| Claude Desktop | ❌ no plugin system | ✅ via `setup-desktop.sh` |
| Claude Web | ❌ | ❌ |

## Maintenance

See [CONTRIBUTING.md](CONTRIBUTING.md) for how to add plugins, skills, and MCP servers.
