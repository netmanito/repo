# Intro

	echo "I'm a Unix Creationist, the world was created on $(TZ=GMT date -d @0) and it will end on $(TZ=GMT date -d @$((2**31-1)))"

## Resources

#### Debian show available package versions

Try with

    apt-cache madison myPackage

Quote from man page:

    It displays available versions of a package in a tabular format.

#### Git Bash Completion

First get the git-completion.bash script (view it here) and put it in your home directory:

	curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash

Next, add the following lines to your .bash_profile. This tells bash to execute the git autocomplete script if it exists.

	if [ -f ~/.git-completion.bash ]; then
  		. ~/.git-completion.bash
	fi

#### Git move files between branches

	git checkout master               # first get back to master
	git checkout experiment -- app.js # then copy the version of app.js 
    	                              # from branch "experiment"
#### Nectat send files 

On your server (A):

	nc -l -p 1234 -q 1 > something.zip < /dev/null

On your "sender client" (B):

	cat something.zip | netcat server.ip.here 1234

#### Vim Text selection


V       - selects entire lines 
v       - selects range of text
ctrl-v  - selects columns
gv      - reselect block

After selecting the text, try d to delete, or y to copy, or :s/match/replace/, or :center, or !sort, or... 

#### Iptables port fowarding

iptables -t nat -A PREROUTING -i eth1 -p tcp --dport 8080 -j DNAT --to 10.32.25.2:80
iptables -t nat -A PREROUTING -p tcp --dport 8080 -j DNAT --to 10.32.25.2:80
iptables -t nat -A POSTROUTING -p tcp -d 10.32.25.2 --dport 80 -j MASQUERADE

#### Debian vlan

##### Install

	$ sudo apt-get install vlan 
	$ sudo modprobe 8021q

##### Manage

	$ vconfig add eth1.10
	$ vconfig rem eth1.10
	Removed VLAN -:eth1.10:-
	$ ip a l eth1.10
	Device "eth1.10" does not exist.

#### EGrep exclude empty lines and anchor #

	cat file |egrep -v "^#|^$"

##### Explanation

Try the following:

	grep -v -e '^$' foo.txt

The -e option allows regex patterns for matching.

The single quotes around ^$ makes it work for Cshell. Other shells will be happy with either single or double quotes.

UPDATE: This works for me for a file with blank lines or "all white space" (such as windows lines with "\r\n" style line endings), whereas the above only removes files with blank lines and unix style line endings:

	grep -e -v '^[[:space:]]*$' foo.txt

#### Change user uid and gid, also file permissions

In this example we change uid and gid on user elasticsearch, 

	[root@elkm02 ~]# id elasticsearch
	uid=997(elasticsearch) gid=995(elasticsearch) grupos=995(elasticsearch)

Currently has **997** for uid and **995** at group, we want to change so it matches other cluster users and will fix permissions for **_snapshot** directories on elasticsearch.

Remember to check before if those uid and gid numbers are already used by other user/groups

Change uuid 

	usermod -u 996 elasticsearch

Change gid

    groupmod -g 994 elasticsearch

Find and change all file belongings to user-group

    find / -uid 997 -exec chown elasticsearch {} \;
    find / -gid 995 -exec chgrp elasticsearch {} \;
