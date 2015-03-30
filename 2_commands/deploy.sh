# quick fix for missing msgpack
sh -i ~/.ssh/salt-demo.pem ubuntu@x.x.x.x
sudo apt-get update
sudo apt-get install python-msgpack


## initialize master on basic Ubuntu EC2 instance with salt-ssh

# set master public IP
sudo vi /etc/salt/roster

# set master private IP
sudo vi /srv/pillar/master.sls

# initialize master
sudo salt-ssh -i --priv=.ssh/salt-demo.pem 'master' state.highstate

# accept own minion
sudo salt-key -a master


## setup new minions with salt-cloud from EC2 master
sudo salt-cloud -P -m /root/minions-map.yml

# get public ips from salt
sudo salt '*' cmd.run 'curl ipecho.net/plain 2>/dev/null'
# get private ips from salt
sudo salt '*' grains.get ipv4

# setup roster_ec2
# …
