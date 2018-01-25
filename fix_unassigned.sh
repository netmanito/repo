#!/bin/bash
#NODE="YOUR NODE NAME"
NODE="ullels03"
IFS=$'\n'
for line in $(curl -s 'localhost:9200/_cat/shards' | fgrep UNASSIGNED); do
  INDEX=$(echo $line | (awk '{print $1}'))
  SHARD=$(echo $line | (awk '{print $2}'))

  curl -XPOST 'localhost:9200/_cluster/reroute' -d '{
     "commands": [
        {
            "allocate": {
                "index": "'$INDEX'",
                "shard": '$SHARD',
                "node": "'$NODE'",
                "allow_primary": true
          }
        }
    ]
  }'
> fix_es.log
sleep 5
done

