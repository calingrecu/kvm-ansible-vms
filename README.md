
# Purpose
A simple Ansible solution for creating VMs on multiple Linux hosts.

## Prerequisites

### KVM on Linux

This project creates KVM VMs on Linux. Prior to running it, KVM needs to be installed on all the hosts.

### Bridge network

Each host needs to have a bridge named "br0" defined because the VMs are created on that bridge. 

### An ssh key for each host

Since each host needs to be accessible through ssh, an ssh key needs to provisioned for each host, or, if required, separate ssh keys for each host. To make it easier to use the ssh keys, it is recommended to use the ssh agent on the machine that runs Ansible and performs the deployment, so that it remembers the ssh key passphrase. Something like this in your bashrc file:

```
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/[key-private-file]
```

### The inventory file

Put the inventory file here: /etc/ansible/hosts
This file needs to be deployed on the machine that runs Ansible.
Here is an example that works with the current project setup:

```
[vmhosts]
hostmachine1 ansible_connection=ssh ansible_ssh_private_key_file=/home/[user]/.ssh/[key] ansible_user=[user]
hostmachine2 ansible_connection=ssh ansible_ssh_private_key_file=/home/[user]/.ssh/[key] ansible_user=[user]
hostmachine3 ansible_connection=ssh ansible_ssh_private_key_file=/home/[user]/.ssh/[key] ansible_user=[user]
hostmachine4 ansible_connection=ssh ansible_ssh_private_key_file=/home/[user]/.ssh/[key] ansible_user=[user]
```

A simple way to test if the inventory file and the access to hosts work from Ansible is:
- show the ansible inventory by running
``` 
ansible-inventory --list -y 
```
- test the inventory by running
```
ansible all -m ping -u [user]
```

## Implementation

Here is the approach taken:
- download a cloud image, for instance from [cloud-images.ubuntu.com](https://cloud-images.ubuntu.com)
- for each VMs that needs to be created, running on each host:
  - create a user data template yaml file to where the VM user information is stored. This will be used as cloud config when performing the KVM installation.
  - create a VM specific disk image and resize it to match the disk size needed
  - run the KVM command **virt-install** which creates the VM

The Ansible project defines a role called **vmspawn** containing two tasks, the default **main** and the helper **create_vm**. The former downloads the image from the cloud site, then loops for each VM and calls the latter script which creates the VM.

The cloud config that has been used is minimal and can be extended to perform additional installations and activities. It currently contains configuration that defines the VM name, some required packages, and the user to be created for the VM (user name and ssh key). Last but not least, it also instructs the VM to reboot itself at the end so that the VM name gets registed with the local DNS.

All the defaults are defined in the main.yml under *defaults* directory of the role and the corresponding variables are found in the playbook.

