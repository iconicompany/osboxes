set -e
cd /tmp
wget -c https://github.com/jeddict/jeddict/releases/download/5.4.3/Jeddict_5.4.3_with_NetBeans_IDE_12.1.zip
cd /opt
sudo unzip /tmp/Jeddict_5.4.3_with_NetBeans_IDE_12.1.zip
sudo chmod +x /opt/NetBeans_IDE_12.1/bin/netbeans /opt/NetBeans_IDE_12.1/java/maven/bin/mvn
