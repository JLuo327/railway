# railway-xray-nodes

Railway 自建的 **单节点** VLESS + WebSocket + TLS（国内分流），按 Railway Free（$1/月额度）方案精简。

- 项目：Railway `railway-xray`（production），仅保留 `Railway-美国-加州`
- 传输：VLESS + WS(path=`/tk-rail`) + TLS(443，Railway 边缘证书)
- UUID：`3eb905bc-a18a-4b40-8578-eeade9d4c67a`

| 节点名 | 区域 | 域名 |
|---|---|---|
| Railway-美国-加州 | us-west2 (sfo) | railway-production-5618.up.railway.app |

## 订阅链接（GitHub Gist，secret gist，固定不变）

以后新增/更换节点只改 `sub/` 再跑 `./publish.sh`，**下面这些 URL 永远不变**：

| 客户端 | 链接 |
|---|---|
| Clash / mihomo / FlClash | `https://gist.githubusercontent.com/JLuo327/c83ad94148cad89204198e1b1f689f85/raw/clash.yaml` |
| Quantumult X | `https://gist.githubusercontent.com/JLuo327/c83ad94148cad89204198e1b1f689f85/raw/qx.conf` |
| Shadowrocket | `https://gist.githubusercontent.com/JLuo327/c83ad94148cad89204198e1b1f689f85/raw/shadowrocket.conf` |
| 任意客户端（节点列表） | `https://gist.githubusercontent.com/JLuo327/c83ad94148cad89204198e1b1f689f85/raw/vless.txt` |
| 同上（base64） | `https://gist.githubusercontent.com/JLuo327/c83ad94148cad89204198e1b1f689f85/raw/vless-base64.txt` |

> 是 **secret gist**（不列在个人主页、不进 GitHub 代码搜索），但拿到链接的人就能读——和所有订阅 URL 一样，链接即凭据。

## 备用：没有 URL 时直接导入文件

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
