sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.max.ru/linux/deb/public.asc | sudo gpg --dearmor -o /etc/apt/keyrings/max.gpg >/dev/null
echo "deb [signed-by=/etc/apt/keyrings/max.gpg] https://download.max.ru/linux/deb stable main" | sudo tee /etc/apt/sources.list.d/max.list

sudo apt update
sudo apt install max
