#!/bin/bash

# ZendGuard Loader Installer in CentOS Web Panel

# Compatible with version 5.3, 5.4, 5.5, 5.6 PHP

# Simple Bash script by Bullten Web Hosting Solutions [http://www.bullten.com]

CDIR='/usr/local/zendguardloader'
zend_56='http://downloads.zend.com/guard/7.0.0/zend-loader-php5.6-linux-x86_64.tar.gz'
zend_55='http://downloads.zend.com/guard/7.0.0/zend-loader-php5.5-linux-x86_64.tar.gz'
zend_54='http://downloads.zend.com/guard/6.0.0/ZendGuardLoader-70429-PHP-5.4-linux-glibc23-x86_64.tar.gz'
zend_53='http://downloads.zend.com/guard/5.5.0/ZendGuardLoader-php-5.3-linux-glibc23-x86_64.tar.gz'
package_56='zend-loader-php5.6-linux-x86_64.tar.gz'
package_55='zend-loader-php5.5-linux-x86_64.tar.gz'
package_54='ZendGuardLoader-70429-PHP-5.4-linux-glibc23-x86_64.tar.gz'
package_53='ZendGuardLoader-php-5.3-linux-glibc23-x86_64.tar.gz'

phpversion=`php -v | grep ^PHP | cut -f2 -d " "| awk -F "." '{print "zend_extension=\"/usr/local/zendguardloader/ZendGuardLoader_"$1"."$2".so\""}'`
PATHZ=`php -v | grep ^PHP | cut -f2 -d " "| awk -F "." '{print "/usr/local/zendguardloader/ZendGuardLoader_"$1"."$2".so"}'`
phplocation=`php -i | grep php.ini | grep ^Configuration | cut -f6 -d" "`
phpd=`php -v | grep ^PHP | cut -f2 -d " "| awk -F "." '{print ""$1"."$2""}'`
phpver="5.3"
RED='\033[01;31m'
RESET='\033[0m'
GREEN='\033[01;32m'

clear

echo -e "$GREEN******************************************************************************$RESET"
echo -e "   ZendGuard Loader Installation in CentOS Web Panel [http://centos-webpanel.com] $RESET"
echo -e "               Compatible with PHP 5.3, 5.4, 5.5, 5.6                              $RESET"
echo -e "       Bullten Web Hosting Solutions http://www.bullten.com/"
echo -e "   Web Hosting Company Specialized in Providing Managed VPS and Dedicated Server   "
echo -e "$GREEN******************************************************************************$RESET"
echo " "
echo " "
echo -e $RED"This script will install ZendGuard Loader on your system"$RESET
echo -e $RED""
echo -n  "Press ENTER to start the installation  ...."
read option

echo ""
echo "Installing bc"
echo ""
yum install bc -y
echo ""
echo "Installation of bc Completed"
echo ""
sleep 3

if [ $(echo "$phpd > $phpver" | bc) -ne 0 ] && [ -e "$PATHZ" ]; then 

echo "Found PHP version $phpd is compatible for zend guard loader installation"
echo ""
echo -e $RED"Found installation directory / file. Enabling SourceGuardian loader now."$RED
sleep 5
echo ""
echo -e $RED"Adding line $phpversion to file $phplocation/php.ini"$RESET
echo ""
sed -i '/ZendGuardLoader.*so/d' $phplocation/php.ini
sed -i '/zend_loader.enable=1/d' $phplocation/php.ini
echo -e "$phpversion" >> $phplocation/php.ini
echo -e "zend_loader.enable=1" >> $phplocation/php.ini
echo ""
echo -e $RED"Zend Guard Loader installed successfully :)"$RESET
echo ""


elif [ $(echo "$phpd > $phpver" | bc) -ne 0 ] && [ -n "$PATHZ" ];then

echo ""
echo -e $RED"Installation file folder doesn't exist / Downloading new files..."$RESET
sleep 2
echo ""
echo -e $RED"Please wait setting up installation directory / files"$RESET
sleep 3

rm -rf $CDIR; mkdir $CDIR
cd $CDIR
wget -c $zend_56
wget -c $zend_55
wget -c $zend_54
wget -c $zend_53

tar zxvf $package_56
tar zxvf $package_55
tar zxvf $package_54
tar zxvf $package_53

mv zend-loader-php5.6-linux-x86_64/ZendGuardLoader.so ./ZendGuardLoader_5.6.so
mv zend-loader-php5.5-linux-x86_64/ZendGuardLoader.so ./ZendGuardLoader_5.5.so
mv ZendGuardLoader-70429-PHP-5.4-linux-glibc23-x86_64/php-5.4.x/ZendGuardLoader.so ./ZendGuardLoader_5.4.so
mv ZendGuardLoader-php-5.3-linux-glibc23-x86_64/php-5.3.x/ZendGuardLoader.so ./ZendGuardLoader_5.3.so

echo ""
echo -e $RED"Setup Complete [/usr/local/zendguardloader]"$RESET
sleep 3

echo ""
echo -e $RED"Adding line $phpversion to file $phplocation/php.ini"$RESET
echo ""
sed -i '/ZendGuardLoader.*so/d' $phplocation/php.ini
sed -i '/zend_loader.enable=1/d' $phplocation/php.ini
echo -e "$phpversion" >> $phplocation/php.ini
echo -e "zend_loader.enable=1" >> $phplocation/php.ini
echo ""
echo -e $RED"ZendGuard Loader installed successfully :)"$RESET
echo ""

else

echo ""
echo -e $RED"Found PHP version $phpd is not compatible for ZendGuard loader installation / Supported versions are 5.3, 5.4, 5.5, 5.6"$RESET
echo ""
exit

fi

echo ""
echo -e $RED"Restarting Apache"$RED
echo ""
service httpd restart

echo ""
php -v