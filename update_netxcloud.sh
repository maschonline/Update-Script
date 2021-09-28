#!/bin/bash
sudo -u www-data php --define apc.enable_cli=1 /var/www/nextcloud/updater/updater.phar
