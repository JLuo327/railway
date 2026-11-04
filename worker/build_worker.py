#!/usr/bin/env python3
"""把 sub/ 下的订阅文件内联进 worker.mjs（发布用）。"""
import json, os, sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
SECRET_FILE = os.path.join(HERE, ".secret")
TOTAL = 52 * 1024 ** 3          # 试用额度估算：约 52GB
EXPIRE = 1796428800             # 2026-12-05 00:00:00 UTC（Railway 试用到期）

def main():
    secret = os.environ.get("SUB_SECRET") or open(SECRET_FILE).read().strip()
    files = {}
    for name in sorted(os.listdir(os.path.join(ROOT, "sub"))):
        if name.startswith("."):
            continue
        files[name] = open(os.path.join(ROOT, "sub", name), encoding="utf-8").read()
    tpl = open(os.path.join(HERE, "template.mjs"), encoding="utf-8").read()
    out = (tpl.replace("__SECRET__", secret)
              .replace("__USERINFO__", f"upload=0; download=0; total={TOTAL}; expire={EXPIRE}")
              .replace("__FILES__", json.dumps(files, ensure_ascii=False, indent=2)))
    open(os.path.join(HERE, "worker.mjs"), "w", encoding="utf-8").write(out)
    print(f"built worker/worker.mjs  ({len(out)} bytes, {len(files)} files, {len(secret)} char secret)")

if __name__ == "__main__":
    main()
