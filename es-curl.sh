#!/bin/bash
# curl script to easy access elasticsearch endpoint


CERT="/etc/elasticsearch/x-pack/ssl/ca/ca.pem"
CACERT="/etc/elasticsearch/x-pack/ssl/ca/ca.crt"
URL="10.71.7.63:9200"

curl --cert $CERT --cacert $CACERT -XGET https://$URL/$1

if [ "$1" = '' ]; then 

    echo "";
    echo "################################";
    echo "";
	echo "Example usage:"; 
	echo "es-curl.sh _cat/indices?pretty";
    echo "";
    echo "################################";
fi

#example _cat/indices?pretty |grep eventlog-4624-2017.12