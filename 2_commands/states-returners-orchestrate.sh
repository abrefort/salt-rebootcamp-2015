# setup elasticsearch in hosts files
salt minion1 grains.get ipv4
salt '*' hosts.add_host x.x.x.x elasticsearch


# install elasticsearch on minion1:
salt minion1 state.highstate

# install kibana on minion2:
salt minion2 state.highstate

# setup elasticsearch returner deps
salt '*' state.sls elasticsearch_libs

# restart minions
salt-ssh -i --priv=/root/salt-demo.pem '*' service.restart salt-minion

# return data to elasticsearch
salt '*' test.ping --return elasticsearch
salt '*' file.touch /foobar/test foobar --return elasticsearch


# demo orchestration
salt-run state.orchestrate orchestration.demo
salt 'minion*' cmd.run 'ls --time-style=full-iso -l /tmp/orchestrate'


# install saltpad on master :
salt master state.highstate
service salt-master restart

# start saltpad
cd /var/tmp/saltpad/saltpad/
sudo -u saltweb python app.py
