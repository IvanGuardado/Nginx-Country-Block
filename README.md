# Configuration
## Setting the countries to block
You must set the $ISO var with the ISO code of the countries you want to deny.
You can add multiple countries with space separator:
```ISO="ng ru"```

## Setting your server paths
You must change the next vars if they are not right in your server:

<pre>
WGET=/usr/bin/wget
EGREP=/bin/egrep
OUTPUTFILE=/etc/nginx/blockips.conf
NGINXSERVICE=/etc/init.d/nginx
</pre>

## Modifying your nginx configuration file
Open your nginx configuration file
```vi /etc/nginx/nginx.conf```

Add the next into the http section:
```include /etc/nginx/blockips.conf;```

Be careful with your server paths. It is important your included file is the same as the OUTPUTFILE configuration var.

## (Optional) Create a cronjob
In order to keep update the ip list, you should create a cronjob to refresh the list every day.
```0 1 * * * /path/to/country.block.sh```




