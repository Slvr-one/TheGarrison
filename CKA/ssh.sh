#!/bin/bash
set -eux

----
student-node ~ ➜  ssh cluster1-controlplane
Welcome to Ubuntu 18.04.6 LTS (GNU/Linux 5.4.0-1086-gcp x86_64)

To get back to the student node, use the (logout) or (exit) command, or, hit (Control +D)

----

Inspect the value assigned to data-dir on the etcd pod:

k -n kube-system describe po etcd-cluster1-controlplane | grep data-dir

----
Check the members of the cluster:
(after ssh to external etcd server - [ssh etcd-server])

ETCDCTL_API=3 etcdctl \
    --endpoints=https://127.0.0.1:2379 \
    --cacert=/etc/etcd/pki/ca.pem \
    --cert=/etc/etcd/pki/etcd.pem \
    --key=/etc/etcd/pki/etcd-key.pem \
    member list

----
----

inspect the endpoints and certificates used by the etcd pod to take the backup.

kubectl describe  pods -n kube-system etcd-cluster1-controlplane  | grep advertise-client-urls

kubectl describe  pods -n kube-system etcd-cluster1-controlplane  | grep pki


----

SSH to the controlplane node of cluster1 and then take the backup using the endpoints and certificates we identified above:

ETCDCTL_API=3 etcdctl \
    --endpoints=https://10.1.220.8:2379 \
    --cacert=/etc/kubernetes/pki/etcd/ca.crt \
    --cert=/etc/kubernetes/pki/etcd/server.crt \
    --key=/etc/kubernetes/pki/etcd/server.key \
    snapshot save /opt/cluster1.db

Finally, copy the backup to the student-node. To do this, go back to the student-node and use scp:

scp cluster1-controlplane:/opt/cluster1.db /opt

----
----

An ETCD backup for cluster2 is stored at /opt/cluster2.db.
    Use this snapshot file to carryout a restore on cluster2 to a new path /var/lib/etcd-data-new.

----

Copy the snapshot file from the student-node to the etcd-server to the /root directory:

scp /opt/cluster2.db etcd-server:/root


----

Restore the snapshot on the cluster2. 
Since we are restoring directly on the etcd-server,
    we can use the endpoint https:/127.0.0.1. 
    Use the same certificates that were identified earlier. 
    Make sure to use the data-dir as /var/lib/etcd-data-new:

ETCDCTL_API=3 etcdctl \
    --endpoints=https://127.0.0.1:2379 \
    --cacert=/etc/etcd/pki/ca.pem \
    --cert=/etc/etcd/pki/etcd.pem \
    --key=/etc/etcd/pki/etcd-key.pem \
    snapshot restore /root/cluster2.db \
    --data-dir /var/lib/etcd-data-new

----

Update the systemd service unit file for etcd by running:

vi /etc/systemd/system/etcd.service, add the new value for data-dir:

[Unit]
Description=etcd key-value store
Documentation=https://github.com/etcd-io/etcd
After=network.target

[Service]
User=etcd
Type=notify
ExecStart=/usr/local/bin/etcd \
  --name etcd-server \
  --data-dir=/var/lib/etcd-data-new \ <-- (change to new data dir, thats all)

----

Step 4: make sure the permissions on the new directory is correct (should be owned by etcd user):

chown -R etcd:etcd /var/lib/etcd-data-new
ls -ld /var/lib/etcd-data-new/

----

reload and restart the etcd service.

systemctl daemon-reload 
systemctl restart etcd

----

(optional): It is recommended to restart controlplane components 
(e.g. kube-scheduler, kube-controller-manager, kubelet) 
to ensure that they don't rely on some stale data.


