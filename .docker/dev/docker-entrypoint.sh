#!/bin/sh
echo "Composer dump-autoload"
composer dump-autoload

/usr/bin/supervisord  -c "/etc/supervisor/conf.d/supervisord.conf"
