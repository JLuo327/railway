# railway-xray-nodes

Railway 自建的 **单节点** VLESS + WebSocket + TLS（国内分流），按 Railway Free（$1/月额度）方案精简。

- 项目：Railway `railway-xray`（production），仅 `Railway-美国-加州`
- 传输：VLESS + WS(path=`/tk-rail`) + TLS(443，Railway 边缘证书)
- UUID：`3eb905bc-a18a-4b40-8578-eeade9d4c67a`

| 节点名 | 区域 | 域名 |
|---|---|---|
| Railway-美国-加州 | us-west2 (sfo) | **us.1983723.xyz**（自定义域）|

## 订阅链接（本仓库 raw，固定不变）

以后新增/更换节点，只改 `sub/` 提交推送，**下面 URL 永远不变**：

| 客户端 | 链接 |
|---|---|
| Clash / mihomo / FlClash | `https://raw.githubusercontent.com/JLuo327/railway-xray-nodes/main/sub/clash.yaml` |
| Quantumult X | `https://raw.githubusercontent.com/JLuo327/railway-xray-nodes/main/sub/qx.conf` |
| Shadowrocket | `https://raw.githubusercontent.com/JLuo327/railway-xray-nodes/main/sub/shadowrocket.conf` |
| 任意客户端（节点列表） | `https://raw.githubusercontent.com/JLuo327/railway-xray-nodes/main/sub/vless.txt` |
| 同上（base64） | `https://raw.githubusercontent.com/JLuo327/railway-xray-nodes/main/sub/vless-base64.txt` |

> ⚠️ 本仓库是 **public**（raw 链接才能免登录访问）。内容含可直接使用的凭据：任何拿到链接的人都能用你的节点，GitHub 代码搜索也能搜到 `vless://`。被滥用就换 UUID（改四个服务的 `XRAY_CONFIG` + 这里的文件），或者把仓库改回 private（链接随即失效）。

## 国内分流

- Clash：`GEOSITE,cn` / `GEOIP,CN` → 国内直连；`geolocation-!cn` → 国外网站；其余 → 漏网之鱼。
- QX：`geoip, cn` → 国内直连；`final` → 漏网之鱼。
- Shadowrocket：`GEOIP,CN → DIRECT`；`FINAL → 节点选择`。

## 成本（Railway）

- Trial：$5 / 30 天（至 2026-12-05）；之后 Free：**$1/月**
- 单节点固定 ≈ **$0.60/月**，流量 $0.05/GB → Free 额度约 **8GB/月**
- 超出后服务停止，次月恢复

## 文件

```
sub/vless.txt            1 条 vless:// 链接
sub/vless-base64.txt     base64 版
sub/clash.yaml           Clash / mihomo / FlClash（含国内分流）
sub/qx.conf              Quantumult X 整份配置
sub/shadowrocket.conf    Shadowrocket 整份配置
nodes.json               节点与额度元数据
```
