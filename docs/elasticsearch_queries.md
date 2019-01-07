# ELASTICSEARCH QUERIES

## STATS

#### Show cluster stats

	GET _cluster/health?pretty

#### Show nodes stats

	GET _nodes/stats

#### Show indices stats

	GET _cat/indices?pretty


## MAPPINGS & SETTINGS

	GET bpdbjobs30-2017.01.11/_mappings

#### Put defaults mappings

	PUT _mapping/defaults?update_all_types
	{
	  "properties": {
	    "beat.name": {
	      "type": "text",
	      "fielddata": true
	    }
	  }
	}

#### Set index default mappings

	PUT topbeat-2016.*/_mapping/defaults?update_all_types
	{
	   "properties": {
	    "proc.name": {
	      "type": "text",
	      "fielddata": true
	    }
	  }
	}

	PUT bpdbjobs30-2017.01.11/_mapping/bpdbjobs
	{
	  "properties": {
	    "filetobesaved" : {
	      "type" : "string"
	    }
	  }
	}

#### Shard and Replica settings

	PUT /_template/syslog
	{
	  "template": "syslog*", 
	  "settings": {
	    "number_of_shards": 2,
	    "number_of_replicas": 1
	  }
	}

#### Default shards and replicas

	PUT /_template/index_defaults 
	{
	  "template": "*", 
	  "settings": {
	    "number_of_replicas": 2
	  }
	}


## SEARCH

#### Search anything

	GET _search
	{
  		"query": {
    	"match_all": {}
  	    }
	}

	POST /_index/_search?pretty
	{
	  "fields": [
	    "syslog_hostname",
	    "host"
	  ],
	  "query": {
	    "term": {
	      "tags": "pre"
	    }
	  }
	}


	POST /syslog-2017.01.16/_search?search_type=count
	{
	  "aggs": {
	    "host-list": {
	      "terms": {
	        "field": "received_from",
	        "size": 10
	      }
	    }
	  }
	}

#### Search Something

	GET eventlog-4624-2017.02.01/_search
	{
	   "_source": ["path"],
	   "size": 100
	  
	}


	GET eventlog-4624-2017.01.31/_search
	{
	   "_source": ["TargetUserName"],
	  "size": 100,
	  "aggs": {
	    "path_list": {
	      "terms": {
	        "field": "TargetUserName"
	      }
	    }
	  }
	}

	POST /eventlog-4624-2017.02.01/_search
	{
	    "_source": ["path"],
	    "size": 10000,
	    "aggs" : {
	        "path-pre" : {
	            "terms" : { 
	              "field" : "path.keyword"
	            }
	        }
	    }
	}

	POST /eventlog-4624-2017.01.25/_search
	{
	    "_source": ["TargetUserName"],
	    "aggs" : {
	        "username_counts" : {
	            "cardinality" : { 
	              "field" : "TargetUserName"
	            }
	        }
	    }
	}

##### Agreggations

	GET syslog-2017.01.17/_search
	{
	  "_source": ["user", "message", ...],
	  "size": 0,
	  "aggs": {
	    "host_list": {
	      "terms": {
	        "field": "host"
	      }
	    }
	  }

## DELETE from query

```
POST quorum-2018.10*/_delete_by_query
{
  "query": { 
    "match": {
      "old_round": "0"
    }
  }
}
```

## SNAPSHOTS & BACKUPS


#### Create snapshot destination

	PUT /_snapshot/pre
	{
	  "type": "fs",
	  "settings": {
	        "location": "/var/lib/backup/pre",
	        "compress": true
	  }
	}

#### Show snapshot stats

	GET /_snapshot/pre

	GET /_snapshot/pre/_all

	GET _snapshot/pre/all-2016/_status

#### Create snapshot

	PUT _snapshot/pre/syslog_2016
	{
	    "indices": "syslog-2016.*"
	}

	PUT _snapshot/pre-v2/snapshot_prev_5?wait_for_completion=true


#### Restore snapshot

	POST _snapshot/pre/topbeat-2017/_restore

#### Reindex

	POST /_reindex
	{
	  "source": {
	    "index": "nagios-2016.12.30"
	  },
	  "dest": {
	    "index": "nagios-2016.12.30-1"
	  }
	}

#### Remote Index

	POST _reindex
	{
	  "source": {
	    "remote": {
	      "host": "http://ulrels01:9200"
	    },
	    "index": "nagios-2017.01.28"
	  },
	  "dest": {
	    "index": "nagios-2017.01.28"
	  }
	}

