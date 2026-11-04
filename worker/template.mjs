// Railway 订阅端点（Cloudflare Worker）
// 构建：worker/build_worker.py 会把 sub/ 下的文件内联进来
const SECRET = "__SECRET__";
const USERINFO = "__USERINFO__";
const FILES = __FILES__;

export default {
  async fetch(request) {
    const url = new URL(request.url);
    const p = url.pathname.replace(/^\/+/, "");
    const idx = p.indexOf("/");
    if (idx < 0) return new Response("Not Found\n", { status: 404 });
    const token = p.slice(0, idx);
    const name = p.slice(idx + 1);
    if (token !== SECRET) return new Response("Not Found\n", { status: 404 });
    const body = FILES[name];
    if (!body) return new Response("Not Found\n", { status: 404 });
    const type = name.endsWith(".yaml") ? "text/yaml; charset=utf-8" : "text/plain; charset=utf-8";
    return new Response(request.method === "HEAD" ? null : body, {
      headers: {
        "Content-Type": type,
        "Subscription-Userinfo": USERINFO,
        "Profile-Update-Interval": "12",
        "Cache-Control": "no-store",
        "Access-Control-Allow-Origin": "*",
      },
    });
  },
};
