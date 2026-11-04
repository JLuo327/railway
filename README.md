# railway-xray-nodes

Railway 自建的 **单节点** VLESS + WebSocket + TLS（国内分流），按 Railway Free（$1/月额度）方案精简。

- 项目：Railway `railway-xray`（production），仅保留 `Railway-美国-加州`
- 传输：VLESS + WS(path=`/tk-rail`) + TLS(443，Railway 边缘证书)
- UUID：`3eb905bc-a18a-4b40-8578-eeade9d4c67a`

| 节点名 | 区域 | 域名 |
|---|---|---|
| Railway-美国-加州 | us-west2 (sfo) | railway-production-5618.up.railway.app |

## 订阅文件（没有 URL 了，直接导入文件）

Cloudflare 订阅端点已按要求全部删除，改用本地/仓库文件导入：

| 客户端 | 文件 |
|---|---|
| Clash / mihomo / FlClash | `sub/clash.yaml` |
| Quantumult X | `sub/qx.conf` |
| Shadowrocket | `sub/shadowrocket.conf` |
| 任意客户端 | `sub/vless.txt`（base64 版为 `sub/vless-base64.txt`） |

## 国内分流

- Clash：`GEOSITE,cn` / `GEOIP,CN` → 国内直连；`geolocation-!cn` → 国外网站；其余 → 漏网之鱼。
- QX：`geoip, cn` → 国内直连；`final` → 漏网之鱼。
- Shadowrocket：`GEOIP,CN → DIRECT`；`FINAL → 节点选择`。

## 成本（Railway）

- Trial：$5 / 30 天（至 2026-12-05）
- 之后 Free：**$1/月**额度
- 单节点固定 ≈ **$0.60/月**（内存 ~0.05GB×$10 + CPU ~0.01×$20），流量 $0.05/GB
- 即 Free 额度大约可跑 **8GB/月**；超出后服务停止，次月恢复

## 文件

```
sub/vless.txt            1 条 vless:// 链接
sub/vless-base64.txt     base64 版
sub/clash.yaml           Clash / mihomo / FlClash（含国内分流）
sub/qx.conf              Quantumult X 整份配置
sub/shadowrocket.conf    Shadowrocket 整份配置
nodes.json               节点与额度元数据
```

> 注意：本仓库为 private，内容含可直接使用的凭据（UUID + 域名），不要改成 public。
