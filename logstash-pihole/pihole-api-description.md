Originally published at: https://pi-hole.net/2019/02/18/hotfix-release-of-pi-hole-v4-2-2/

...
In Pi-hole version 3.0 (to be released in March 2017) we will update our API due to some inconsistencies we have found. Using the updated API, it is possible to query all options in an arbitrary combination. Use this post to already know what will be changing. We will present and compare all features of the Pi-hole API in this FAQ post.
type & version (only AdminLTE v2.5+)

    No authorization necessary
    version: returns the version of the API (2 or 3), see below
    type: return the backend used by the API (either PHP or FTL)

### summaryRaw

    Gives statistics in raw format (no number formatting applied)
    No authorization necessary
    Exemplary output:

`{"domains_being_blocked":99867,"dns_queries_today":2275,"ads_blocked_today":422,"ads_percentage_today":18.549450}`

### summary (default if no parameters are given)

    Gives statistics in formatted style
    No authorization necessary
    Exemplary output:

`{"domains_being_blocked":"99,867","dns_queries_today":"2,317","ads_blocked_today":"424","ads_percentage_today":"18.3"}`

### overTimeData10mins

* Data needed for generating the domains/ads over time graph on the 
* Pi-hole web dashboard
* No authorization necessary
* The first value in "domains_over_time" is the number of queries within the timeframe of 00:00:00 - 00:09:59 at this day. Similarly for the first value in "ads_over_time". 
* The second value corresponds to 00:10:00 - 00:19:59 and so on.
  
   Exemplary output:
API version 2:

```
{"domains_over_time":[8,6,11,6,2,16,9,6,4,2,8,5,1,6,18,2,4,11,1,32,13,6,1,7,2,7,11,4,2,29,8,4,9,4,1,11,6,2,19,2,2,12,4,9,7,8,2,5,3,14,9,2,4,47,6,3,13,105,40,15,62,36,30,12,43,79,251,405,65,81,33,32,56,29,45,30,74,118,136,78,13],"ads_over_time":[0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,2,0,0,0,0,2,0,0,0,4,2,0,0,2,0,0,2,0,0,0,0,2,2,0,0,0,0,2,2,0,0,0,0,2,2,0,2,4,6,0,9,3,2,0,10,8,44,150,21,37,1,2,22,4,3,7,9,22,16,14,2]}
```

API version 3:

```
{"domains_over_time":{"1488150000":12,"1488150600":14,"1488151200":17,"1488151800":9,"1488152400":22,"1488153000":19,"1488153600":4,"1488154200":4,"1488154800":9,"1488155400":8,"1488156000":4,"1488156600":9,"1488157200":2,"1488157800":10,"1488158400":6,"1488159000":16,"1488159600":10,"1488160200":6,"1488160800":4,"1488161400":10,"1488162000":7,"1488162600":8,"1488163200":11,"1488163800":11,"1488164400":1,"1488165000":14,"1488165600":3,"1488166200":10,"1488166800":8,"1488167400":22,"1488168000":3,"1488168600":2,"1488169200":3,"1488169800":6,"1488170400":6,"1488171000":19,"1488171600":5,"1488172200":6,"1488172800":4,"1488173400":8,"1488174000":3,"1488174600":3,"1488175200":2,"1488175800":4,"1488176400":5,"1488177000":2,"1488177600":12,"1488178200":7,"1488178800":1,"1488179400":2,"1488180000":7,"1488180600":6,"1488181200":10,"1488181800":6,"1488182400":8,"1488183000":6,"1488183600":5,"1488184200":6,"1488184800":20,"1488185400":15,"1488186000":6,"1488186600":8,"1488187200":7,"1488187800":20,"1488188400":4,"1488189000":10,"1488189600":6,"1488190200":77,"1488190800":29,"1488191400":118,"1488192000":50,"1488192600":22,"1488193200":18,"1488193800":121,"1488194400":163,"1488195000":290,"1488195600":402,"1488196200":241,"1488196800":227,"1488197400":311,"1488198000":204,"1488198600":167,"1488199200":247,"1488199800":169,"1488200400":220,"1488201000":202,"1488201600":249,"1488202200":164,"1488202800":163,"1488203400":215,"1488204000":208,"1488204600":198,"1488205200":221,"1488205800":268,"1488206400":198,"1488207000":29,"1488207600":46,"1488208200":36,"1488208800":25,"1488209400":39,"1488210000":92,"1488210600":35,"1488211200":126,"1488211800":35},"ads_over_time":{"1488150000":2,"1488150600":2,"1488151200":2,"1488151800":0,"1488152400":2,"1488153000":4,"1488153600":0,"1488154200":2,"1488154800":2,"1488155400":2,"1488156000":0,"1488156600":2,"1488157200":0,"1488157800":4,"1488158400":0,"1488159000":4,"1488159600":2,"1488160200":0,"1488160800":2,"1488161400":0,"1488162000":0,"1488162600":2,"1488163200":2,"1488163800":0,"1488164400":0,"1488165000":2,"1488165600":0,"1488166200":0,"1488166800":2,"1488167400":0,"1488168000":0,"1488168600":0,"1488169200":0,"1488169800":0,"1488170400":0,"1488171000":4,"1488171600":2,"1488172200":0,"1488172800":0,"1488173400":0,"1488174000":0,"1488174600":0,"1488175200":0,"1488175800":0,"1488176400":0,"1488177000":0,"1488177600":0,"1488178200":0,"1488178800":0,"1488179400":0,"1488180000":0,"1488180600":0,"1488181200":0,"1488181800":0,"1488182400":0,"1488183000":0,"1488183600":0,"1488184200":0,"1488184800":2,"1488185400":2,"1488186000":0,"1488186600":0,"1488187200":2,"1488187800":0,"1488188400":0,"1488189000":0,"1488189600":0,"1488190200":8,"1488190800":6,"1488191400":18,"1488192000":12,"1488192600":6,"1488193200":4,"1488193800":9,"1488194400":4,"1488195000":20,"1488195600":80,"1488196200":21,"1488196800":24,"1488197400":26,"1488198000":14,"1488198600":2,"1488199200":12,"1488199800":2,"1488200400":8,"1488201000":14,"1488201600":16,"1488202200":2,"1488202800":2,"1488203400":10,"1488204000":10,"1488204600":16,"1488205200":18,"1488205800":28,"1488206400":6,"1488207000":2,"1488207600":1,"1488208200":2,"1488208800":0,"1488209400":2,"1488210000":16,"1488210600":4,"1488211200":15,"1488211800":2}}
```

### topItems

* Data needed for generating the Top Domain and Top Advertisers Lists
* Authorization required
* The default number of returned entries is 10. It can be changed by specifying a numeric argument, e.g. api.php?topItems=25
 
    Exemplary output:

```
{"top_queries":{"checkip.dyndns.org":144,"avx.google.com":117,"clients4.google.com":92,"pi-hole.net":80,"android.clients.google.com":77,"aff.googleapis.com":61,"cdn.dropsapi.net":56,"www.google.com":47,"search.google.com":45,"www.googleapis.com":43},"top_ads":{"www.googleadservices.com":51,"ssl.google-analytics.com":35,"googleads.g.doubleclick.net":14,"www.google-analytics.com":11,"de.sitestat.com":8,"de.ioam.de":8,"stags.bluekai.com":6,"image2.pubmatic.com":6,"ib.adnxs.com":6,"pixel.quantserve.com":6}}
```

### getQuerySources (also topClients in API version 3)

* Data needed for generating the Top Clients list
* Authorization required
* The default number of returned entries is 10. It can be changed by specifying a numeric argument, e.g. api.php?topClients=25
 
Exemplary output:

```
{"top_sources":{"desktop.local|192.168.1.2":1440,"android-a4.local|192.168.1.3":609,"localhost|127.0.0.1":186,"android-53.local|192.168.1.4":120,"android-86.local|192.168.1.5":62}}
```

### getForwardDestinations

* Shows number of queries that have been forwarded and the target
* Authorization required

Exemplary output:
    API version 2:

```
{"forward_destinations":{"resolver2.opendns.com|208.67.220.220":1198,"google-public-dns-b.google.com|8.8.4.4":643,"resolver1.opendns.com|208.67.222.222":607,"google-public-dns-a.google.com|8.8.8.8":539}}
```

   API version 3:

```
{"resolver2.opendns.com|208.67.220.220":1198,"google-public-dns-b.google.com|8.8.4.4":643,"resolver1.opendns.com|208.67.222.222":607,"google-public-dns-a.google.com|8.8.8.8":539}
```

### getQueryTypes


* Shows number of queries that the Pi-hole’s DNS server has processed
* Authorization required
* Exemplary output

API version 2:

```
{"query[AAAA]":1012,"query[A]":1395}
```

  API version 3:

```
{"querytypes":{"A (IPv4)":1395,"AAAA (IPv6)":1012,"PTR":20,"SRV":8}}
```

### getAllQueries

* Get DNS queries data
* Authorization required
* This command supports a number of (undocumented) filters, e.g. show only queries within a specific time interval, from specific clients or only specific domains

    Exemplary output
    API version 2:

```
{"data":[["2017-02-23 CET 00:00:02","AAAA","raspberrypi","localhost","OK",""],["2017-02-23 CET 00:00:02","AAAA","raspberrypi","localhost","OK",""],["2017-02-23 CET 00:02:16","AAAA","android.clients.google.com","android-a4.local","OK",""],["2017-02-23 CET 00:02:16","A","android.clients.google.com","android-a4.local","OK",""],["2017-02-23 CET 00:02:25","AAAA","player.onleihe.de","android-53.local","OK",""],["2017-02-23 CET 00:03:18","AAAA","clientservices.googleapis.com","android-53.local","OK",""], ... ]}
```

*    First column: Timestring of query
*    Second column: Type of query
*    Third column: Requested domain name
*    Fourth column: Requesting client
*    Fifth column: Status as string
*    Sixth column: Always empty

    API version 3:

```
{"data":[["1487804402","IPv6","raspberrypi","localhost","3"],["1487804402","IPv6","raspberrypi","localhost","3"],["1487804536","IPv6","android.clients.google.com","android-a4.local","2"],["1487804536","IPv4","android.clients.google.com","android-a4.local","3"],["1487804545","IPv6","player.onleihe.de","android-53.local","2"],["1487804598","IPv6","clientservices.googleapis.com","android-53.local","2"], ... ]}
```

*    First column: Timestamp of query
*    Second column: Type of query (IPv4 or IPv6)
*    Third column: Requested domain name
*    Fourth column: Requesting client
*    Fifth column: Answer type (1 = blocked by gravity.list, 2 = forwarded to upstream server, 3 = answered by local cache, 4 = blocked by wildcard blocking)

## enable (only AdminLTE v2.5+)

*    Enable Pi-hole ad blocking
*    Authorization & Token required (see WEBPASSWORD in /etc/pihole/setupVars.conf)
*    Example: 

```
admin/api.php?enable&auth=183c1b634da0078fcf5b0af84bdcbb3e817708c3f22b329be84165f4bad1ae58

{"status":"enabled"}
```
## disable (only AdminLTE v2.5+)

*    Disable Pi-hole ad blocking
*    Temporal disabling is possible by specifying the amount of seconds, e.g. api.php?disable=10&auth=...
*    Authorization & Token required (see WEBPASSWORD in /etc/pihole/setupVars.conf)
*    Example: 

```
admin/api.php?disable&auth=183c1b634da0078fcf5b0af84bdcbb3e817708c3f22b329be84165f4bad1ae58

{"status":"disabled"}
```

### recentBlocked (only AdminLTE v3.0+)

*    Show most recent blocked domain
*    Only API version 3
*    Exemplarly output (no JSON):

`ssl.google-analytics.com`

