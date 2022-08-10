Prj([Docker(name="zeppelin",        version="0.10.1-3.1.3", parm={"Z_VERSION": "0.10.1", "SPARK_VERSION": "3.1.3"}),
     Docker(name="zeppelin-custom", version="0.10.1-3.1.3", parm={"Z_VERSION": "0.10.1", "SPARK_VERSION": "3.1.3"}, depends=["zeppelin:0.10.1"]),
     Docker(name="zeppelin",        version="0.10.1-3.2.2", parm={"Z_VERSION": "0.10.1", "SPARK_VERSION": "3.2.2"}),
     Docker(name="zeppelin-custom", version="0.10.1-3.2.2", parm={"Z_VERSION": "0.10.1", "SPARK_VERSION": "3.2.2"}, depends=["zeppelin:0.10.1"])
     ],
     "docker-zeppelin")

