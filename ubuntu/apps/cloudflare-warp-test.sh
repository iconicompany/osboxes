warp-cli registration new
warp-cli mode proxy
warp-cli proxy port 4001
warp-cli connect
curl -x socks5h://127.0.0.1:4001 https://ifconfig.me
