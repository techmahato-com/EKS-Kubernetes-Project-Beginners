jenkins@Jenkins:~$ cd monitoring/
jenkins@Jenkins:~/monitoring$ ls
storage
jenkins@Jenkins:~/monitoring$ cd storage/
jenkins@Jenkins:~/monitoring/storage$ vim sc.yml
jenkins@Jenkins:~/monitoring/storage$ vim pvc.yml
jenkins@Jenkins:~/monitoring/storage$ cd ..
jenkins@Jenkins:~/monitoring$ k apply -f storage/
persistentvolumeclaim/ebs-gp3-sc created
storageclass.storage.k8s.io/ebs-gp3-sc created
jenkins@Jenkins:~/monitoring$ k get pv
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS     CLAIM                      STORAGECLASS   VOLUMEATTRIBUTESCLASS   REASON AGE
pvc-a29b0d36-de2f-4d58-bdeb-3966d8d318fd   5Gi        RWO            Retain           Released   custom-namespace/ebs-pvc   ebs-sc         <unset> 9d
jenkins@Jenkins:~/monitoring$ k get pvc
NAME         STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   VOLUMEATTRIBUTESCLASS   AGE
ebs-gp3-sc   Pending                                      ebs-gp3-sc     <unset>                 22s
jenkins@Jenkins:~/monitoring$ k get sc
NAME                   PROVISIONER       RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
ebs-gp3-sc (default)   ebs.csi.aws.com   Retain          WaitForFirstConsumer   true                   30s


