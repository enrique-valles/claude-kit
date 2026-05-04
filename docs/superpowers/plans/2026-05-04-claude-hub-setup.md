# Claude Hub Setup Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Turn claude-hub into a working personal marketplace + MCP hub usable across Claude Code CLI and Claude Desktop.

**Architecture:** The repo acts as a pure catalog for Claude Code plugins (marketplace.json with remote GitHub sources) plus a local wrapper for frontend-design which lacks a plugin manifest upstream. MCP configs live in `mcp/mcp.json` and are wired to Claude Desktop via `setup-desktop.sh`, which also prints the CLI commands for Claude Code.

**Tech Stack:** JSON (marketplace/plugin manifests, MCP config), Bash (setup script), Python3 (JSON merge in setup script — no extra deps), Markdown (README, SKILL.md).

---

## File Map

| File | Action | Purpose |
|---|---|---|
| `.claude-plugin/marketplace.json` | Modify | Remote sources for superpowers + ui-ux-pro-max; local source for frontend-design |
| `plugins/frontend-design/.claude-plugin/plugin.json` | Create | Plugin manifest wrapper (upstream has none) |
| `plugins/frontend-design/skills/frontend-design/SKILL.md` | Create | SKILL.md copied verbatim from anthropics/skills |
| `mcp/mcp.json` | Create | MCP server configs for context7 + github |
| `setup-desktop.sh` | Create | Merges MCPs into Claude Desktop config; prints CLI commands |
| `README.md` | Modify | Full usage docs |

---

## Task 1: Update marketplace.json

**Files:**
- Modify: `.claude-plugin/marketplace.json`

- [ ] **Step 1: Verify current state**

```bash
cat ".claude-plugin/marketplace.json"
```

Expected: current file with local `./plugins/` sources and placeholder owner name.

- [ ] **Step 2: Validate it is valid JSON**

```bash
python3 -c "import json; json.load(open('.claude-plugin/marketplace.json')); print('valid')"
```

Expected: `valid`

- [ ] **Step 3: Write updated marketplace.json**

Replace the entire file with:

```json
{
  "name": "quique-claude-hub",
  "owner": {
    "name": "Enrique",
    "email": "quiquevalles15@gmail.com"
  },
  "description": "Personal plugin and MCP hub for Claude Code",
  "plugins": [
    {
      "name": "superpowers",
      "source": {
        "source": "github",
        "repo": "obra/superpowers"
      },
      "description": "Composable skills and instructions for AI coding agents",
      "homepage": "https://github.com/obra/superpowers"
    },
    {
      "name": "frontend-design",
      "source": "./plugins/frontend-design",
      "description": "Frontend design skill for distinctive, production-grade UI",
      "homepage": "https://github.com/anthropics/skills/tree/main/skills/frontend-design"
    },
    {
      "name": "ui-ux-pro-max",
      "source": {
        "source": "github",
        "repo": "nextlevelbuilder/ui-ux-pro-max-skill"
      },
      "description": "AI design intelligence: 67 UI styles, 161 color palettes, 57 font pairings",
      "homepage": "https://github.com/nextlevelbuilder/ui-ux-pro-max-skill"
    }
  ]
}
```

- [ ] **Step 4: Validate updated file is valid JSON**

```bash
python3 -c "import json; data=json.load(open('.claude-plugin/marketplace.json')); print(f\"OK: {len(data['plugins'])} plugins\")"
```

Expected: `OK: 3 plugins`

- [ ] **Step 5: Commit**

```bash
git add .claude-plugin/marketplace.json
git commit -m "feat: update marketplace.json with remote sources and correct owner"
```

---

## Task 2: Create frontend-design wrapper plugin

**Files:**
- Create: `plugins/frontend-design/.claude-plugin/plugin.json`
- Create: `plugins/frontend-design/skills/frontend-design/SKILL.md`

The upstream `anthropics/skills/skills/frontend-design/` directory contains only a raw `SKILL.md` with no Claude plugin manifest. This wrapper adds the minimal structure Claude Code needs to treat it as an installable plugin.

- [ ] **Step 1: Create directory structure**

```bash
mkdir -p "plugins/frontend-design/.claude-plugin"
mkdir -p "plugins/frontend-design/skills/frontend-design"
```

- [ ] **Step 2: Verify directories exist**

```bash
find plugins/frontend-design -type d
```

Expected output:
```
plugins/frontend-design
plugins/frontend-design/.claude-plugin
plugins/frontend-design/skills
plugins/frontend-design/skills/frontend-design
```

- [ ] **Step 3: Write plugin.json**

Create `plugins/frontend-design/.claude-plugin/plugin.json`:

```json
{
  "name": "frontend-design",
  "description": "Frontend design skill for distinctive, production-grade UI. Avoids generic AI aesthetics.",
  "version": "1.0.0",
  "author": {
    "name": "Anthropic"
  },
  "homepage": "https://github.com/anthropics/skills/tree/main/skills/frontend-design",
  "license": "MIT"
}
```

- [ ] **Step 4: Write SKILL.md**

Create `plugins/frontend-design/skills/frontend-design/SKILL.md` with this exact content (copied verbatim from `anthropics/skills` at commit time):

```markdown
---
name: frontend-design
description: Create distinctive, production-grade frontend interfaces with high design quality. Use this skill when the user asks to build web components, pages, artifacts, posters, or applications (examples include websites, landing pages, dashboards, React components, HTML/CSS layouts, or when styling/beautifying any web UI). Generates creative, polished code and UI design that avoids generic AI aesthetics.
license: Complete terms in LICENSE.txt
---

This skill guides creation of distinctive, production-grade frontend interfaces that avoid generic "AI slop" aesthetics. Implement real working code with exceptional attention to aesthetic details and creative choices.

The user provides frontend requirements: a component, page, application, or interface to build. They may include context about the purpose, audience, or technical constraints.

## Design Thinking

Before coding, understand the context and commit to a BOLD aesthetic direction:
- **Purpose**: What problem does this interface solve? Who uses it?
- **Tone**: Pick an extreme: brutally minimal, maximalist chaos, retro-futuristic, organic/natural, luxury/refined, playful/toy-like, editorial/magazine, brutalist/raw, art deco/geometric, soft/pastel, industrial/utilitarian, etc. There are so many flavors to choose from. Use these for inspiration but design one that is true to the aesthetic direction.
- **Constraints**: Technical requirements (framework, performance, accessibility).
- **Differentiation**: What makes this UNFORGETTABLE? What's the one thing someone will remember?

**CRITICAL**: Choose a clear conceptual direction and execute it with precision. Bold maximalism and refined minimalism both work - the key is intentionality, not intensity.

Then implement working code (HTML/CSS/JS, React, Vue, etc.) that is:
- Production-grade and functional
- Visually striking and memorable
- Cohesive with a clear aesthetic point-of-view
- Meticulously refined in every detail

## Frontend Aesthetics Guidelines

Focus on:
- **Typography**: Choose fonts that are beautiful, unique, and interesting. Avoid generic fonts like Arial and Inter; opt instead for distinctive choices that elevate the frontend's aesthetics; unexpected, characterful font choices. Pair a distinctive display font with a refined body font.
- **Color & Theme**: Commit to a cohesive aesthetic. Use CSS variables for consistency. Dominant colors with sharp accents outperform timid, evenly-distributed palettes.
- **Motion**: Use animations for effects and micro-interactions. Prioritize CSS-only solutions for HTML. Use Motion library for React when available. Focus on high-impact moments: one well-orchestrated page load with staggered reveals (animation-delay) creates more delight than scattered micro-interactions. Use scroll-triggering and hover states that surprise.
- **Spatial Composition**: Unexpected layouts. Asymmetry. Overlap. Diagonal flow. Grid-breaking elements. Generous negative space OR controlled density.
- **Backgrounds & Visual Details**: Create atmosphere and depth rather than defaulting to solid colors. Add contextual effects and textures that match the overall aesthetic. Apply creative forms like gradient meshes, noise textures, geometric patterns, layered transparencies, dramatic shadows, decorative borders, custom cursors, and grain overlays.

NEVER use generic AI-generated aesthetics like overused font families (Inter, Roboto, Arial, system fonts), cliched color schemes (particularly purple gradients on white backgrounds), predictable layouts and component patterns, and cookie-cutter design that lacks context-specific character.

Interpret creatively and make unexpected choices that feel genuinely designed for the context. No design should be the same. Vary between light and dark themes, different fonts, different aesthetics. NEVER converge on common choices (Space Grotesk, for example) across generations.

**IMPORTANT**: Match implementation complexity to the aesthetic vision. Maximalist designs need elaborate code with extensive animations and effects. Minimalist or refined designs need restraint, precision, and careful attention to spacing, typography, and subtle details. Elegance comes from executing the vision well.

Remember: Claude is capable of extraordinary creative work. Don't hold back, show what can truly be created when thinking outside the box and committing fully to a distinctive vision.
```

- [ ] **Step 5: Verify plugin structure**

```bash
find plugins/frontend-design -type f
```

Expected:
```
plugins/frontend-design/.claude-plugin/plugin.json
plugins/frontend-design/skills/frontend-design/SKILL.md
```

- [ ] **Step 6: Validate plugin.json**

```bash
python3 -c "import json; d=json.load(open('plugins/frontend-design/.claude-plugin/plugin.json')); print(f\"OK: {d['name']} v{d['version']}\")"
```

Expected: `OK: frontend-design v1.0.0`

- [ ] **Step 7: Commit**

```bash
git add plugins/
git commit -m "feat: add frontend-design wrapper plugin"
```

---

## Task 3: Create MCP server config

**Files:**
- Create: `mcp/mcp.json`

- [ ] **Step 1: Create directory**

```bash
mkdir -p mcp
```

- [ ] **Step 2: Write mcp.json**

Create `mcp/mcp.json`:

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

- [ ] **Step 3: Validate JSON**

```bash
python3 -c "import json; d=json.load(open('mcp/mcp.json')); print(f\"OK: {list(d['mcpServers'].keys())}\")"
```

Expected: `OK: ['context7', 'github']`

- [ ] **Step 4: Commit**

```bash
git add mcp/mcp.json
git commit -m "feat: add MCP server config for context7 and github"
```

---

## Task 4: Create setup-desktop.sh

**Files:**
- Create: `setup-desktop.sh`

The script merges `mcp/mcp.json` into Claude Desktop's config using Python3 (always available on macOS). It also prints the `claude mcp add` commands for Claude Code CLI, optionally running them if the user confirms.

- [ ] **Step 1: Write the script**

Create `setup-desktop.sh`:

```bash
#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MCP_SOURCE="$SCRIPT_DIR/mcp/mcp.json"

# Resolve Claude Desktop config path by OS
case "$(uname -s)" in
  Darwin) DESKTOP_CONFIG="$HOME/Library/Application Support/Claude/claude_desktop_config.json" ;;
  Linux)  DESKTOP_CONFIG="$HOME/.config/Claude/claude_desktop_config.json" ;;
  *)
    echo "Unsupported OS. Manually merge mcp/mcp.json into your Claude Desktop config."
    exit 1
    ;;
esac

echo "Claude Hub Setup"
echo "================"
echo ""

# ── Claude Desktop ──────────────────────────────────────────────────────────

echo "1. Claude Desktop MCP setup"
echo "   Config: $DESKTOP_CONFIG"
echo ""

# Ensure config directory and file exist
mkdir -p "$(dirname "$DESKTOP_CONFIG")"
if [ ! -f "$DESKTOP_CONFIG" ]; then
  echo '{}' > "$DESKTOP_CONFIG"
  echo "   Created empty config file."
fi

# Backup existing config
cp "$DESKTOP_CONFIG" "${DESKTOP_CONFIG}.bak"
echo "   Backed up existing config to ${DESKTOP_CONFIG}.bak"

# Merge mcpServers using Python3
python3 - "$DESKTOP_CONFIG" "$MCP_SOURCE" <<'PYEOF'
import sys, json

config_path, source_path = sys.argv[1], sys.argv[2]

with open(config_path) as f:
    config = json.load(f)

with open(source_path) as f:
    source = json.load(f)

config.setdefault("mcpServers", {}).update(source["mcpServers"])

with open(config_path, "w") as f:
    json.dump(config, f, indent=2)
    f.write("\n")

print(f"   Merged {len(source['mcpServers'])} MCP server(s) into config.")
PYEOF

echo ""
echo "   Done. Restart Claude Desktop to apply changes."
echo ""
echo "   IMPORTANT: Set your GitHub token before using the github MCP:"
echo "   Open $DESKTOP_CONFIG and replace YOUR_GITHUB_TOKEN with your token."
echo "   Get one at: https://github.com/settings/tokens"
echo ""

# ── Claude Code CLI ──────────────────────────────────────────────────────────

echo "2. Claude Code CLI MCP setup"
echo ""
echo "   Run these commands to add MCPs globally for Claude Code:"
echo ""
echo "   claude mcp add context7 -s user -- npx -y @upstash/context7-mcp"
echo ""
echo "   claude mcp add github -s user \\"
echo "     -e GITHUB_PERSONAL_ACCESS_TOKEN=YOUR_GITHUB_TOKEN \\"
echo "     -- docker run -i --rm -e GITHUB_PERSONAL_ACCESS_TOKEN ghcr.io/github/github-mcp-server"
echo ""

read -r -p "   Run these claude mcp add commands now? [y/N] " reply
if [[ "${reply,,}" == "y" ]]; then
  echo ""
  echo "   Adding context7..."
  claude mcp add context7 -s user -- npx -y @upstash/context7-mcp
  echo "   context7 added."
  echo ""
  read -r -p "   Enter your GitHub token for the github MCP (leave blank to skip): " gh_token
  if [ -n "$gh_token" ]; then
    claude mcp add github -s user \
      -e "GITHUB_PERSONAL_ACCESS_TOKEN=$gh_token" \
      -- docker run -i --rm -e GITHUB_PERSONAL_ACCESS_TOKEN ghcr.io/github/github-mcp-server
    echo "   github MCP added."
  else
    echo "   Skipped github MCP. Add it manually when ready."
  fi
fi

echo ""
echo "3. Claude Code plugin marketplace"
echo ""
echo "   Add this hub as a marketplace in Claude Code:"
echo "   /plugin marketplace add quiquevalles15/claude-hub"
echo ""
echo "   Then install plugins:"
echo "   /plugin install superpowers@quique-claude-hub"
echo "   /plugin install frontend-design@quique-claude-hub"
echo "   /plugin install ui-ux-pro-max@quique-claude-hub"
echo ""
echo "Setup complete."
```

- [ ] **Step 2: Make executable**

```bash
chmod +x setup-desktop.sh
```

- [ ] **Step 3: Dry-run test — verify merge logic in isolation**

```bash
python3 - <<'PYEOF'
import json, tempfile, os

# Simulate existing Claude Desktop config
existing = {"someOtherKey": "value", "mcpServers": {"existing-server": {"command": "foo"}}}
source = {"mcpServers": {"context7": {"command": "npx", "args": ["-y", "@upstash/context7-mcp"]}}}

with tempfile.NamedTemporaryFile(mode='w', suffix='.json', delete=False) as f:
    json.dump(existing, f)
    config_path = f.name

config = json.load(open(config_path))
config.setdefault("mcpServers", {}).update(source["mcpServers"])

result = json.dumps(config, indent=2)
parsed = json.loads(result)

assert "existing-server" in parsed["mcpServers"], "existing server should be preserved"
assert "context7" in parsed["mcpServers"], "context7 should be added"
assert parsed["someOtherKey"] == "value", "other keys should be preserved"
os.unlink(config_path)
print("PASS: merge logic correct — existing keys preserved, new MCPs added")
PYEOF
```

Expected: `PASS: merge logic correct — existing keys preserved, new MCPs added`

- [ ] **Step 4: Verify script is syntactically valid**

```bash
bash -n setup-desktop.sh && echo "PASS: script syntax OK"
```

Expected: `PASS: script syntax OK`

- [ ] **Step 5: Commit**

```bash
git add setup-desktop.sh
git commit -m "feat: add setup-desktop.sh for MCP wiring on Claude Desktop and CLI"
```

---

## Task 5: Write README.md

**Files:**
- Modify: `README.md`

- [ ] **Step 1: Write README.md**

Replace the entire file with:

```markdown
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
```

- [ ] **Step 2: Verify README renders correctly (spot check)**

```bash
grep -c "^##" README.md
```

Expected: `7` (seven `##` sections)

- [ ] **Step 3: Commit**

```bash
git add README.md
git commit -m "docs: write README with full setup instructions"
```

---

## Task 6: Final validation and cleanup

- [ ] **Step 1: Verify full file tree**

```bash
find . -not -path "*/.git/*" -not -path "*/node_modules/*" | sort
```

Expected output includes:
```
./.claude-plugin/marketplace.json
./docs/superpowers/plans/2026-05-04-claude-hub-setup.md
./docs/superpowers/specs/2026-05-04-claude-hub-design.md
./mcp/mcp.json
./plugins/frontend-design/.claude-plugin/plugin.json
./plugins/frontend-design/skills/frontend-design/SKILL.md
./README.md
./setup-desktop.sh
```

- [ ] **Step 2: Validate all JSON files**

```bash
for f in .claude-plugin/marketplace.json plugins/frontend-design/.claude-plugin/plugin.json mcp/mcp.json; do
  python3 -c "import json; json.load(open('$f')); print(f'OK: $f')"
done
```

Expected:
```
OK: .claude-plugin/marketplace.json
OK: plugins/frontend-design/.claude-plugin/plugin.json
OK: mcp/mcp.json
```

- [ ] **Step 3: Confirm setup-desktop.sh is executable**

```bash
[ -x setup-desktop.sh ] && echo "OK: setup-desktop.sh is executable"
```

Expected: `OK: setup-desktop.sh is executable`

- [ ] **Step 4: Verify git log shows all commits**

```bash
git log --oneline
```

Expected: at least 5 commits since the brainstorm started (marketplace, frontend-design plugin, mcp config, setup script, README).

- [ ] **Step 5: Commit docs**

```bash
git add docs/
git commit -m "docs: add design spec and implementation plan"
```

---

## Self-Review

**Spec coverage:**
- ✅ marketplace.json updated with remote sources — Task 1
- ✅ frontend-design local wrapper — Task 2
- ✅ mcp/mcp.json with context7 + github — Task 3
- ✅ setup-desktop.sh (Desktop merge + CLI commands, interactive) — Task 4
- ✅ README with full instructions — Task 5
- ✅ setup-desktop.sh also handles CLI MCP setup interactively (spec adjustment: run commands, not just print)

**Placeholder scan:** No TBDs, no "implement later", no vague steps. Every code block is complete.

**Type consistency:** No shared types across tasks — all standalone config/script files.

**Edge cases handled in setup-desktop.sh:**
- Missing Desktop config file → creates it
- Existing Desktop config → backs up before merge
- Existing mcpServers in config → preserved, new ones merged in (not overwritten)
- User skips github token → graceful skip message
