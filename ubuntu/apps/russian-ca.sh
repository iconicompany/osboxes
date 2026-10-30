#!/bin/bash
# Установка сертификатов Минцифры (Russian Trusted Root CA)
set -e
cd /tmp

for cert in Russian_Trusted_Root_CA Russian_Trusted_Sub_CA Russian_Trusted_Sub_CA_2024; do
  wget -q -O ${cert}.cer https://gu-st.ru/content/downloads/${cert}.cer
  sudo cp ${cert}.cer /usr/local/share/ca-certificates/${cert}.crt
  rm -f ${cert}.cer
done

sudo update-ca-certificates
