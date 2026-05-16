# Claude Hub

This repo is a personal plugin marketplace and MCP configuration hub for Claude Code CLI. It keeps plugins, skills, and MCP servers in sync across machines.

## When asked to set up this hub

Run these steps in order. Ask before skipping any step.

**Step 1 — Add this repo as a Claude Code marketplace**

```
/plugin marketplace add enrique-valles/claude-kit
```

**Step 2 — Install all plugins**

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

**Step 2b — Install skills via skills CLI**

```bash
npx skills add vercel-labs/agent-skills@vercel-react-best-practices -g -y
```

**Step 3 — Add MCP servers**

```bash
claude mcp add --transport http figma https://mcp.figma.com/mcp

claude mcp add -s user context-mode -- npx -y context-mode

claude mcp add context7 -s user -- npx -y @upstash/context7-mcp

claude mcp add github -s user \
  -e GITHUB_PERSONAL_ACCESS_TOKEN=YOUR_GITHUB_TOKEN \
  -- docker run -i --rm -e GITHUB_PERSONAL_ACCESS_TOKEN ghcr.io/github/github-mcp-server

claude mcp add magic -s user \
  -e API_KEY=YOUR_21ST_DEV_API_KEY \
  -- npx -y @21st-dev/magic@latest
```

Remind the user to replace `YOUR_GITHUB_TOKEN` with a real token from [github.com/settings/tokens](https://github.com/settings/tokens).

Get a 21st.dev API key at [21st.dev/magic/console](https://21st.dev/magic/console). Use `/ui <description>` in chat to generate UI components.

To authenticate Figma MCP, run `claude mcp add --transport http figma https://mcp.figma.com/mcp` then open Claude and authorize via the OAuth prompt.

---

## Repo layout

| Path | Purpose |
|---|---|
| `.claude-plugin/marketplace.json` | Plugin catalog — source of truth for which plugins this hub provides |
| `plugins/` | Local plugin wrappers for upstream skill files that lack a plugin manifest |
| `mcp/mcp.json` | MCP server definitions for reference (apply via `claude mcp add`) |

## Maintenance

See [CONTRIBUTING.md](CONTRIBUTING.md) to add plugins, skills, or MCP servers.
