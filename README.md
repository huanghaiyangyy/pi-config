# Pi Coding Agent Configuration & Extensions

Personal configuration, plugins, themes, and extensions for [Pi Coding Agent](https://github.com/earendil-works/pi-coding-agent).

> **Security Note**: This repository does not contain any API keys, endpoints, authentication tokens, or personal session histories. All credentials should be provided via local environment variables or untracked local files.

---

## 📦 What's Included

- **Core Settings (`agent/settings.json`)**:
  - Model defaults & Subagent routing (Oracle, Reviewer, Scout, Worker)
  - Compaction settings & package declarations
- **Extensions (`agent/extensions/`)**:
  - `ask-user-question.ts`: Interactive confirmation and multi-choice question tool
  - `cpa-provider.ts`: CPA provider extension (reads `CPA_BASE_URL` and `CPA_API_KEY`)
  - `codebuddy-provider.ts`: CodeBuddy provider extension (reads `CODEBUDDY_BASE_URL` and `CODEBUDDY_API_KEY`)
- **UI & Theme**:
  - `agent/themes/catppuccin-mocha.json`: Custom Catppuccin Mocha theme
  - `agent/open-tui.json`: Nerd font icons, status footer, telemetry metrics
- **Plugins (`agent/npm/package.json`)**:
  - `pi-subagents`, `context-mode`, `pi-antigravity`, `pi-open-tui`, `pi-web-access`, `@juicesharp/rpiv-todo`, `@narumitw/pi-btw`, `@heathhe/pi-agent-notify`, `pi-mcp-adapter`
- **Server Compaction**: `agent/openai-server-compaction.json`
- **Web Search**: `config/web-search.json`

---

## 🚀 Installation / Quick Start

### 1. Clone Repository
```bash
git clone https://github.com/huanghaiyangyy/pi-config.git ~/pi-config
cd ~/pi-config
```

### 2. Run Setup Script
```bash
./setup.sh
```

### 3. Configure Credentials (Locally)

Export environment variables in your shell (`~/.zshrc` or `~/.bashrc`):
```bash
export CPA_BASE_URL="http://your-cpa-server:port/v1"
export CPA_API_KEY="your-api-key"
```

Or copy the examples to create local, untracked configuration files:
```bash
cp agent/models.json.example ~/.pi/agent/models.json
cp agent/auth.json.example ~/.pi/agent/auth.json
# Edit ~/.pi/agent/models.json and ~/.pi/agent/auth.json with your actual keys
```
