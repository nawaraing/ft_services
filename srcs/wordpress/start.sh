#!/bin/sh

sleep 5
# sh create.sh # here
php -S 0.0.0.0:5050 -t /var/www/wordpress/
until [ $? != 1 ]
do
	php -S 0.0.0.0:5050 -t /var/www/wordpress/
done
