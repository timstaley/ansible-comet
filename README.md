#voevent-node-deploy
###Provisioning scripts for a VOEvent broker
~~Work in progress.~~ Working quite nicely, but not seriously tested yet. 


##Outline
The goal is to produce a set of [Ansible](http://docs.ansible.com) scripts which
set up a [VOEvent](http://voevent.rtfd.org) broker. These can be used to
provision a [Vagrant](https://www.vagrantup.com/) virtual machine (VM),
which can in turn be instantiated using any of the supported Vagrant 
[providers](http://docs.vagrantup.com/v2/providers/index.html) (and even
cloud-services via plugins e.g. [AWS](https://github.com/mitchellh/vagrant-aws),
[Digital Ocean](https://github.com/smdahlen/vagrant-digitalocean)). 
Alternatively, the scripts may be pointed at a pre-existing Ubuntu installation 
to add the required functionality.

These scripts will install the bare minimum to get a
[Comet](http://comet.readthedocs.org/) instance up and running, and won't
actually do anything with the VOEvents they receive. The idea is that this
repository provides a starting point for implementing a custom-broker
provisioning setup. Forks ahoy!

##Deployment details
The scripts create a pair of non-sudo users, `voeventdeploy` and `voeventserve`.
VOEvent handling code and virtualenvs are dropped into ``/home/voeventdeploy``,
then run in read-only mode as the `voeventserve` user (this provides extra
security in the worse-case scenario that Comet has some serious security exploit
hole, e.g. to malformed packets). Logs etc are dumped into `/home/voeventserve`. 


##Usage
### Setup
For the default VM setup we make use of a swapfile, to prevents out-of-memory
errors when building LXML on a machine with only 512MB of RAM. To set up the
swapfile we use a ready-made
[role](https://docs.ansible.com/playbooks_roles.html#roles) from
[kamaln7](https://github.com/kamaln7/ansible-swapfile). If you want to use this,
you'll need to pull it in 
using git submodule:

    git submodule init
    git submodule update

Alternatively, if you're running a VM with >1024MB RAM, or running ansible
against a real machine, you may prefer to simply comment out the relevant `role`
lines at the top of [voeventnode.yml](provisioning/voeventnode.yml).

### Vagrant VM
To pull up a working VM with Comet installed, simply:

    cd vagrant
    vagrant up
    
### Ansible on a pre-existing Ubuntu installation
Running against a pre-existing machine is a bit more complicated because there 
are more possible variables, and you may want to familiarize yourself with 
the Ansible docs first. In short, you'll need to:
- Configure your ansible [inventory](http://docs.ansible.com/intro_inventory.html#inventory)
  to reach the desired machines. Test with e.g. `ansible -m ping all`.
- Edit [voeventnode.yml](provisioning/voeventnode.yml) as required: 
  you probably don't want/need swapfile configuration, and you will need to set 
  the `hosts` to match your inventory.


Then:

    ansible-playbook voevent.yml
    
