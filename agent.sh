#!/usr/bin/env bash

sudo apt-get update -y

sudo apt-get install -y openssh-server openssh-client puppet vim

sudo ufw disable

cd /tmp/
fqdn=$(facter fqdn)
master="192.168.99.101\tammaster.qac.local\tpuppetmaster"
lo="127.0.1.1\t$fqdn\$amagent1"
sudo echo -e $master > /tmp/newhosts

ip=$(facter ipaddress_eth1)
local="$ip\t$fqdn\tpuppet"
sudo echo -e $local > /tmp/newhosts

host="127.0.0.1\t$fqdn\tpuppet"
sudo echo -e $host >> /tmp/newhosts
sudo echo -e $lo >> /tmp/newhosts

sudo cat /tmp/newhosts > /tmp/temphosts
sudo cat /etc/hosts >> /tmp/temphosts
sudo mv /tmp/temphosts /etc/hosts
sudo rm /tmp/newhosts
echo "Hosts have been configured"

sudo sed -i -e '2iserver=ammaster.qac.local' /etc/puppet/puppet.conf

sudo service puppet stop
sudo service puppet start
sudo puppet agent --test

sudo puppet agent --enable
sudo puppet agent --test

export JAVA_HOME=/usr/
echo "Agent configured"

