#!/usr/bin/env bash
set -xeuo pipefail

node_ipv4_public="$1"

k3os_user=rancher
ssh_key=secrets/ssh-terraform
ssh_opts="-o StrictHostKeyChecking=no"

kubectl="ssh $ssh_opts -i $ssh_key ${k3os_user}@${node_ipv4_public} kubectl"

$kubectl get secret -n prometheus prometheus-cert -o yaml > secrets/prometheus-cert.yaml
$kubectl get secret -n longhorn-system longhorn-cert -o yaml > secrets/longhorn-cert.yaml
$kubectl get secret -n kubernetes-dashboard dashboard-cert -o yaml > secrets/dashboard-cert.yaml
$kubectl get secret -n docker-registry registry-cert -o yaml > secrets/registry-cert.yaml
$kubectl get secret -n docker-registry htpasswd -o yaml > secrets/registry-htpasswd.yaml
$kubectl get secret -n argo argo-cert -o yaml > secrets/argo-cert.yaml
$kubectl get secret -n argocd argocd-cert -o yaml > secrets/argocd-cert.yaml
$kubectl get secret -n default k3s-cert -o yaml > secrets/k3s-cert.yaml
$kubectl get secret -n default regcred -o yaml > secrets/regcred.yaml
