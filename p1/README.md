# p1 — Part 1 (Step 04)

Vagrant로 VM **2대** (`hyunkim2S` / `hyunkim2SW`). Debian bookworm, 1 CPU, 1024 MB.
IP: `192.168.56.110` / `192.168.56.111`
Server에 K3s controller (`scripts/k3s-server.sh`).

```bash
cd p1
vagrant up hyunkim2S --provision
vagrant ssh hyunkim2S -c "kubectl get nodes"
```

호스트 Ubuntu VM 안에서 실행하세요.
