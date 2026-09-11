#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PI_DIR="${HOME}/.pi"
PI_AGENT_DIR="${HOME}/.pi/agent"
PI_CONFIG_DIR="${HOME}/.config/pi"

echo "==> Deploying Pi configurations..."

mkdir -p "${PI_AGENT_DIR}/extensions"
mkdir -p "${PI_AGENT_DIR}/themes"
mkdir -p "${PI_AGENT_DIR}/npm"
mkdir -p "${PI_CONFIG_DIR}"

# Copy core configurations
cp "${SCRIPT_DIR}/agent/settings.json" "${PI_AGENT_DIR}/"
cp "${SCRIPT_DIR}/agent/APPEND_SYSTEM.md" "${PI_AGENT_DIR}/"
cp "${SCRIPT_DIR}/agent/open-tui.json" "${PI_AGENT_DIR}/"
cp "${SCRIPT_DIR}/agent/openai-server-compaction.json" "${PI_AGENT_DIR}/"

# Copy themes and extensions
cp -r "${SCRIPT_DIR}/agent/themes/"* "${PI_AGENT_DIR}/themes/"
cp -r "${SCRIPT_DIR}/agent/extensions/"* "${PI_AGENT_DIR}/extensions/"

# Copy web-search configuration
cp "${SCRIPT_DIR}/config/web-search.json" "${PI_CONFIG_DIR}/"

# Package dependencies
cp "${SCRIPT_DIR}/agent/npm/package.json" "${PI_AGENT_DIR}/npm/"

echo "==> Installing npm packages for Pi extensions..."
(cd "${PI_AGENT_DIR}/npm" && npm install)

# Check models.json & auth.json
if [ ! -f "${PI_AGENT_DIR}/models.json" ]; then
  echo "==> Notice: ${PI_AGENT_DIR}/models.json not found."
  echo "    You can copy ${SCRIPT_DIR}/agent/models.json.example to ${PI_AGENT_DIR}/models.json and fill in your keys."
fi

if [ ! -f "${PI_AGENT_DIR}/auth.json" ]; then
  echo "==> Notice: ${PI_AGENT_DIR}/auth.json not found."
  echo "    You can copy ${SCRIPT_DIR}/agent/auth.json.example to ${PI_AGENT_DIR}/auth.json and fill in your keys."
fi

echo "==> Setup completed successfully!"
