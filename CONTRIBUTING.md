# Maintenance Guide

How to add, update, and remove plugins, skills, and MCP servers in this hub.

---

## Repo structure at a glance

```
claude-hub/
├── .claude-plugin/
│   └── marketplace.json      ← plugin catalog (edit this to add/remove plugins)
├── plugins/
│   └── frontend-design/      ← local wrapper plugins (only needed when upstream lacks plugin.json)
│       ├── .claude-plugin/
│       │   └── plugin.json   ← plugin manifest
│       └── skills/
│           └── frontend-design/
│               └── SKILL.md  ← skill instructions (update from upstream manually)
├── mcp/
│   └── mcp.json              ← MCP server definitions (edit this to add/remove MCPs)
└── setup-desktop.sh          ← reads mcp.json, wires Desktop + CLI
```

---

## Adding a plugin

### From a GitHub repo (recommended)

If the plugin has a `.claude-plugin/plugin.json` at its repo root, add a GitHub source entry to `.claude-plugin/marketplace.json`:

```json
{
  "name": "my-plugin",
  "source": { "source": "github", "repo": "owner/repo" },
  "description": "What this plugin does",
  "homepage": "https://github.com/owner/repo"
}
```

Then install it in Claude Code:

```
/plugin install my-plugin@quique-claude-hub
```

### As a local wrapper (when upstream has no plugin manifest)

If the upstream repo only provides a raw skill file with no `.claude-plugin/plugin.json` (like `anthropics/skills`), create a wrapper:

1. **Create the directory structure:**

```
plugins/my-plugin/
├── .claude-plugin/
│   └── plugin.json
└── skills/
    └── my-skill/
        └── SKILL.md
```

2. **Write `plugins/my-plugin/.claude-plugin/plugin.json`:**

```json
{
  "name": "my-plugin",
  "description": "Short description",
  "version": "1.0.0",
  "author": { "name": "Original Author" },
  "homepage": "https://upstream-url",
  "license": "MIT"
}
```

3. **Copy the upstream `SKILL.md` verbatim** into `plugins/my-plugin/skills/my-skill/SKILL.md`.

4. **Add a local source entry to `.claude-plugin/marketplace.json`:**

```json
{
  "name": "my-plugin",
  "source": "./plugins/my-plugin",
  "description": "What this plugin does",
  "homepage": "https://upstream-url"
}
```

---

## Adding a standalone skill

A standalone skill is one you write yourself, not sourced from an upstream repo. Add it to an existing local plugin wrapper or create a new one.

**Add to an existing wrapper** (e.g., group personal skills under one plugin):

1. Create `plugins/my-skills/skills/new-skill/SKILL.md`
2. Write the skill instructions in the file (see [Claude Code Skills docs](https://code.claude.com/docs/en/skills))
3. If `plugins/my-skills/` doesn't exist yet, create the wrapper first (see above)
4. Add or update the marketplace entry

Skills activate automatically when their `description` in the frontmatter matches what Claude is doing. Example `SKILL.md` frontmatter:

```markdown
---
name: my-skill
description: When to use this skill — be specific so Claude activates it at the right time.
---

Skill instructions here…
```

---

## Updating the frontend-design skill

The `frontend-design` SKILL.md is a manual copy from upstream (`anthropics/skills`). There is no auto-sync. To update:

1. Check the upstream file: [anthropics/skills/skills/frontend-design/SKILL.md](https://github.com/anthropics/skills/blob/main/skills/frontend-design/SKILL.md)
2. Copy the new content into `plugins/frontend-design/skills/frontend-design/SKILL.md`
3. Bump `version` in `plugins/frontend-design/.claude-plugin/plugin.json`
4. Commit and push
5. Run `/plugin update frontend-design@quique-claude-hub` in Claude Code

---

## Adding an MCP server

1. **Add the server definition to `mcp/mcp.json`** under `mcpServers`:

```json
"my-server": {
  "command": "npx",
  "args": ["-y", "my-mcp-package"]
}
```

For servers requiring auth, use a placeholder token and document it:

```json
"my-server": {
  "command": "npx",
  "args": ["-y", "my-mcp-package"],
  "env": { "MY_API_KEY": "YOUR_KEY_HERE" }
}
```

2. **Re-run `./setup-desktop.sh`** to merge the new server into Claude Desktop's config. Existing servers are preserved — the merge is additive.

3. **For Claude Code CLI**, run:

```bash
claude mcp add my-server -s user -- npx -y my-mcp-package
```

---

## Removing a plugin

1. Remove the entry from `.claude-plugin/marketplace.json`
2. If it has a local wrapper, delete the `plugins/<name>/` directory
3. In Claude Code: `/plugin uninstall <name>@quique-claude-hub`

## Removing an MCP server

1. Remove the entry from `mcp/mcp.json`
2. Manually remove it from `~/Library/Application Support/Claude/claude_desktop_config.json` (Desktop)
3. For Claude Code CLI: `claude mcp remove <name>`
