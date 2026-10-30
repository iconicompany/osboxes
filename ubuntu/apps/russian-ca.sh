#!/bin/bash
# Установка сертификатов Минцифры (RSA + ГОСТ)
set -e
cd /tmp
sudo apt-get install -y libnss3-tools
mkdir -p "$HOME/.pki/nssdb"

# RSA-сертификаты с gu-st.ru
for cert in Russian_Trusted_Root_CA Russian_Trusted_Sub_CA Russian_Trusted_Sub_CA_2024; do
  wget -q -O ${cert}.cer https://gu-st.ru/content/downloads/${cert}.cer
  sudo cp ${cert}.cer /usr/local/share/ca-certificates/${cert}.crt
  certutil -d sql:"$HOME/.pki/nssdb" -D -n "${cert}" 2>/dev/null || true
  certutil -d sql:"$HOME/.pki/nssdb" -A -t "CT,C,C" -n "${cert}" -i ${cert}.cer
  rm -f ${cert}.cer
done

# ГОСТ-сертификаты 2025 (Минцифры России НУЦ)
for cert in russian-trusted-root-ca-gost-2025 russian-trusted-sub-ca-gost-2025; do
  wget -q -O ${cert}.crt https://high-cloud.ru/assets/chain/${cert}.crt
  sudo cp ${cert}.crt /usr/local/share/ca-certificates/${cert}.crt
  rm -f ${cert}.crt
done

sudo update-ca-certificates

# ГОСТ-цепочка проверяется через СКЗИ (CryptoPro), а не NSS/системное хранилище
if [ -x /opt/cprocsp/bin/amd64/certmgr ]; then
  sudo /opt/cprocsp/bin/amd64/certmgr -install -store mRoot \
    -file /usr/local/share/ca-certificates/russian-trusted-root-ca-gost-2025.crt
  sudo /opt/cprocsp/bin/amd64/certmgr -install -store mCA \
    -file /usr/local/share/ca-certificates/russian-trusted-sub-ca-gost-2025.crt
else
  echo "CryptoPro не найден: ГОСТ-сайты (esia.gosuslugi.ru) не будут открываться" >&2
fi
