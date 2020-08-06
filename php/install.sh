set -e

cp local.ini /etc/php7/conf.d
cp config.php /etc/php7
cd /etc/php7/apache2
ln -s ../config.php

cd /etc/php7/cli
ln -s ../config.php