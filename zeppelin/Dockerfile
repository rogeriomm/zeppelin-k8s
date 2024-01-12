ARG REPO
ARG TAG
ARG SPARK_VERSION
ARG Z_VERSION

FROM maven:3.5-jdk-11 as builder

ADD ./dependencies /workspace/dependencies
WORKDIR /workspace/dependencies
RUN mvn clean install dependency:copy-dependencies
RUN java --version

FROM apache/zeppelin:${Z_VERSION} as zeppelin

FROM ${REPO}spark-base-python-$SPARK_VERSION:$TAG

ARG Z_VERSION

ENV LOG_TAG="[ZEPPELIN_${Z_VERSION}]:" \
    Z_HOME="/opt/zeppelin" \
    ZEPPELIN_ADDR="0.0.0.0"


COPY --from=zeppelin ${Z_HOME} ${Z_HOME}

RUN chown -R root:root ${Z_HOME} && \
    mkdir -p ${Z_HOME}/logs ${Z_HOME}/run ${Z_HOME}/webapps && \
    # Allow process to edit /etc/passwd, to create a user entry for zeppelin
    chgrp root /etc/passwd && chmod ug+rw /etc/passwd && \
    # Give access to some specific folders
    chmod -R 775 "${Z_HOME}/logs" "${Z_HOME}/run" "${Z_HOME}/notebook" "${Z_HOME}/conf" && \
    # Allow process to create new folders (e.g. webapps)
    chmod 775 ${Z_HOME}

COPY conf/* ${Z_HOME}/conf/

COPY --from=builder /workspace/dependencies/target/dependency/*.jar /opt/zeppelin/lib/

USER 1000

EXPOSE 8080

ENTRYPOINT [ "/usr/bin/tini", "--" ]
WORKDIR ${Z_HOME}
CMD ["bin/zeppelin.sh"]
