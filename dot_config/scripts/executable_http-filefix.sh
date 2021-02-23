#!/bin/bash
# $1 = user; $2 = group; $3 = path to root of project
sudo chown -Rv $1:$2 $3
sudo find $3 -type f -exec chmod -v 664 {} \;
sudo find $3 -type d -exec chmod -v 775 {} \;
cd $3
sudo chgrp -Rv $2 storage bootstrap/cache
sudo chmod -Rv ug+rwx storage bootstrap/cache

