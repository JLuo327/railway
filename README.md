# ASCA + Railway 订阅（国内分流）

两条自建线路合并在一份订阅里，Clash 侧走国内分流，QX / Shadowrocket 侧仍是原 Railway 单节点配置。

| 节点名 | 协议 | 入口 | 状态 |
|---|---|---|---|
| ASCA-vless | VLESS Reality（`xtls-rprx-vision`） | `[2600:70ff:b8c1:1::504]:443`，SNI `www.microsoft.com` | 在用；纯 IPv6 出口 |
| ASCA-hy2 | Hysteria2 | `[2600:70ff:b8c1:1::504]:8443`，自签证书 | 国内家宽 QUIC 被拦，待蜂窝验证 |
| Railway-美国-加州 | VLESS + WS + TLS | `us.1983723.xyz:443`，path `/tk-rail` | **已失效**：服务 2026-11-05 删除，域名无 DNS，条目仅留参数 |

ASCA 节点位于 ASCS Cloud（加拿大 Onoway, Alberta，1 Gbps 对称光纤）。

## 订阅链接（本仓库 raw，固定不变）

| 客户端 | 链接 |
|---|---|
| Clash / mihomo / FlClash / Karing | `https://raw.githubusercontent.com/JLuo327/railway/main/sub/clash.yaml` |
| 任意客户端（节点列表） | `https://raw.githubusercontent.com/JLuo327/railway/main/sub/vless.txt` |
| 同上（base64） | `https://raw.githubusercontent.com/JLuo327/railway/main/sub/vless-base64.txt` |
| Quantumult X | `https://raw.githubusercontent.com/JLuo327/railway/main/sub/qx.conf`（仅 Railway 单节点） |
| Shadowrocket | `https://raw.githubusercontent.com/JLuo327/railway/main/sub/shadowrocket.conf`（仅 Railway 单节点） |

> QX / Shadowrocket 两份配置没有写入 ASCA：REALITY 与 hysteria2 在这两个客户端里的字段各家版本不一致，没有实测过的不写进去。要在这两个客户端用 ASCA，直接导 `vless.txt` 里的链接。

> ⚠️ 本仓库是 **public**（raw 链接才能免登录访问）。内容含可直接使用的凭据：任何拿到链接的人都能用你的节点，GitHub 代码搜索也能搜到 `vless://`。被滥用就换服务端 UUID / hy2 密码并重推，或者把仓库改回 private（链接随即失效）。

## 国内分流

- Clash：`GEOSITE,cn` / `GEOIP,CN` → 国内直连；`geolocation-!cn` → 国外网站；其余 → 漏网之鱼。
- QX：`geoip, cn` → 国内直连；`final` → 漏网之鱼。
- Shadowrocket：`GEOIP,CN → DIRECT`；`FINAL → 节点选择`。
- `ipv6: true` 与 `dns.ipv6: true` 是给 ASCA 开的（它只有 IPv6 出口）；关掉快照会直接连不上。

## 已知限制

- **ASCA 纯 IPv6 出口**：只有 A 记录的站点（如 `github.com`）走它必然失败；双栈站点正常。走分流时国内域名直连，不受影响。
- **hy2 在国内家宽连不上**：该宽带上境外 QUIC（Cloudflare / Quad9 / Google，v4 与 v6）全部握手超时，国内 QUIC 22 ms 正常 —— 线路拦截，非节点故障。
- 延迟中位 250 ms；吞吐 0.1–2.6 MB/s 随时段波动（节点上行 1 Gbps，瓶颈在中国↔加拿大国际段）。

## 成本

- Railway：Trial $5 / 30 天（至 2026-12-05），之后 Free **$1/月**；单节点固定 ≈ **$0.60/月** + 流量 $0.05/GB ≈ 8GB/月。**服务当前已删除。**
- ASCA：以 ASCS Cloud 面板账单为准。

## 文件

```
sub/clash.yaml           ASCA-vless + ASCA-hy2 + Railway（国内分流，ipv6 已开）
sub/vless.txt            3 条链接（ASCA-vless / ASCA-hy2 / Railway）
sub/vless-base64.txt     base64 版
sub/qx.conf              Quantumult X（仅 Railway 单节点）
sub/shadowrocket.conf    Shadowrocket（仅 Railway 单节点）
```
