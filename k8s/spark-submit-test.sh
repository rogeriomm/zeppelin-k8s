#--conf spark.kubernetes.context=${CONTEXT} \

/opt/spark/bin/spark-submit --verbose --master k8s://https://kubernetes.default.svc --deploy-mode client \
                   --name spark-pi \
                   --class org.apache.spark.examples.SparkPi \
                   --conf spark.kubernetes.authenticate.driver.serviceAccountName=spark \
                   --conf spark.executor.instances=2 \
                   --conf spark.kubernetes.container.image=spark:1.0 \
                   --conf spark.kubernetes.namespace=zeppelin \
                   local:///opt/spark/examples/jars/spark-examples_2.12-3.1.2.jar


/opt/spark/bin/spark-submit --verbose --master k8s://https://kubernetes.default.svc --deploy-mode cluster \
                   --name spark-pi \
                   --class org.apache.spark.examples.SparkPi \
                   --conf spark.kubernetes.authenticate.driver.serviceAccountName=spark \
                   --conf spark.executor.instances=10 \
                   --conf spark.kubernetes.container.image=rogermm/spark-base-python:3.1.2-hadoop3.2-java11-bdb \
                   --conf spark.kubernetes.namespace=zeppelin \
                   local:///opt/spark/examples/jars/spark-examples_2.12-3.1.2.jar
