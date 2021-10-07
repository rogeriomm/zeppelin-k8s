   * https://zeppelin.apache.org/docs/0.10.0/quickstart/kubernetes.html: Zeppelin on Kubernetes


   * _/etc/hosts_ 
```commandline
echo $(minikube ip) zeppelin.local | sudo bash -c "cat >> /etc/hosts"
```


  * https://github.com/apache/zeppelin/blob/master/k8s/zeppelin-server.yaml: Zeppelin k8s sample

  * https://kubernetes.io/docs/concepts/workloads/pods/init-containers/: Init Containers

# Issues
## Spark init container error
   * https://kubernetes.io/docs/tasks/debug-application-cluster/debug-init-containers/
   
```commandline
kubectl get pods spark-bizjkm -o yaml
kubectl describe pod/spark-bizjkm
```

   * https://github.com/apache/zeppelin/blob/master/k8s/interpreter/100-interpreter-spec.yaml


# Minikube mount
   * https://minikube.sigs.k8s.io/docs/handbook/mount/
![image info](minikube-mount.png)
   * https://thospfuller.com/2020/12/09/learn-how-to-mount-a-local-drive-in-a-pod-in-minikube-2021/