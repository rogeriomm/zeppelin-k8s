ARG REPO
ARG TAG
ARG Z_VERSION
ARG SPARK_VERSION

FROM ${REPO}zeppelin-${Z_VERSION}-${SPARK_VERSION}:$TAG

USER root

# Install minio client
RUN wget -nv -O /tmp/mc https://dl.min.io/client/mc/release/linux-amd64/mc && \
    mkdir -p /opt/minio/bin && \
    mv /tmp/mc /opt/minio/bin && \
    chmod +x /opt/minio/bin/mc
ENV PATH $PATH:/opt/minio/bin

# Install aws client cli
WORKDIR /tmp
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip -q awscliv2.zip
RUN ./aws/install
ENV PATH $PATH:/opt/aws/dist
