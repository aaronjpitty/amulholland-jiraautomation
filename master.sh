#!/usr/bin/env bash

sudo apt-get update

sudo apt-get install -y openssh-server openssh-client puppet puppetmaster vim

sudo ufw disable

cd /tmp/

fqdn=$(facter fqdn)
ip=$(facter ipaddress_eth1)

local="127.0.0.1\t$fqdn\tpuppetmaster"
network="£ip\t$fqdn\tpuppetmaster"
lo="$127.0.0.1\t$fqdn\tammaster"

sudo echo -e $local > /tmp/newhosts
sudo echo -e $network > /tmp/newhosts
sudo echo -e $lo > /tmp/newhosts

sudo cat /tmp/newhosts > /tmp/temphosts
sudo cat /etc/hosts >> /tmp/temphosts
sudo mv /tmp/temphosts /etc/hosts
sudo rm /tmp/newhosts

sudo touch /etc/puppet/manifests/site.pp

sudo cat > /etc/puppet/manifests/site.pp << EOF
note 'amagent1.qac.local' {

}
EOF

sudo touch /etc/puppet/autosign.conf
sudo echo 'amagent1.qac.local' >> /etc/puppet/autosign.conf
sudo echo '*.qac.local' >> /etc/puppet/autosign.conf

sudo cp -r /tmp/shared/jira /etc/puppet/modules/
echo "Master complete"
