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

read -r -p "   Run these claude mcp add commands now? [y/N] " reply || true
if [[ "$(echo "$reply" | tr '[:upper:]' '[:lower:]')" == "y" ]]; then
  echo ""
  echo "   Adding context7..."
  claude mcp add context7 -s user -- npx -y @upstash/context7-mcp
  echo "   context7 added."
  echo ""
  read -r -p "   Enter your GitHub token for the github MCP (leave blank to skip): " gh_token || true
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
