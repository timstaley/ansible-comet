#voevent-node-deploy
###Provisioning scripts for a VOEvent broker
Work in progress. 


##Outline
The goal is to produce a set of [Ansible](http://docs.ansible.com) scripts which
set up a [VOEvent](http://voevent.rtfd.org) broker. These can either be used to
provision a [Vagrant](https://www.vagrantup.com/) virtual machine, or simply
pointed at a pre-existing Ubuntu installation to add the required functionality.

These scripts will install the bare minimum to get a
[Comet](http://comet.readthedocs.org/) instance up and running, and won't
actually do anything with the VOEvents they receive. The idea is that this
repository provides a starting point for implementing a custom-broker
provisioning setup. Forks ahoy!

##Deployment details
The scripts create a pair of non-sudo users, `voeventdeploy` and `voeventserve`.
VOEvent handling code and virtualenvs are dropped into ``/home/voeventdeploy``,
then run in read-only mode as the `voeventserve` user (this provides extra
security). Logs etc are dumped into `/home/voeventserve`. 


