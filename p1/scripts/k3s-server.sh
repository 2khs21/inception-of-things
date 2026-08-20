#!/bin/bash
# K3s server (controller) — Server IP: 192.168.56.110
set -euo pipefail

echo "[iot] K3s controller 설치"

# 192.168.56.0/24 에 붙은 인터페이스 (eth1 또는 enp0s8 등)
IFACE="$(ip -o -4 addr show | awk '/192\.168\.56\./ {print $2; exit}')"
if [ -z "${IFACE:-}" ]; then
  echo "[iot] 경고: 192.168.56.x 인터페이스를 못 찾음. 기본 라우트 iface 사용"
  IFACE="$(ip -o -4 route show to default | awk '{print $5; exit}')"
fi
echo "[iot] flannel iface=$IFACE"

curl -sfL https://get.k3s.io | sh -s - server \
  --write-kubeconfig-mode 644 \
  --node-ip 192.168.56.110 \
  --flannel-iface "$IFACE"

# kubectl 을 vagrant 유저로 쓰기
if [ -f /etc/rancher/k3s/k3s.yaml ]; then
  mkdir -p /home/vagrant/.kube
  cp /etc/rancher/k3s/k3s.yaml /home/vagrant/.kube/config
  chown -R vagrant:vagrant /home/vagrant/.kube
fi

echo "[iot] kubectl get nodes:"
kubectl get nodes || true
