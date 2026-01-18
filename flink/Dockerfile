FROM apache/flink:1.19.3-java17

WORKDIR /opt/flink

# Copy configurations
COPY conf/flink-conf.yaml ./conf/flink-conf.yaml
COPY conf/hive-site.xml ./conf/hive-site.xml
COPY flink-sql-history /root/.flink-sql-history

# Install tools
RUN apt-get update && \
    apt-get install -y vim lnav curl wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# S3 Plugin
RUN mkdir -p ./plugins/s3-fs-hadoop && \
    (cp ./opt/flink-s3-fs-hadoop-*.jar ./plugins/s3-fs-hadoop/ 2>/dev/null || true)

# Download connectors with CORRECT Iceberg version
RUN echo "Downloading Flink connectors..." && \
    wget -O ./lib/flink-sql-connector-hive-3.1.3_2.12-1.19.0.jar \
        https://repo1.maven.org/maven2/org/apache/flink/flink-sql-connector-hive-3.1.3_2.12/1.19.0/flink-sql-connector-hive-3.1.3_2.12-1.19.0.jar && \
    wget -O ./lib/iceberg-flink-runtime-1.19-1.6.1.jar \
        https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-flink-runtime-1.19/1.6.1/iceberg-flink-runtime-1.19-1.6.1.jar && \
    wget -O ./lib/hadoop-aws-3.3.4.jar \
        https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.4/hadoop-aws-3.3.4.jar && \
    wget -O ./lib/aws-java-sdk-bundle-1.12.648.jar \
        https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.12.648/aws-java-sdk-bundle-1.12.648.jar && \
    wget -O ./lib/commons-configuration2-2.1.1.jar \
        https://repo1.maven.org/maven2/org/apache/commons/commons-configuration2/2.1.1/commons-configuration2-2.1.1.jar && \
    wget -O ./lib/commons-logging-1.1.3.jar \
        https://repo1.maven.org/maven2/commons-logging/commons-logging/1.1.3/commons-logging-1.1.3.jar && \
    wget -O ./lib/hadoop-auth-3.3.4.jar \
        https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-auth/3.3.4/hadoop-auth-3.3.4.jar && \
    wget -O ./lib/hadoop-common-3.3.4.jar \
        https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-common/3.3.4/hadoop-common-3.3.4.jar && \
    wget -O ./lib/hadoop-shaded-guava-1.1.1.jar \
        https://repo1.maven.org/maven2/org/apache/hadoop/thirdparty/hadoop-shaded-guava/1.1.1/hadoop-shaded-guava-1.1.1.jar && \
    wget -O ./lib/stax2-api-4.2.1.jar \
        https://repo1.maven.org/maven2/org/codehaus/woodstox/stax2-api/4.2.1/stax2-api-4.2.1.jar && \
    wget -O ./lib/woodstox-core-5.3.0.jar \
        https://repo1.maven.org/maven2/com/fasterxml/woodstox/woodstox-core/5.3.0/woodstox-core-5.3.0.jar && \
    wget -O ./lib/hadoop-hdfs-client-3.3.4.jar \
        https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-hdfs-client/3.3.4/hadoop-hdfs-client-3.3.4.jar && \
    wget -O ./lib/hadoop-mapreduce-client-core-3.3.4.jar \
        https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-mapreduce-client-core/3.3.4/hadoop-mapreduce-client-core-3.3.4.jar

# Verify downloads
RUN echo "=== Installed JARs ===" && \
    ls -lh ./lib/*.jar && \
    echo "=== Total: $(ls -1 ./lib/*.jar | wc -l) JARs ==="
