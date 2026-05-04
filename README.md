# claude-hub

Personal plugin marketplace and MCP configuration hub for Claude Code CLI.

Clone this repo on any machine and follow the setup steps to get full plugin and MCP parity across all your Claude Code setups.

## What's included

### Plugins

Plugins bundle skills, agents, hooks, and MCP servers into installable units. Each plugin listed here is fetched from its upstream source when installed — nothing is copied into this repo except `frontend-design`, which needs a local wrapper because the upstream only ships a raw skill file.

| Plugin | What it provides | Source |
|---|---|---|
| `superpowers` | Skills for AI coding workflows (TDD, debugging, planning, code review…) | [obra/superpowers](https://github.com/obra/superpowers) |
| `frontend-design` | Skill for distinctive, production-grade UI — avoids generic AI aesthetics | [anthropics/skills](https://github.com/anthropics/skills/tree/main/skills/frontend-design) |
| `ui-ux-pro-max` | AI design intelligence — 67 styles, 161 palettes, 57 font pairings | [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) |
| `caveman` | Token-compression skill — cuts ~75% of output tokens using abbreviated caveman-style language | [juliusbrussee/caveman](https://github.com/juliusbrussee/caveman) |
| `diagnose` | Disciplined 6-phase debugging methodology: feedback loop → reproduce → hypothesise → instrument → fix → post-mortem | [mattpocock/skills](https://github.com/mattpocock/skills/tree/main/skills/engineering/diagnose) |
| `grill-me` | Relentless plan interview — walks every decision branch one question at a time | [mattpocock/skills](https://github.com/mattpocock/skills/tree/main/skills/productivity/grill-me) |
| `zoom-out` | Maps all relevant modules and callers for unfamiliar code, one abstraction level up | [mattpocock/skills](https://github.com/mattpocock/skills/tree/main/skills/engineering/zoom-out) |

### Skills

Skills are model-invoked instructions inside a plugin. They activate automatically based on context — no slash command needed. The plugins above bundle the following skills:

| Skill | Plugin | When it activates |
|---|---|---|
| `frontend-design` | `frontend-design` | Building web components, pages, or any UI |
| `superpowers:*` | `superpowers` | Various — see [superpowers docs](https://github.com/obra/superpowers) |
| `ui-ux-pro-max:*` | `ui-ux-pro-max` | Design system generation and UI work |
| `caveman:*` | `caveman` | Token reduction — activate manually or ask Claude to use caveman mode |
| `diagnose` | `diagnose` | Bug reports, "debug this", performance regressions |
| `grill-me` | `grill-me` | "Grill me on this plan", stress-testing a design |
| `zoom-out` | `zoom-out` | Unfamiliar code area, "how does this fit together" |

To add a standalone skill (one not tied to an existing plugin), see [CONTRIBUTING.md](CONTRIBUTING.md).

### MCP Servers

| Server | Description |
|---|---|
| `context7` | Up-to-date library docs in context |
| `github` | GitHub API access (issues, PRs, repos) |

---

## Setup on a new machine

### 1. Add the marketplace

```
/plugin marketplace add quiquevalles15/claude-hub
```

### 2. Install plugins

```
/plugin install superpowers@quique-claude-hub
/plugin install frontend-design@quique-claude-hub
/plugin install ui-ux-pro-max@quique-claude-hub
/plugin install caveman@quique-claude-hub
/plugin install diagnose@quique-claude-hub
/plugin install grill-me@quique-claude-hub
/plugin install zoom-out@quique-claude-hub
```

### 3. Add MCP servers

```bash
claude mcp add context7 -s user -- npx -y @upstash/context7-mcp

claude mcp add github -s user \
  -e GITHUB_PERSONAL_ACCESS_TOKEN=YOUR_GITHUB_TOKEN \
  -- docker run -i --rm -e GITHUB_PERSONAL_ACCESS_TOKEN ghcr.io/github/github-mcp-server
```

Replace `YOUR_GITHUB_TOKEN` with a token from [github.com/settings/tokens](https://github.com/settings/tokens).

---

## Updating

```bash
git pull
```

Then in Claude Code:

```
/plugin marketplace update quique-claude-hub
/plugin update superpowers@quique-claude-hub
/plugin update frontend-design@quique-claude-hub
/plugin update ui-ux-pro-max@quique-claude-hub
/plugin update caveman@quique-claude-hub
/plugin update diagnose@quique-claude-hub
/plugin update grill-me@quique-claude-hub
/plugin update zoom-out@quique-claude-hub
```

---

## Maintenance

See [CONTRIBUTING.md](CONTRIBUTING.md) for how to add plugins, skills, and MCP servers.
