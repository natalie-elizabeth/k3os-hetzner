#!/usr/bin/env bash

set -euo pipefail

HCLOUD_TOKEN=$(cat secrets/hetzner-token)
[ -f hosting ] && hosting=$(cat secrets/hosting)

set -x

export HCLOUD_TOKEN
export hosting

destroy=${destroy:-""}
[ "$destroy" ] && terraform destroy -auto-approve

# Two part apply needed to generate names
terraform apply \
	-target random_pet.servers \
	-target random_pet.networks \
	-auto-approve
terraform apply -auto-approve
