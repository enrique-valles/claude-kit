# Claude Hub — Design Spec

**Date:** 2026-05-04  
**Status:** Approved by user

---

## Goal

A single git repository that acts as a personal plugin marketplace and MCP configuration hub for Claude. Cloning it on any machine and running one setup script gives full plugin and MCP parity across Claude Code CLI and Claude Desktop.

---

## Scope

- Plugin catalog for Claude Code CLI (3 plugins)
- MCP server configuration for Claude Code CLI and Claude Desktop (2 servers)
- Setup script for Desktop MCP wiring
- README with usage instructions

Claude Web is out of scope — no extension API exists.

---

## Repository Structure

```
claude-hub/
├── .claude-plugin/
│   └── marketplace.json          # Plugin catalog (remote sources)
├── plugins/
│   └── frontend-design/          # Thin wrapper — upstream is just a SKILL.md, no plugin.json
│       ├── .claude-plugin/
│       │   └── plugin.json
│       └── skills/
│           └── frontend-design/
│               └── SKILL.md
├── mcp/
│   └── mcp.json                  # MCP server definitions (context7 + github)
├── setup-desktop.sh              # Merges mcp/mcp.json into Claude Desktop config
└── README.md
```

---

## Plugin Catalog

**File:** `.claude-plugin/marketplace.json`

Three plugins. Two use remote GitHub sources; one (`frontend-design`) lives locally because the upstream repo (`anthropics/skills`) only provides a raw `SKILL.md` with no Claude plugin structure — a local wrapper is the only way to make it installable.

| Plugin | Source type | Upstream |
|---|---|---|
| `superpowers` | `github` | `obra/superpowers` |
| `frontend-design` | local (`./plugins/frontend-design`) | `anthropics/skills` (SKILL.md only) |
| `ui-ux-pro-max` | `github` | `nextlevelbuilder/ui-ux-pro-max-skill` |

```json
{
  "name": "quique-claude-hub",
  "owner": { "name": "Enrique" },
  "plugins": [
    {
      "name": "superpowers",
      "source": { "source": "github", "repo": "obra/superpowers" },
      "description": "Composable skills and instructions for AI coding agents"
    },
    {
      "name": "frontend-design",
      "source": "./plugins/frontend-design",
      "description": "Frontend design skill for distinctive, production-grade UI"
    },
    {
      "name": "ui-ux-pro-max",
      "source": { "source": "github", "repo": "nextlevelbuilder/ui-ux-pro-max-skill" },
      "description": "AI design intelligence: 67 UI styles, 161 palettes, 57 font pairings"
    }
  ]
}
```

---

## frontend-design Wrapper Plugin

**Why local:** `anthropics/skills/skills/frontend-design/` contains only `SKILL.md` and `LICENSE.txt` — no `.claude-plugin/plugin.json`. Without it, Claude Code cannot install it as a plugin. The wrapper adds the minimal manifest and places the skill at the correct path.

**`plugins/frontend-design/.claude-plugin/plugin.json`:**
```json
{
  "name": "frontend-design",
  "description": "Frontend design skill for distinctive, production-grade UI",
  "version": "1.0.0",
  "author": { "name": "Anthropic" }
}
```

**`plugins/frontend-design/skills/frontend-design/SKILL.md`:** Content copied verbatim from `anthropics/skills`. Update manually when upstream changes.

---

## MCP Servers

**File:** `mcp/mcp.json`

Two servers. `GITHUB_PERSONAL_ACCESS_TOKEN` is left as a placeholder — each user supplies their own token.

```json
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"]
    },
    "github": {
      "command": "docker",
      "args": [
        "run", "-i", "--rm",
        "-e", "GITHUB_PERSONAL_ACCESS_TOKEN",
        "ghcr.io/github/github-mcp-server"
      ],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "YOUR_GITHUB_TOKEN"
      }
    }
  }
}
```

---

## setup-desktop.sh

Adds the MCP servers from `mcp/mcp.json` to the Claude Desktop config. Runs on macOS (primary) and Linux.

**Steps:**
1. Detect OS and resolve config path (`~/Library/Application Support/Claude/claude_desktop_config.json` on macOS, `~/.config/Claude/claude_desktop_config.json` on Linux)
2. Create config file if it doesn't exist
3. Backup existing config to `<config>.bak`
4. Merge `mcp/mcp.json` into existing config using Python3 (no extra deps)
5. Print confirmation and remind user to set `GITHUB_PERSONAL_ACCESS_TOKEN`

Also prints the `claude mcp add` commands for Claude Code CLI so users can apply MCPs there too (Claude Code CLI MCPs are scoped per-user via `claude mcp add -s user`).

---

## README

Covers:
- What this repo is
- How to add the marketplace in Claude Code CLI: `/plugin marketplace add quiquevalles15/claude-hub`
- How to install each plugin: `/plugin install <name>@quique-claude-hub`
- How to run `setup-desktop.sh` for Desktop MCPs
- How to add MCPs to Claude Code CLI manually
- Note: Claude Web not supported

---

## What is NOT in scope

- Any MCP server authentication flows (user handles tokens)
- Automatic updates of the `frontend-design` SKILL.md from upstream
- Claude Web support
