
- setup the inventory file here:  /etc/ansible/hosts
- setup ssh agent so that it remembers the ssh key passphrase: 
    ```
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/[key-private-file]
    ```
- show the ansible inventory by running ``` ansible-inventory --list -y ```
- test the inventory by running ``` ansible all -m ping -u [user] ```

Run the playbook:
kvmlab/createall.sh

Destroy the vm:
sudo kvmlab/clearall.sh

