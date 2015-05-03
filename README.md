# ZendGuard-Loader-Auto-Installer
ZendGuard Loader Auto Installer for CentOS Web Panel

cd /usr/local/src

rm -rf cwp-zendguardloader.sh

wget -c http://dl-package.bullten.in/cwp/cwp-zendguardloader.sh

chmod +x cwp-zendguardloader.sh

sh cwp-zendguardloader.sh | tee /var/log/zendloader.log
