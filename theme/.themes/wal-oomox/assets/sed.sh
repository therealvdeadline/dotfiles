#!/bin/sh
sed -i \
         -e 's/#3A3F48/rgb(0%,0%,0%)/g' \
         -e 's/#C9BEB6/rgb(100%,100%,100%)/g' \
    -e 's/#3A3F48/rgb(50%,0%,0%)/g' \
     -e 's/#8F807A/rgb(0%,50%,0%)/g' \
     -e 's/#3A3F48/rgb(50%,0%,50%)/g' \
     -e 's/#C9BEB6/rgb(0%,0%,50%)/g' \
	$@
