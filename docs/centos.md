# CENTOS


1. yum update
2. yum -y install net-tools vim screen mc less openssh-server curl wget 
3. systemctl start sshd.service 
3. yum -y install epel-release

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

rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm

## system proxy 

If your internet connection is behind a web proxy, you need to configure the following on your CentOS server:

System-wide proxy settings - add the following lines to your **/etc/environment** file:

	$ vi /etc/environment
	
Add the following lines.
 
	http_proxy="http://proxysrv:8080/"
	https_proxy="https://proxysrv:8080/"
	ftp_proxy="ftp://proxysrv:8080/"
	no_proxy=".mylan.local,.domain1.com,host1,host2"

To apply these settings without restarting the machine run the following commands on the bash shell:

	export http_proxy="http://proxysrv:8080/"
	export https_proxy="https://proxysrv:8080/"
	export ftp_proxy="ftp://proxysrv:8080/"
	export no_proxy=".mylan.local,.domain1.com,host1,host2"

You also need to configure yum:

	vi /etc/yum.conf
	
Include this in yum conf
