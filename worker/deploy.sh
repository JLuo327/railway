#!/usr/bin/env bash
# 修改 sub/ 后重新发布订阅端点（需要 CLOUDFLARE_API_TOKEN 环境变量）
set -euo pipefail
cd "$(dirname "$0")/.."
python3 worker/build_worker.py
ACC="${CF_ACCOUNT_ID:-50f6a5595323c5ffa28b24278df3729d}"
printf '{"main_module":"worker.mjs","compatibility_date":"2025-09-01"}' > worker/metadata.json
curl -sS -X PUT "https://api.cloudflare.com/client/v4/accounts/$ACC/workers/scripts/railway-sub" \
  -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" \
  -F "metadata=@worker/metadata.json;type=application/json" \
  -F "worker.mjs=@worker/worker.mjs;type=application/javascript+module" \
  | python3 -c "import sys,json; d=json.load(sys.stdin); print('deployed' if d.get('success') else d)"
