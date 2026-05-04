#!/usr/bin/env bash
# Usage: ./scripts/apply.sh <env> [plan|apply|destroy]
set -euo pipefail

ENV=${1:-dev}
ACTION=${2:-plan}
DIR="environments/${ENV}"

echo "==> Terraform ${ACTION} for environment: ${ENV}"
cd "$DIR"
terraform init -reconfigure
terraform validate
terraform "${ACTION}" ${ACTION:+-auto-approve}
