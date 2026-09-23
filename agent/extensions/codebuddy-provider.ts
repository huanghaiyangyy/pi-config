import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

/**
 * Dynamic CodeBuddy Provider Extension for Pi
 *
 * Fetches models dynamically from local CodeBuddy2API (http://127.0.0.1:8001/v1/models)
 * with accurate upstream context windows (1M tokens) and output limits.
 */
export default async function (pi: ExtensionAPI) {
  const baseUrl = process.env.CODEBUDDY_BASE_URL || "http://127.0.0.1:8001/v1";
  const apiKey = process.env.CODEBUDDY_API_KEY || "YOUR_API_KEY";

  async function syncModels() {
    try {
      const res = await fetch(`${baseUrl}/models`, {
        headers: { Authorization: `Bearer ${apiKey}` },
        signal: AbortSignal.timeout(2500),
      });
      if (!res.ok) return false;
      const data = (await res.json()) as { data?: any[] };
      const list = Array.isArray(data?.data) ? data.data : [];
      if (!list.length) return false;

      const models = list
        .filter((m: any) => m.id !== "auto")
        .map((m: any) => ({
          id: m.id,
          name: m.display_name || m.id,
          reasoning: m.supports_reasoning ?? true,
          input: ["text"],
          cost: { input: 0, output: 0, cacheRead: 0, cacheWrite: 0 },
          contextWindow: m.context_window || 1000000,
          maxTokens: m.max_tokens || 32000,
        }));

      pi.registerProvider("codebuddy", {
        name: "CodeBuddy",
        baseUrl,
        apiKey,
        api: "openai-completions",
        compat: {
          supportsUsageInStreaming: true,
          supportsDeveloperRole: false,
          maxTokensField: "max_tokens",
        },
        models,
      });
      return true;
    } catch {
      return false;
    }
  }

  await syncModels();

  pi.registerCommand("codebuddy-sync", {
    description: "从本地 CodeBuddy2API 动态同步最新模型与上下文窗口",
    handler: async (_args, ctx) => {
      const ok = await syncModels();
      if (ok) {
        ctx.ui.notify("info", "已成功从 CodeBuddy2API 动态同步最新模型与上下文窗口！");
      } else {
        ctx.ui.notify("error", "同步失败，请检查 CodeBuddy2API 服务是否正常运行。");
      }
    },
  });
}
