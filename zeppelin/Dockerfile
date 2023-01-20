ARG REPO
ARG TAG
ARG SPARK_VERSION

FROM maven:3.5-jdk-11 as builder

ADD ./dependencies /workspace/dependencies
WORKDIR /workspace/dependencies
RUN mvn clean install dependency:copy-dependencies

FROM ${REPO}spark-base-python-$SPARK_VERSION:$TAG

ARG Z_VERSION

ENV LOG_TAG="[ZEPPELIN_${Z_VERSION}]:" \
    Z_HOME="/opt/zeppelin" \
    ZEPPELIN_ADDR="0.0.0.0"

RUN echo "$LOG_TAG install basic packages" && \
    apt-get -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y tini wget && \
    # Cleanup
    rm -rf /var/lib/apt/lists/* && \
    apt-get autoclean && \
    apt-get clean

#RUN wget -nv -O /tmp/zeppelin-${Z_VERSION}-bin-all.tgz https://archive.apache.org/dist/zeppelin/zeppelin-${Z_VERSION}/zeppelin-${Z_VERSION}-bin-all.tgz
COPY zeppelin-${Z_VERSION}-bin-all.tgz /tmp

RUN echo "$LOG_TAG Download Zeppelin binary" && \
    mkdir -p ${Z_HOME} && \
    tar --strip-components=1 -zxf  /tmp/zeppelin-${Z_VERSION}-bin-all.tgz -C ${Z_HOME} && \
    rm -f /tmp/zeppelin-${Z_VERSION}-bin-all.tgz && \
    chown -R root:root ${Z_HOME} && \
    mkdir -p ${Z_HOME}/logs ${Z_HOME}/run ${Z_HOME}/webapps && \
    # Allow process to edit /etc/passwd, to create a user entry for zeppelin
    chgrp root /etc/passwd && chmod ug+rw /etc/passwd && \
    # Give access to some specific folders
    chmod -R 775 "${Z_HOME}/logs" "${Z_HOME}/run" "${Z_HOME}/notebook" "${Z_HOME}/conf" && \
    # Allow process to create new folders (e.g. webapps)
    chmod 775 ${Z_HOME}

COPY log4j.properties log4j_docker.properties log4j2.properties log4j2_docker.properties ${Z_HOME}/conf/

COPY --from=builder /workspace/dependencies/target/dependency/*.jar /opt/zeppelin/lib/

USER 1000

EXPOSE 8080

ENTRYPOINT [ "/usr/bin/tini", "--" ]
WORKDIR ${Z_HOME}
CMD ["bin/zeppelin.sh"]
