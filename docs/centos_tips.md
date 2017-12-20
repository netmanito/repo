# CENTOS


1. yum update
2. yum -y install net-tools vim screen mc less openssh-server curl
3. systemctl start sshd.service 
3. yum install epel-release

### change timezone centos

	$ cp /usr/share/zoneinfo/GB /etc/localtime

### yum

	$ yum whatprovides ifconfig

	$ yum install net-tools

	$ yum -y groupinstall "Development Tools"

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
