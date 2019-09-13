
## Whoami

```
echo "I'm a Unix Creationist, the world was created on $(TZ=GMT date -d @0) and it will end on $(TZ=GMT date -d @$((2**31-1)))"
```

## Change encfs directory password

```
encfsctl passwd /home/bredsaal/encfs_test/plain/
```

[http://bredsaal.dk/how-to-change-encfs-password](http://bredsaal.dk/how-to-change-encfs-password)

## Elastisearch tip

depending on how you use ES, in my cases, I would never have indexes over half my RAM - Sorry - I cant wait for ages for data :)

## Docker tip

```
#!/bin/bash
# Delete all containers
docker rm $(docker ps -a -q)
# Delete all images
docker rmi $(docker images -q)
```

## Dns reload mac os 

	sudo killall -HUP mDNSResponder

## fdupes, find duplicated 

	fdupes -rndfS directory/

## SCREEN 

### Split window 

```
CRTL+a SHIFT-s: screen-split

CTRL+a y TAB (tabulación): moves between spaces
```

### Inside spaces you can do:

```
CTRL+a SHIFT-C: Create new window in spaces

CTRL+a n: moves to current window

CTRL+a SHIFT-x : close current space 
CTRL+a SHIFT+q : close all spaces except current 
```

## CENTOS

### Basics to work

```
$ yum update
$ yum -y install net-tools vim screen mc less openssh-server curl wget 
$ systemctl start sshd.service 
$ yum -y install epel-release
```


### change timezone centos

	$ cp /usr/share/zoneinfo/GB /etc/localtime
	root@elkb ~ $ cp /usr/share/zoneinfo/Europe/Madrid /etc/localtime

### yum

	$ yum whatprovides ifconfig

	$ yum install net-tools <-- Provides **ifconfig**

	$ yum -y groupinstall "Development Tools" <-- Install compilation tools

### static network address

	vi /etc/sysconfig/network-scripts/ifcfg-eth0

I will change  the file like this:

	#My IP description
	# IPv-4

	DEVICE="eth0"
	NM_CONTROLLED="yes"
	ONBOOT=yes
	HWADDR=20:89:84:c8:12:8a
	TYPE=Ethernet
	BOOTPROTO=static
	NAME="System eth0"
	UUID=5fb06bd0-0bb0-7ffb-45f1-d6edd65f3e03


### sysctl 

	sysctl -p -w vm.max_map_count=262144

### puppet repo

```
rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
```

## system proxy 

If your internet connection is behind a web proxy, you need to configure the following on your CentOS server:

System-wide proxy settings - add the following lines to your **/etc/environment** file:

```
$ vi /etc/environment
```
Add the following lines.

```
http_proxy="http://proxysrv:8080/"
https_proxy="https://proxysrv:8080/"
ftp_proxy="ftp://proxysrv:8080/"

no_proxy=".mylan.local,.domain1.com,host1,host2"
```

To apply these settings without restarting the machine run the following commands on the bash shell:

```
export http_proxy="http://proxysrv:8080/"
export https_proxy="https://proxysrv:8080/"
export ftp_proxy="ftp://proxysrv:8080/"
export no_proxy=".mylan.local,.domain1.com,host1,host2"
```
You also need to configure yum:

```
vi /etc/yum.conf
```

## Show package versions debian.

Try with

    apt-cache madison myPackage

Quote from man page:

    It displays available versions of a package in a tabular format.

Also you can

    apt-cache policy package

and then 

    apt-get install package=version

## git

First get the git-completion.bash script (view it here) and put it in your home directory:

```
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
```

Next, add the following lines to your .bash_profile. This tells bash to execute the git autocomplete script if it exists.

```
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi	
```

### !gitignore

The problem is that .gitignore ignores just files that weren't tracked before (by git add). 
Run git rm --cached name_of_file and your file will be ignored again (in case it's mentioned in .gitignore).

```
git checkout master               # first get back to master
git checkout experiment -- app.js # then copy the version of app.js 
                                  # from branch "experiment"
```

### git move file to current branch from other 

Yes you can run  multiple chains on one peer, all you need is to produce a configuration for each one of them and make your peer to join it. Just follow the following steps: 

    You need to provide chain configuration within [ configtx.yaml ]

    Use [ configtxgen ] to produce create channel transaction and updates for anchor peers

configtxgen -profile PeerChannelProfile -channelID YourNewChannel -outputcreateChannelTx=newchannel.tx

where PeerChannelProfile is the configuration profile you have defined in configtx.yaml file.

Now an update is needed for anchor peers per organisations depending on he number of organisations as following:

  configtxgen -profile PeerChannelProfile -channelID YourNewChannel -outputAchorPeersUpdate=Org1MSPAnchor.tx -asOrg=Org1MSP

The above steps need to be repeated for each organisation.

3. Now when you have create channel transaction you can actually make your peer to join the network by:

peer channel create -o orderer:7050 -c YourNewChannel -f newchannel.tx

This will produce the genesis block for your channel

4. Make the peer join it:

peer channel join -o orderer:7050 -c --blockpath YourNewChannel.block

branch

```
git checkout otherbranch myfile.txt
```

### delete branch

To remove a local branch 

```
git branch -d the_local_branch
```

To remove a remote branch (if you know what you are doing!)

```
git push origin --delete the_remote_branch
```

### Disable TLS/SSL git verification

To disable TLS/SSL verification for a single git command
try passing -c to git with the proper config variable, or use Flow's answer:

`git -c http.sslVerify=false clone https://example.com/path/to/git`

To disable SSL verification for a specific repository
If the repository is completely under your control, you can try:

`git config http.sslVerify false`

Disabling TLS(/SSL) certificate verification globally is a terribly insecure practice. Don't do it. 
Do not issue the above command with a `--global` modifier.

## netcat 

On your server (A):

```
nc -l -p 1234 -q 1 > something.zip < /dev/null
```

On your "sender client" (B):

```
cat something.zip | netcat server.ip.here 1234
```
## Vim Text selection

```
V       - selects entire lines 
v       - selects range of text
ctrl-v  - selects columns
gv      - reselect block
```

After selecting the text, try d to delete, or y to copy, or :s/match/replace/, or :center, or !sort, or... 

## Iptables 

I finally found how-to. First, I had to add -i eth1 to my "outside" rule (eth1 is my WAN connection). I also needed to add two others rules. Here in the end what I came with :

```
iptables -t nat -A PREROUTING -i eth1 -p tcp --dport 8080 -j DNAT --to 10.32.25.2:80
iptables -t nat -A PREROUTING -p tcp --dport 8080 -j DNAT --to 10.32.25.2:80
iptables -t nat -A POSTROUTING -p tcp -d 10.32.25.2 --dport 80 -j MASQUERADE
```
```
root@ESJC-HAHP-AS07S $ iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 3000 -j DNAT --to 172.17.0.134:3000
root@ESJC-HAHP-AS07S $ iptables -t nat -A PREROUTING -p tcp --dport 3000 -j DNAT --to 172.17.0.134:3000
root@ESJC-HAHP-AS07S $ iptables -t nat -A POSTROUTING -p tcp -d 172.17.0.134 --dport 3000 -j MASQUERADE
```

### Redirect PORT

```
iptables -A INPUT -i eth0 -p tcp --dport 80 -j ACCEPT
 ## not if service is enable and port active -- > 
iptables -A INPUT -i eth0 -p tcp --dport 8080 -j ACCEPT
iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8080
```

## Disable ipv6 

To disable ipv6, you have to open /etc/sysctl.conf using any text editor and insert the following lines at the end:

```
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
```

If ipv6 is still not disabled, then the problem is that sysctl.conf is still not activated.

To solve this, open a terminal(Ctrl+Alt+T) and type the command,

```
sudo sysctl -p
```

You will see this in the terminal:

```
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
```

After that, if you run:
```
$ cat /proc/sys/net/ipv6/conf/all/disable_ipv6
```

It will report:
```
1
```

If you see 1, ipv6 has been successfully disabled.

## vlan


##### Install
```
$ sudo apt-get install vlan 
$ sudo modprobe 8021q
```
##### Manage
```
$ vconfig add eth1.10
$ vconfig rem eth1.10
Removed VLAN -:eth1.10:-
$ ip a l eth1.10
Device "eth1.10" does not exist.
```

## SELINUX

```
/etc/sysconfig/selinux
```
```
sestatus
```

1-Edit /etc/selinux/config and set the SELINUX variable to 'disabled'

If SELinux is disabled, then you should be able to do this: 

```
find / -exec setfattr -x security.selinux {} \; 
```
2-Use the setenforce command to disable on-the-fly

```
setenforce 0 'to disable
setenforce 1 'to enable
```

With solution 1, your changes are permanent but only effective if you reboot the machine.

With solution 2, your changes are NOT permanent but effective immediately.


## TIPS 

Try the following:

```
grep -v -e '^$' foo.txt
```

The -e option allows regex patterns for matching.

The single quotes around ^$ makes it work for Cshell. Other shells will be happy with either single or double quotes.

UPDATE: This works for me for a file with blank lines or "all white space" (such as windows lines with "\r\n" style line endings), whereas the above only removes files with blank lines and unix style line endings:

```
grep -e -v '^[[:space:]]*$' foo.txt
```

#######################################################################################################

https://t37.net/how-to-fix-your-elasticsearch-cluster-stuck-in-initializing-shards-mode.html

```
for shard in $(curl -XGET http://localhost:9200/_cat/shards | grep UNASSIGNED | awk '{print $2}'); do
    curl -XPOST 'localhost:9200/_cluster/reroute' -d '{
        "commands" : [ {
              "allocate" : {
                  "index" : "t37", 
                  "shard" : $shard, 
                  "node" : "datanode15", 
                  "allow_primary" : true
              }
            }
        ]
    }'
    sleep 5
done
```

### Elastic 

This is a common issue arising from the default index setting, in particularly, when you try to replicate on a single node. To fix this with transient cluster setting, do this:

```
curl -XPUT http://localhost:9200/_settings -d '{ "number_of_replicas" :0 }'
```

Next, enable the cluster to reallocate shards (you can always turn this on after all is said and done):

```
curl -XPUT http://localhost:9200/_cluster/settings -d '
{
    "transient" : {
        "cluster.routing.allocation.enable": true
    }
}'
```

Now sit back and watch the cluster clean up the unassigned replica shards. If you want this to take effect with future indices, don't forget to modify elasticsearch.yml file with the following setting and bounce the cluster:

```
index.number_of_replicas: 0
```

## grep exlcude dash and empty lines

```
# cat file |egrep -v "^#|^$"
```

## PV

```
pv -tpreb openelec_raspi_imagenio.img | dd of=/dev/disk1 bs=1m
| dd if=/dev/urandom | pv | dd of=/dev/null

pv -treb 2017-11-29-raspbian-stretch-lite.img | dd of=/dev/disk2 bs=1m && sync
```

## Forward to a Gmail mail server

To configure SSMTP, you will have to edit its configuration file (/etc/ssmtp/ssmtp.conf) and enter your account settings:

```
/etc/ssmtp/ssmtp.conf
```

```
 # The user that gets all the mails (UID < 1000, usually the admin)
 root=username@gmail.com

 # The mail server (where the mail is sent to), both port 465 or 587 should be acceptable
 # See also https://support.google.com/mail/answer/78799
 mailhub=smtp.gmail.com:587

 # The address where the mail appears to come from for user authentication.
 rewriteDomain=gmail.com

 # The full hostname
 hostname=localhost

 # Use SSL/TLS before starting negotiation
 UseTLS=Yes
 UseSTARTTLS=Yes

 # Username/Password
 AuthUser=username
 AuthPass=password

 # Email 'From header's can override the default domain?
 FromLineOverride=yes
```

**Note**: Take note, that the shown configuration is an example for Gmail, You may have to use other settings. If it is not working as expected read the man page man 8 ssmtp, please.

Create aliases for local usernames (optional)

```
/etc/ssmtp/revaliases
```
```
root:username@gmail.com:smtp.gmail.com:587
mainuser:username@gmail.com:smtp.gmail.com:587
```

To test whether the Gmail server will properly forward your email:

```
$ echo test | mail -v -s "testing ssmtp setup" tousername@somedomain.com
```

**Reference**: https://easyengine.io/tutorials/linux/ubuntu-postfix-gmail-smtp/


###  Elastic cheat 

you can always set it up externally while starting elasticsearch:

	$ elasticsearch -f -Des.config=<NewConfig>

### TIPS 

Try the following:

	grep -v -e '^$' foo.txt

The -e option allows regex patterns for matching.

The single quotes around `^$` makes it work for Cshell. Other shells will be happy with either single or double quotes.

UPDATE: This works for me for a file with blank lines or **"all white space"** (such as windows lines with `"\r\n"` style line endings), whereas the above only removes files with blank lines and unix style line endings:

	grep -e -v '^[[:space:]]*$' foo.txt

If you want to delete lines 5 through 10 and 12:

	sed -e '5,10d;12d' file

This will print the results to the screen. If you want to save the results to the same file:

	sed -i.bak -e '5,10d;12d' file

This will back the file up to file.bak, and delete the given lines.

To delete line 5, do:

	sed -i '5d' file.txt

For a variable line number:

	sed -i "${line}d" file.txt

If the -i option isn't available in your flavor of sed, you can emulate it with a temp file:

	sed "${line}d" file.txt > file.tmp && mv file.tmp file.txt
	
#### raid

	mdadm --assemble --uuid <uuid> /dev/md0

### nmap

You can use Nmap's snmp-brute something like

	nmap -sU -p161 --script snmp-brute --script-args snmplist=community.lst 192.168.1.0/24

## Check-MK Reinventorize with cmk -II

As of version 1.1.7i1 Check_MK supports the option -II. It does exactly the same as -I but removes all existing checks before doing the inventory. Only those checks are affected that are being inventorized. Example 1:

	root@linux# cmk -II df xyzsrv01

This first removes all checks of type df on host xyzsrv01 and then does inventory.

Example 2:

	root@linux# cmk -II xyzsrv01

This removes all agent based of host xyzsrv01 before doing inventory.

You can even do a check_mk -II and thus reinventorize all agent based checks on all hosts - and removing all checks currently not found on the target hosts.

### Rsyslog

How to forward specific log file outside of /var/log with rsyslog to remote server?

Just setup an imfile rule in your /etc/rsyslog.conf

```
#/etc/rsyslog.conf
$ModLoad imfile
$InputFileName /data/mysql/error.log
$InputFileTag mysql-error
$InputFileStateFile stat-mysql-error
$InputFileSeverity error
$InputFileFacility local3
$InputRunFileMonitor
local3.* @@hostname:<portnumber>
This watches a file and saves to the local3 facility in syslog. Then you can send all data from the local3 facility to your remote server. You may also want to add the following to your rsyslog conf (usually /etc/rsyslog.d/50-default.conf on Ubuntu) to not save the local3 facility to /var/log/syslog:
```

```
#/etc/rsyslog.d/50-default.conf
*.*;auth,authpriv.none,local1.none,local2.none,local3.none,local4.none,local5.none,local6.none          -/var/log/syslog
```

Additionally, I would encourage some reading from the following rsyslog docs for more advanced filtering:

http://www.rsyslog.com/doc/property_replacer.html

http://www.rsyslog.com/doc/rsyslog_conf_filter.html

### gmail searches

```
!is:starred !is:important label:unread 
```

### shell history bashrc

Putting this in ~/.bashrc will apply @alvin's solution across different sessions as wlell

```
HISTCONTROL=ignoredups:erasedups
shopt -s histappend
PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"
```

## CRONTAB

Some time ago I used cron to do just that. You can make an entry like this

	@reboot /path/to/my/script

More info here

```
Instead of the first five fields, one of eight special strings may appear:
       string          meaning
       ------          -------@reboot ------@reboot
       @reboot         Run once, at startup.
       @yearly         Run once a year, "0 0 1 1 *".
       @annually       (same as @yearly)
       @monthly        Run once a month, "0 0 1 * *".
       @weekly         Run once a week, "0 0 * * 0".
       @daily          Run once a day, "0 0 * * *".
       @midnight       (same as @daily)
       @hourly         Run once an hour, "0 * * * *".
```

## Update Ruby osx

Open your terminal and run

```
curl -sSL https://get.rvm.io | bash -s stable
```

When this is complete, you need to restart your terminal for the rvm to work.

Now, run `rvm list known`

This shows the list of versions of the ruby.

Now, run `rvm install ruby-2.4.2`

If you type `ruby -v` in the terminal, you should see `ruby 2.4.2`.

If it still shows you ruby 2.0., run `rvm use ruby-2.4.2 --default`.

### switch ruby version

```
$ hist rvm
$ curl -sSL https://get.rvm.io | bash -s stable
$ rvm list known
$ rvm install ruby-2.4.2
$ rvm use ruby-2.4.2 --default

RVM is not a function, selecting rubies with 'rvm use ...' will not work.

You need to change your terminal emulator preferences to allow login shell.
Sometimes it is required to use `/bin/bash --login` as the command.
Please visit https://rvm.io/integration/gnome-terminal/ for an example.
```
```
Warning! PATH is not properly set up, '/Users/jaci/.rvm/gems/ruby-2.4.2/bin' is not at first place.
         Usually this is caused by shell initialization files. Search for 'PATH=...' entries.
         You can also re-add RVM to your profile by running: 'rvm get stable --auto-dotfiles'.
         To fix it temporarily in this shell session run: 'rvm use ruby-2.4.2'.
         To ignore this error add rvm_silence_path_mismatch_check_flag=1 to your ~/.rvmrc file.
Warning, new version of rvm available '1.29.8-next', you are using older version '1.29.3'.
You can disable this warning with:    echo rvm_autoupdate_flag=0 >> ~/.rvmrc
You can enable  auto-update  with:    echo rvm_autoupdate_flag=2 >> ~/.rvmrc

$ bundle install

Downloading jekyll-3.6.3 revealed dependencies not in the API or the lockfile (kramdown (~> 1.14), rouge (< 3, >= 1.7)).
Either installing with `--full-index` or running `bundle update jekyll` should fix the problem.

In Gemfile:
  github-pages was resolved to 155, which depends on
    jekyll-avatar was resolved to 0.4.2, which depends on
      jekyll
```

## Uninstall java JDK MacOS
 
I was able to unistall jdk 8 in mavericks successfully doing the following steps:

Run this command to just remove the JDK

```
sudo rm -rf /Library/Java/JavaVirtualMachines/jdk<version>.jdk
```

Run these commands if you want to remove plugins

```
sudo rm -rf /Library/PreferencePanes/JavaControlPanel.prefPane
sudo rm -rf /Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin
sudo rm -rf /Library/LaunchAgents/com.oracle.java.Java-Updater.plist
sudo rm -rf /Library/PrivilegedHelperTools/com.oracle.java.JavaUpdateHelper
sudo rm -rf /Library/LaunchDaemons/com.oracle.java.Helper-Tool.plist
sudo rm -rf /Library/Preferences/com.oracle.java.Helper-Tool.plist
```

### systemd send logs

	log stream --predicate 'eventMessage contains "docker"'


### sudo nopasswd

	%sudo  ALL=(ALL) NOPASSWD:ALL

### npm truffle

```
npm uninstall -g truffle
apt purge npm
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
npm i -g truffle
```
### Change user uid and gid, also file permissions

In this example we change uid and gid on user elasticsearch, 

```
[root@elkm02 ~]# id elasticsearch
uid=997(elasticsearch) gid=995(elasticsearch) grupos=995(elasticsearch)
```

Currently has **997** for uid and **995** at group, we want to change so it matches other cluster users and will fix permissions for **_snapshot** directories on elasticsearch.

Remember to check before if those uid and gid numbers are already used by other user/groups

Change uuid 
```
usermod -u 996 elasticsearch
```
Change gid
```
groupmod -g 994 elasticsearch
```
Find and change all file belongings to user-group

```
find / -uid 997 -exec chown elasticsearch {} \;
find / -gid 995 -exec chgrp elasticsearch {} \;
```
### EtcKeeper

Follow these steps [https://coderwall.com/p/v1agsg/installing-etckeeper-to-store-config-with-autopush-to-git-in-ubuntu-14-04-lts](https://coderwall.com/p/v1agsg/installing-etckeeper-to-store-config-with-autopush-to-git-in-ubuntu-14-04-lts)

## Debian Update

First update the current version to the lastest packages.

```
apt-get update && apt-get -y upgrade && apt-get -y dist-upgrade
```

Reboot if you're able to, if not just go through editing `sources.list`.

```
$ sed -i /deb/s/jessie/stretch/g /etc/apt/sources.list
$ sed -i /deb/s/jessie/stretch/g /etc/apt/sources.list.d/*.list
```
After that, run again `update`, `upgrade` and `dist-upgrade`.

## gpg-agent

[https://medium.com/@doronsegal/gpg-agent-is-older-than-x-e8860a383cb0](https://medium.com/@doronsegal/gpg-agent-is-older-than-x-e8860a383cb0)

It seems like the version of the running gpg agent was different from the one pass was running (under the hood it’s GnuPG). In order to be able to read my password again I had to “kill” the running agent so the GnuPG could use the newer version (I was using -v for verbose mode).

```
gpgconf --kill -v gpg-agent
```

## password-store pattern

When using `pass` save passwords with this pattern in order to make firefox plugin work.

```
MyPassword
---
path / reference.com
username: username
password: MyPassword
url: http://www.example.com/path
```

## Install GO

```
curl -O https://storage.googleapis.com/golang/go1.11.2.linux-amd64.tar.gz
tar xvzf go1.11.2.linux-amd64.tar.gz 
sudo mv go /usr/local/
export GOROOT=/usr/local/go 
export GOPATH=$HOME/src/workspace
export PATH=$GOROOT/bin:$GOPATH/bin:$PATH
echo $GOROOT
echo $GOPATH
echo "export GOROOT=/usr/local/go" >> .bashrc 
echo "export GOPATH=$HOME/src/workspace" .bashrc
echo "export PATH=$GOROOT/bin:$GOPATH/bin:$PATH" >> .bashrc 
go version
```



#######################################################################################################
