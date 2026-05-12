# claude-kit

Personal plugin marketplace and MCP configuration hub for Claude Code CLI.

Clone this repo on any machine and follow the setup steps to get full plugin and MCP parity across all your Claude Code setups.

## What's included

### Plugins

| Plugin | What it provides | Source |
|---|---|---|
| `superpowers` | Skills for AI coding workflows (TDD, debugging, planning, code review…) | [obra/superpowers](https://github.com/obra/superpowers) |
| `frontend-design` | Skill for distinctive, production-grade UI — avoids generic AI aesthetics | [anthropics/skills](https://github.com/anthropics/skills/tree/main/skills/frontend-design) |
| `ui-ux-pro-max` | AI design intelligence — 67 styles, 161 palettes, 57 font pairings | [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) |
| `caveman` | Token-compression skill — cuts ~75% of output tokens using abbreviated caveman-style language | [juliusbrussee/caveman](https://github.com/juliusbrussee/caveman) |
| `diagnose` | Disciplined 6-phase debugging methodology: reproduce → hypothesise → instrument → fix → post-mortem | [mattpocock/skills](https://github.com/mattpocock/skills/tree/main/skills/engineering/diagnose) |
| `grill-me` | Relentless plan interview — walks every decision branch one question at a time | [mattpocock/skills](https://github.com/mattpocock/skills/tree/main/skills/productivity/grill-me) |
| `zoom-out` | Maps all relevant modules and callers for unfamiliar code, one abstraction level up | [mattpocock/skills](https://github.com/mattpocock/skills/tree/main/skills/engineering/zoom-out) |
| `claude-mem` | Persistent memory across Claude sessions (bundles its own MCP worker) | [thedotmack/claude-mem](https://github.com/thedotmack/claude-mem) |
| `pr-review-toolkit` | 6 specialized PR review agents (comment accuracy, test coverage, error handling, type design, code quality, simplification) | [anthropics/claude-code](https://github.com/anthropics/claude-code/tree/main/plugins/pr-review-toolkit) |

### Skills (via skills CLI)

| Skill | Install count | What it provides |
|---|---|---|
| `vercel-react-best-practices` | 391K | 70-rule React/Next.js performance guide from Vercel Engineering |

### MCP Servers

| Server | Transport | Description |
|---|---|---|
| `figma` | HTTP | Figma design context in AI workflows (requires OAuth) |
| `context-mode` | stdio | Reduces context window usage by ~98% via sandboxed execution |
| `context7` | stdio | Up-to-date library docs in context |
| `github` | stdio | GitHub API access — issues, PRs, repos, code search (requires Docker + token) |

---

## Setup on a new machine

### 1. Add the marketplace

```
/plugin marketplace add enrique-valles/claude-kit
```

### 2. Install plugins

```
/plugin install superpowers@claude-kit
/plugin install frontend-design@claude-kit
/plugin install ui-ux-pro-max@claude-kit
/plugin install caveman@claude-kit
/plugin install diagnose@claude-kit
/plugin install grill-me@claude-kit
/plugin install zoom-out@claude-kit

# claude-mem: only marketplace add works (no plugin install step)
/plugin marketplace add thedotmack/claude-mem

# pr-review-toolkit: 6 specialized PR review agents from Anthropic
/plugin marketplace add anthropics/claude-code
/plugin install pr-review-toolkit@claude-code
```

### 2b. Install skills via skills CLI

```bash
npx skills add vercel-labs/agent-skills@vercel-react-best-practices -g -y
```

### 3. Add MCP servers

```bash
claude mcp add --transport http figma https://mcp.figma.com/mcp

claude mcp add -s user context-mode -- npx -y context-mode

claude mcp add context7 -s user -- npx -y @upstash/context7-mcp

claude mcp add github -s user \
  -e GITHUB_PERSONAL_ACCESS_TOKEN=YOUR_GITHUB_TOKEN \
  -- docker run -i --rm -e GITHUB_PERSONAL_ACCESS_TOKEN ghcr.io/github/github-mcp-server
```

Replace `YOUR_GITHUB_TOKEN` with a token from [github.com/settings/tokens](https://github.com/settings/tokens).

To authenticate Figma MCP, open Claude after running the `mcp add` command and authorize via the OAuth prompt.

---

## Updating

```bash
git pull
```

Then in Claude Code:

```
/plugin marketplace update claude-kit
/plugin update superpowers@claude-kit
/plugin update frontend-design@claude-kit
/plugin update ui-ux-pro-max@claude-kit
/plugin update caveman@claude-kit
/plugin update diagnose@claude-kit
/plugin update grill-me@claude-kit
/plugin update zoom-out@claude-kit
/plugin update pr-review-toolkit@claude-code
```

---

## Maintenance

See [CONTRIBUTING.md](CONTRIBUTING.md) for how to add plugins, skills, and MCP servers.
