# !/bin/bash

virsh destroy devnode1devmachine2
virsh undefine devnode1devmachine2
virsh destroy devnode2devmachine2
virsh undefine devnode2devmachine2

rm /tmp/kvmlab/*
