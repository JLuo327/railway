# railway-xray-nodes

Railway 上自建的 4 个 VLESS + WebSocket + TLS 节点，及配套订阅（含中国大陆分流）。

- 项目：Railway `railway-xray`（production 环境），四个区域各一个服务
- 传输：VLESS + WS(path=`/tk-rail`) + TLS(443，Railway 边缘证书)
- UUID：`3eb905bc-a18a-4b40-8578-eeade9d4c67a`（四个节点共用）

| 节点名 | 区域 | 域名 |
|---|---|---|
| Railway-美国-加州 | us-west2 (sfo) | railway-production-5618.up.railway.app |
| Railway-美国-弗吉尼亚 | us-east4 (iad) | railway-production-8861.up.railway.app |
| Railway-荷兰-阿姆斯特丹 | europe-west4 (ams) | railway-production-fd5c.up.railway.app |
| Railway-新加坡 | asia-southeast1 (sin) | railway-production-855a.up.railway.app |

## 订阅链接（Cloudflare Worker 端点）

路径里 32 位串是访问令牌，**不要外发**；泄露后改 `worker/.secret` 重跑 `worker/deploy.sh` 即可整体换新。

| 客户端 | 链接 | 类型 |
|---|---|---|
| Clash / mihomo / FlClash / Clash Verge | `https://sub.1983723.xyz/97b51df8abf15bbf7a6b9c7f5a5daf83/clash.yaml` | 完整配置（含分流） |
| Quantumult X | `https://sub.1983723.xyz/97b51df8abf15bbf7a6b9c7f5a5daf83/qx.conf` | 完整配置（含分流） |
| Shadowrocket | `https://sub.1983723.xyz/97b51df8abf15bbf7a6b9c7f5a5daf83/shadowrocket.conf` | 完整配置（含分流） |
| 任意客户端（节点列表） | `https://sub.1983723.xyz/97b51df8abf15bbf7a6b9c7f5a5daf83/vless.txt` | 4 条 vless:// |
| 同上（base64） | `https://sub.1983723.xyz/97b51df8abf15bbf7a6b9c7f5a5daf83/vless-base64.txt` | base64 节点列表 |

## 国内分流逻辑

- Clash / mihomo：`GEOSITE,cn`、`GEOIP,CN` → **国内直连**；`GEOSITE,geolocation-!cn` → **国外网站**（默认走 节点选择）；其余 → **漏网之鱼**。策略组：`节点选择` / `自动选择`(url-test) / `国内直连` / `国外网站` / `漏网之鱼`。
- Quantumult X：`geoip, cn` → **国内直连**；`final` → **漏网之鱼**（默认 节点选择）。
- Shadowrocket：`GEOIP,CN` → `DIRECT`；`FINAL` → `节点选择`。
- 国内 DNS 用 223.5.5.5 / 119.29.29.29，geodata 走 jsdelivr 镜像（`geox-url`），避免 GitHub 拉取失败。

## 文件

```
sub/vless.txt            四条 vless:// 分享链接
sub/vless-base64.txt     同上，base64（部分客户端只吃 base64）
sub/clash.yaml           Clash / mihomo / FlClash 完整配置（含国内分流）
sub/qx.conf              Quantumult X 完整配置文件
sub/shadowrocket.conf    Shadowrocket 完整配置文件
nodes.json               节点与额度元数据
worker/template.mjs      Worker 模板
worker/build_worker.py   把 sub/ 内联进 worker.mjs
worker/deploy.sh         重新发布订阅端点（需要 CLOUDFLARE_API_TOKEN）
```

## 更新流程

1. 改 `sub/` 下的文件（比如换 UUID、换域名）。
2. 客户端重新拉订阅即可看到变化——但 Worker 里的内容是**内联**的，必须重新发布：
   ```bash
   export CLOUDFLARE_API_TOKEN=...   # 有 Workers Scripts:Edit 权限
   ./worker/deploy.sh
   ```

## 额度与成本（2026-11-05 实测）

- Railway Trial：剩余 **$5.00**，页面显示 **30 天**（约 2026-12-05 到期）
- 固定开销 ≈ **$2.40/月**（内存 0.20GB×$10/GB月 + CPU 0.02vCPU×$20/vCPU月）
- 流量 **$0.05/GB**；轻度 30GB/月 ≈ $1.50 → 合计 ≈ **$3.90/月**
- $5 试用额度约可撑 **52GB** 总流量；到期需转 Hobby（$5/月订阅，含 $5 用量）

## 安全

- 本仓库是 **private**，但内容是可直接使用的凭据（UUID + 域名）；**不要改成 public**，也不要贴到 issue/gist。
- 订阅链接的 32 位路径令牌等价于密码：泄露后按上面的「更新流程」换 `worker/.secret` 并 redeploy。
- 共用一套 UUID，任一链接泄露 = 四个节点全泄露；换 UUID 需要同时改 Railway 四个服务的 `XRAY_CONFIG` 变量并重新部署。
