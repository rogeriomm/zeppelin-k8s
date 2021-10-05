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
```text
❯ k describe pod spark-kljisa
Name:         spark-kljisa
Namespace:    zeppelin
Priority:     0
Node:         minikube/192.168.64.4
Start Time:   Tue, 28 Sep 2021 19:00:38 -0300
Labels:       app=spark-kljisa
              interpreterGroupId=spark-shared_process
              interpreterSettingName=spark
Annotations:  <none>
Status:       Failed
IP:           172.17.0.3
IPs:
  IP:  172.17.0.3
Init Containers:
  spark-home-init:
    Container ID:  docker://2c2597a74cbf3489dc9d198f38d3878afb863ea045fc0460f2e9f486b648ba53
    Image:         rogermm/spark-base-python:3.1.2-hadoop3.2-java11-bdb
    Image ID:      docker://sha256:eadf9c55522794c745d0d986cafb086f0ef81eff222164f89f2a47517c39f3f0
    Port:          <none>
    Host Port:     <none>
    Command:
      sh
      -c
      cp -r /opt/spark/* /spark/
    State:          Terminated
      Reason:       Error
      Exit Code:    1
      Started:      Tue, 28 Sep 2021 19:00:39 -0300
      Finished:     Tue, 28 Sep 2021 19:00:39 -0300
    Ready:          False
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /spark from spark-home (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-l4rmn (ro)
Containers:
  spark:
    Container ID:
    Image:         rogermm/zeppelin-custom-0.10.0:3.1.2-hadoop3.2-java11-bdb
    Image ID:
    Port:          <none>
    Host Port:     <none>
    Args:
      $(ZEPPELIN_HOME)/bin/interpreter.sh
      -d
      $(ZEPPELIN_HOME)/interpreter/spark
      -r
      12321:12321
      -c
      zeppelin-server.zeppelin.svc
      -p
      12320
      -i
      spark-shared_process
      -l
      /tmp/local-repo/spark
      -g
      spark
    State:          Waiting
      Reason:       PodInitializing
    Ready:          False
    Restart Count:  0
    Limits:
      cpu:  1
    Requests:
      cpu:     1
      memory:  1408Mi
    Environment:
      PYSPARK_PYTHON:         python
      ZEPPELIN_HOME:          /opt/zeppelin
      SPARK_SUBMIT_OPTIONS:   --master k8s://https://kubernetes.default.svc --deploy-mode client --driver-memory 1g --conf spark.kubernetes.namespace=zeppelin --conf spark.executor.instances=1 --conf spark.kubernetes.driver.pod.name=spark-kljisa --conf spark.kubernetes.container.image=rogermm/spark-base-python:3.1.2-hadoop3.2-java11-bdb --conf spark.driver.bindAddress=0.0.0.0 --conf spark.driver.host=spark-kljisa.zeppelin.svc --conf spark.driver.port=22321 --conf spark.blockManager.port=22322
      SPARK_HOME:             /spark
      PYSPARK_DRIVER_PYTHON:  python
      SERVICE_DOMAIN:         local.zeppelin-project.org:8080
      INTERPRETER_GROUP_ID:   spark-shared_process
    Mounts:
      /spark from spark-home (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-l4rmn (ro)
Conditions:
  Type              Status
  Initialized       False
  Ready             False
  ContainersReady   False
  PodScheduled      True
Volumes:
  spark-home:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:
    SizeLimit:  <unset>
  kube-api-access-l4rmn:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   Burstable
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  51s   default-scheduler  Successfully assigned zeppelin/spark-kljisa to minikube
  Normal  Pulled     50s   kubelet            Container image "rogermm/spark-base-python:3.1.2-hadoop3.2-java11-bdb" already present on machine
  Normal  Created    50s   kubelet            Created container spark-home-init
  Normal  Started    50s   kubelet            Started container spark-home-init
```


```yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: "2021-09-28T22:30:02Z"
  labels:
    app: spark-bizjkm
    interpreterGroupId: spark-shared_process
    interpreterSettingName: spark
  name: spark-bizjkm
  namespace: zeppelin
  ownerReferences:
  - apiVersion: v1
    blockOwnerDeletion: false
    controller: false
    kind: Pod
    name: zeppelin-server-c7b9fd7b8-8fz22
    uid: da869311-c967-4373-8133-a58f27dd370b
  resourceVersion: "64219"
  uid: 2af3824d-4d5b-466f-9e83-5719e56422a1
spec:
  automountServiceAccountToken: true
  containers:
  - args:
    - $(ZEPPELIN_HOME)/bin/interpreter.sh
    - -d
    - $(ZEPPELIN_HOME)/interpreter/spark
    - -r
    - 12321:12321
    - -c
    - zeppelin-server.zeppelin.svc
    - -p
    - "12320"
    - -i
    - spark-shared_process
    - -l
    - /tmp/local-repo/spark
    - -g
    - spark
    env:
    - name: PYSPARK_PYTHON
      value: python
    - name: ZEPPELIN_HOME
      value: /opt/zeppelin
    - name: SPARK_SUBMIT_OPTIONS
      value: --master k8s://https://kubernetes.default.svc --deploy-mode client --driver-memory
        1g --conf spark.kubernetes.namespace=zeppelin --conf spark.executor.instances=1
        --conf spark.kubernetes.driver.pod.name=spark-bizjkm --conf spark.kubernetes.container.image=rogermm/spark-base-python:3.1.2-hadoop3.2-java11-bdb
        --conf spark.driver.bindAddress=0.0.0.0 --conf spark.driver.host=spark-bizjkm.zeppelin.svc
        --conf spark.driver.port=22321 --conf spark.blockManager.port=22322
    - name: SPARK_HOME
      value: /spark
    - name: PYSPARK_DRIVER_PYTHON
      value: python
    - name: SERVICE_DOMAIN
      value: local.zeppelin-project.org:8080
    - name: INTERPRETER_GROUP_ID
      value: spark-shared_process
    image: rogermm/zeppelin-custom-0.10.0:3.1.2-hadoop3.2-java11-bdb
    imagePullPolicy: IfNotPresent
    name: spark
    resources:
      limits:
        cpu: "1"
      requests:
        cpu: "1"
        memory: 1408Mi
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /spark
      name: spark-home
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-8tqd7
      readOnly: true
  dnsPolicy: ClusterFirst
  enableServiceLinks: true
  initContainers:
  - command:
    - sh
    - -c
    - cp -r /opt/spark/* /spark/
    image: rogermm/spark-base-python:3.1.2-hadoop3.2-java11-bdb
    imagePullPolicy: IfNotPresent
    name: spark-home-init
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /spark
      name: spark-home
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-8tqd7
      readOnly: true
  nodeName: minikube
  preemptionPolicy: PreemptLowerPriority
  priority: 0
  restartPolicy: Never
  schedulerName: default-scheduler
  securityContext: {}
  serviceAccount: default
  serviceAccountName: default
  terminationGracePeriodSeconds: 30
  tolerations:
  - effect: NoExecute
    key: node.kubernetes.io/not-ready
    operator: Exists
    tolerationSeconds: 300
  - effect: NoExecute
    key: node.kubernetes.io/unreachable
    operator: Exists
    tolerationSeconds: 300
  volumes:
  - emptyDir: {}
    name: spark-home
  - name: kube-api-access-8tqd7
    projected:
      defaultMode: 420
      sources:
      - serviceAccountToken:
          expirationSeconds: 3607
          path: token
      - configMap:
          items:
          - key: ca.crt
            path: ca.crt
          name: kube-root-ca.crt
      - downwardAPI:
          items:
          - fieldRef:
              apiVersion: v1
              fieldPath: metadata.namespace
            path: namespace
status:
  conditions:
  - lastProbeTime: null
    lastTransitionTime: "2021-09-28T22:30:02Z"
    message: 'containers with incomplete status: [spark-home-init]'
    reason: ContainersNotInitialized
    status: "False"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: "2021-09-28T22:30:02Z"
    message: 'containers with unready status: [spark]'
    reason: ContainersNotReady
    status: "False"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: "2021-09-28T22:30:02Z"
    message: 'containers with unready status: [spark]'
    reason: ContainersNotReady
    status: "False"
    type: ContainersReady
  - lastProbeTime: null
    lastTransitionTime: "2021-09-28T22:30:02Z"
    status: "True"
    type: PodScheduled
  containerStatuses:
  - image: rogermm/zeppelin-custom-0.10.0:3.1.2-hadoop3.2-java11-bdb
    imageID: ""
    lastState: {}
    name: spark
    ready: false
    restartCount: 0
    started: false
    state:
      waiting:
        reason: PodInitializing
  hostIP: 192.168.64.4
  initContainerStatuses:
  - containerID: docker://499d69d10789986239e1c7e1843698614fc92ab379becbe0a38677197b1e404f
    image: rogermm/spark-base-python:3.1.2-hadoop3.2-java11-bdb
    imageID: docker://sha256:eadf9c55522794c745d0d986cafb086f0ef81eff222164f89f2a47517c39f3f0
    lastState: {}
    name: spark-home-init
    ready: false
    restartCount: 0
    state:
      terminated:
        containerID: docker://499d69d10789986239e1c7e1843698614fc92ab379becbe0a38677197b1e404f
        exitCode: 1
        finishedAt: "2021-09-28T22:30:04Z"
        reason: Error
        startedAt: "2021-09-28T22:30:04Z"
  phase: Failed
  podIP: 172.17.0.3
  podIPs:
  - ip: 172.17.0.3
  qosClass: Burstable
  startTime: "2021-09-28T22:30:02Z"
```

## Don't work
   * Screenshots from Kubernetes dashboard
![image info](spark-issue-1.png)
![image info](spark-issue-2.png)