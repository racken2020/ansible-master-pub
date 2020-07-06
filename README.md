# LDP Linux machine standard config
github URL: https://github.rackspace.com/ken2026/ansible-master

This ansible repository contains playbooks and roles for creating Linux machines compliant to Legacy Datapipe standard configurations.


## Obtaining repository
This repo uses git submodules. Use these instructions for cloning everything. For this to work, you will need to first setup your ssh key on github. See [this](https://help.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account) for instructions.

```
# clone the main repo and pull submodules
mkdir -p work/ansible-master
git clone --recurse-submodules git@github.rackspace.com:ken2026/ansible-master.git work/ansible-master
cd ansible-master
sh env-setup.sh
```

## Usage
This ansible environment is best used on SANTA environment. After downloading this repository, you will need to

1. Create the inventory file under ```client-specific/hosts```. Minimally, you need to enter the hostname and the IP of the item. See example below. Hostname will be used to set the system hostname and populate hosts table.
2. Obtain ssh keys for the servers and the key for the linux bastion if there is one 
3. Set the besgroup variable in the inventory file, which is self-explanatory
4. Set the snmp v2 community string. v2 is the standard. em7 doesn't work well with v3
5. Set the timezone variable, which sets the timezone on target machines
6. Create keys/.vault-pass with CID
7. Run ansible-playbook dp-managed.yml which performs LDP Linux checklist

### Supported OS
The dp-managed.yml playbook has been tested on RHEL6/7, CentOS6/7/8, AmazonLinux1/2, Ubuntu 18

### Sample inventory
You will see the same content in the ```hosts``` inventory file

```
web01.acme.local ansible_host=1.2.3.4

[all:vars]
customerID=1234
customerName=SomeCompany
besgroup="{{customerName}}%20-%20{{customerID}}"
besrelay=besmaster.datapipe.net
besclient_url=https://d3oaojvgmti3yr.cloudfront.net/BES-universal-installer.tbz
sys_timezone=UTC
ansible_user=ec2-user
ansible_ssh_private_key_file=keys/kfong-aws-jp
# set this if behind bastion
# ansible_ssh_common_args='-o ControlMaster=auto -o ProxyCommand="ssh -W %h:%p -q -i keys/bast-key ec2-user@1.2.3.4"'
```

### Special note on RHEL8
For RHEL8, python is not installed by default. platform-python is used instead and it's placed under /usr/libexec/platform-python. Ansible would fail at fact gathering stage as it failed to locate python. Workaround is to specify the ansible_python_interpreter variable in the inventory.

```
1.2.3.4 ansible_python_interpreter=/usr/libexec/platform-python
```

### Special note on Ubuntu
For Ubuntu, we need to tell ansible where python is with the ansible_python_interpreter variable. It can be set as group var if you have many machines, or it can be set to individual host like this:

```
ubuntu01.acme.local ansible_host=13.231.80.45 ansible_user=ubuntu ansible_python_interpreter=/usr/bin/python3
```

### Todo
Break down this repo into individual repositories, pretty much like ansible galaxy. Each repo will contain 1 or a few roles. Client specific ansible environment can then import submodules as needed.

### To use gpg signing, run these
```
git config --local user.name "Ken Fong"
git config --local user.email ken.fong@rackspace.com
git config --local user.signingkey A163269548EFF189FE34FA9D9C141E6FB3A8DC76
```

## References
[The official doc for LDP Linux checklist](https://portal.datapipe.net/support/unix/wiki/Wiki%20Pages/New%20Unix%20Server%20QA.aspx)

