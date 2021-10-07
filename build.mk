Prj([Docker(name="zeppelin", version="0.9.0", parm={"Z_VERSION": "0.9.0"}),
     Docker(name="zeppelin-custom", version="0.9.0", parm={"Z_VERSION": "0.9.0"}, depends=["zeppelin:0.9.0"]),
     Docker(name="zeppelin", version="0.10.0", parm={"Z_VERSION": "0.10.0"}),
     Docker(name="zeppelin-custom", version="0.10.0", parm={"Z_VERSION": "0.10.0"}, depends=["zeppelin:0.10.0"])],
     "docker-zeppelin")

