# !/bin/bash

virsh destroy devnode1localhost
virsh undefine devnode1localhost
virsh destroy devnode2localhost
virsh undefine devnode2localhost
virsh destroy devnode1devmachine2
virsh undefine devnode1devmachine2
virsh destroy devnode2devmachine2
virsh undefine devnode2devmachine2


#rm /home/calin/images/focal-server-cloudimg-amd64.img
rm /home/calin/images/image_devnode*
rm /home/calin/images/devnode*
