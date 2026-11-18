#!/bin/bash
set -euo pipefail

APP_DIR="/var/app/staging"
if [ ! -d "$APP_DIR" ]; then
  APP_DIR="/var/app/ondeck"
fi
cd "$APP_DIR"

if ! command -v npm >/dev/null 2>&1; then
  NODE_BIN="$(find /opt/elasticbeanstalk/node-install -maxdepth 3 -type d -name bin | head -1 || true)"
  if [ -n "${NODE_BIN}" ]; then
    export PATH="${NODE_BIN}:${PATH}"
  fi
fi

if [ ! -f .env ]; then
  echo ".env is missing from the deployment bundle, so the product service URL cannot be built in."
  exit 1
fi

npm run build
