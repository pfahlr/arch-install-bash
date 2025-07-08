#########################################
# this script runs  on the new system   #
#########################################

#add locales to end of locales.gen file

echo "en_US.UTF-8 UTF-8" >> locale.gen
echo "en_US.ISO-8859-1 ISO-8859-1" >> locale.gen
echo "en_US.IBM437 IBM850" >> locale.gen
echo "en_US.IBM850 IBM850" >> locale.gen


locale-gen

echo "LOCALE=en_US.UTF-8" > /etc/locale.conf

timedatectl set-ntp 1

timedatectl list-timezones

timedatectl set-timezone America/Detroit


