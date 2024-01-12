ARG REPO
ARG TAG
ARG Z_VERSION
ARG SPARK_VERSION

FROM ${REPO}zeppelin-${Z_VERSION}-${SPARK_VERSION}:$TAG

USER root

# Install MINIO client
RUN wget -nv -O /tmp/mc https://dl.min.io/client/mc/release/linux-amd64/mc && \
    mkdir -p /opt/minio/bin && \
    mv /tmp/mc /opt/minio/bin && \
    chmod +x /opt/minio/bin/mc
ENV PATH $PATH:/opt/minio/bin

# Install AWS client cli
RUN cd /tmp && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip -q awscliv2.zip && \
    aws/install && \
    rm -rf aws && \
    rm awscliv2.zip

ENV PATH $PATH:/opt/aws/dist
