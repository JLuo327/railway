#!/usr/bin/env bash
# 把 sub/ 下的订阅文件同步到 GitHub Gist（订阅链接固定不变）
# 用法：./publish.sh            需要 gh 已登录
set -euo pipefail
GIST_ID="${GIST_ID:-c83ad94148cad89204198e1b1f689f85}"
cd "$(dirname "$0")"
for f in clash.yaml qx.conf shadowrocket.conf vless.txt vless-base64.txt; do
  gh api -X PATCH "/gists/$GIST_ID" \
    -F "files[$f][content]=@sub/$f" >/dev/null
  echo "updated $f"
done
echo "订阅地址（固定不变）："
echo "  clash        https://gist.githubusercontent.com/JLuo327/$GIST_ID/raw/clash.yaml"
echo "  qx           https://gist.githubusercontent.com/JLuo327/$GIST_ID/raw/qx.conf"
echo "  shadowrocket https://gist.githubusercontent.com/JLuo327/$GIST_ID/raw/shadowrocket.conf"
echo "  vless        https://gist.githubusercontent.com/JLuo327/$GIST_ID/raw/vless.txt"
