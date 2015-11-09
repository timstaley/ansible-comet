#timstaley.comet

An [Ansible][] [role][] that provides an installation of the 
[Comet][] [VOEvent][] broker.


[Ansible]: http://www.ansible.com/configuration-management
[role]: http://docs.ansible.com/ansible/playbooks_roles.html

[VOEvent]: http://voevent.rtfd.org
[Comet]: http://comet.readthedocs.org/

##Outline
This role will install the bare minimum to get a
[Comet](http://comet.readthedocs.org/) instance up and running, and won't
actually do anything with the VOEvents they receive. The Comet-invocation script
can be supplied as a role-argument, so you can easily change that to set up
passing of VOEvents to your own custom code.

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
    
