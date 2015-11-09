# timstaley.comet

An [Ansible][] [role][] that provides an installation of the 
[Comet][] [VOEvent][] broker.


[Ansible]: http://www.ansible.com/configuration-management
[role]: http://docs.ansible.com/ansible/playbooks_roles.html

[VOEvent]: http://voevent.rtfd.org
[Comet]: http://comet.readthedocs.org/

## Outline
This role will install the bare minimum to get a
[Comet](http://comet.readthedocs.org/) instance up and running, and won't
actually do anything with the VOEvents they receive. The Comet-invocation script
can be supplied as a role-argument, so you can easily change that to set up
passing of VOEvents to your own custom code.

## Deployment details
The scripts create a pair of non-sudo users, defined by default as 
`cometdeploy` and `cometserve`.
VOEvent handling code and virtualenvs are dropped into ``/home/cometdeploy``,
then run in read-only mode as the `cometserve` user (this provides extra
security in the worse-case scenario that Comet has some serious security exploit
hole, e.g. to malformed packets). Logs etc are dumped into 
`/home/cometserve/working_dir`. 


## Usage
### Setup
Note that building the LXML package (which is a dependency) usually requires
significantly more than 512MB of RAM. 
For the test-VM setup we make use of a
swapfile, via a ready-made role from
[kamaln7](https://github.com/kamaln7/ansible-swapfile). 
You'll need to install the role using the `ansible-galaxy` command line tool
before running the tests.

### Vagrant VM for testing
To pull up a working VM with Comet installed:

    cd vagrant
    ansible-galaxy install kamaln7.swapfile
    ansible-galaxy install timstaley.base
    vagrant up
    

    
### Ansible on a pre-existing Ubuntu installation
Running against a pre-existing machine is a bit more complicated because there 
are more possible variables, and you may want to familiarize yourself with 
the Ansible docs first. In short, you'll need to:

 - Configure your ansible 
  [inventory](http://docs.ansible.com/intro_inventory.html#inventory)
  to reach the desired machines. Test with e.g. `ansible -m ping all`.
 - Modify [test-comet-role.yml](test/test-comet-role.yml) as required. 
  You probably don't want/need swapfile configuration, and you will need to set 
  the `hosts` to match your inventory.
 - Run your new [playbook](http://docs.ansible.com/ansible/playbooks.html) 
  file using the `ansible-playbook` command.


    
