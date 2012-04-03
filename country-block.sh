#!/bin/bash
ISO="ng" 
 
### Set PATH ###
WGET=/usr/bin/wget
EGREP=/bin/egrep
OUTPUTFILE=/etc/nginx/blockips.conf
NGINXSERVICE=/etc/init.d/nginx

### No editing below ###
SPAMLIST="countrydrop"
ZONEROOT="/root/iptables"
DLROOT="http://www.ipdeny.com/ipblocks/data/countries"
 
cleanOldRules(){
    rm $OUTPUTFILE
}
 
# create a dir
[ ! -d $ZONEROOT ] && /bin/mkdir -p $ZONEROOT
 
# clean old rules
cleanOldRules
  
for c  in $ISO
do
	# local zone file
	tDB=$ZONEROOT/$c.zone
 
	# get fresh zone file
	$WGET -O $tDB $DLROOT/$c.zone
 
	# country specific log message
	SPAMDROPMSG="$c Country Drop"
 
	# get
	BADIPS=$($EGREP -v "^#|^$" $tDB)
	for ipblock in $BADIPS
	do
	   
	   echo "Deny $ipblock;" >> $OUTPUTFILE
	done
done

$NGINXSERVICE reload

exit 0
