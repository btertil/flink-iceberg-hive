# Only FLINK_VERSION needed before FROM
ARG FLINK_VERSION=1.19.3

FROM apache/flink:${FLINK_VERSION}-java17

# All dependency versions
ARG FLINK_SCALA_VERSION=2.12
ARG ICEBERG_FLINK_RUNTIME_VERSION=1.19
ARG ICEBERG_VERSION=1.6.1
ARG HADOOP_VERSION=3.3.4
ARG HIVE_VERSION=3.1.3
ARG HIVE_CONNECTOR_VERSION=1.19.0
ARG COMMONS_CONFIG_VERSION=2.1.1
ARG COMMONS_LOGGING_VERSION=1.1.3
ARG STAX2_API_VERSION=4.2.1
ARG WOODSTOX_CORE_VERSION=5.3.0
ARG HADOOP_SHADED_GUAVA_VERSION=1.1.1
ARG AWS_SDK_VERSION=1.12.648

WORKDIR /opt/flink

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
    wget -O ./lib/flink-sql-connector-hive-${HIVE_VERSION}_${FLINK_SCALA_VERSION}-${HIVE_CONNECTOR_VERSION}.jar \
        https://repo1.maven.org/maven2/org/apache/flink/flink-sql-connector-hive-${HIVE_VERSION}_${FLINK_SCALA_VERSION}/${HIVE_CONNECTOR_VERSION}/flink-sql-connector-hive-${HIVE_VERSION}_${FLINK_SCALA_VERSION}-${HIVE_CONNECTOR_VERSION}.jar && \
    wget -O ./lib/iceberg-flink-runtime-${ICEBERG_FLINK_RUNTIME_VERSION}-${ICEBERG_VERSION}.jar \
        https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-flink-runtime-${ICEBERG_FLINK_RUNTIME_VERSION}/${ICEBERG_VERSION}/iceberg-flink-runtime-${ICEBERG_FLINK_RUNTIME_VERSION}-${ICEBERG_VERSION}.jar && \
    wget -O ./lib/hadoop-aws-${HADOOP_VERSION}.jar \
        https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/${HADOOP_VERSION}/hadoop-aws-${HADOOP_VERSION}.jar && \
    wget -O ./lib/aws-java-sdk-bundle-${AWS_SDK_VERSION}.jar \
        https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/${AWS_SDK_VERSION}/aws-java-sdk-bundle-${AWS_SDK_VERSION}.jar && \
    wget -O ./lib/commons-configuration2-${COMMONS_CONFIG_VERSION}.jar \
        https://repo1.maven.org/maven2/org/apache/commons/commons-configuration2/${COMMONS_CONFIG_VERSION}/commons-configuration2-${COMMONS_CONFIG_VERSION}.jar && \
    wget -O ./lib/commons-logging-${COMMONS_LOGGING_VERSION}.jar \
        https://repo1.maven.org/maven2/commons-logging/commons-logging/${COMMONS_LOGGING_VERSION}/commons-logging-${COMMONS_LOGGING_VERSION}.jar && \
    wget -O ./lib/hadoop-auth-${HADOOP_VERSION}.jar \
        https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-auth/${HADOOP_VERSION}/hadoop-auth-${HADOOP_VERSION}.jar && \
    wget -O ./lib/hadoop-common-${HADOOP_VERSION}.jar \
        https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-common/${HADOOP_VERSION}/hadoop-common-${HADOOP_VERSION}.jar && \
    wget -O ./lib/hadoop-shaded-guava-${HADOOP_SHADED_GUAVA_VERSION}.jar \
        https://repo1.maven.org/maven2/org/apache/hadoop/thirdparty/hadoop-shaded-guava/${HADOOP_SHADED_GUAVA_VERSION}/hadoop-shaded-guava-${HADOOP_SHADED_GUAVA_VERSION}.jar && \
    wget -O ./lib/stax2-api-${STAX2_API_VERSION}.jar \
        https://repo1.maven.org/maven2/org/codehaus/woodstox/stax2-api/${STAX2_API_VERSION}/stax2-api-${STAX2_API_VERSION}.jar && \
    wget -O ./lib/woodstox-core-${WOODSTOX_CORE_VERSION}.jar \
        https://repo1.maven.org/maven2/com/fasterxml/woodstox/woodstox-core/${WOODSTOX_CORE_VERSION}/woodstox-core-${WOODSTOX_CORE_VERSION}.jar && \
    wget -O ./lib/hadoop-hdfs-client-${HADOOP_VERSION}.jar \
        https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-hdfs-client/${HADOOP_VERSION}/hadoop-hdfs-client-${HADOOP_VERSION}.jar && \
    wget -O ./lib/hadoop-mapreduce-client-core-${HADOOP_VERSION}.jar \
        https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-mapreduce-client-core/${HADOOP_VERSION}/hadoop-mapreduce-client-core-${HADOOP_VERSION}.jar

# Verify downloads
RUN echo "=== Installed JARs ===" && \
    ls -lh ./lib/*.jar && \
    echo "=== Total: $(ls -1 ./lib/*.jar | wc -l) JARs ==="
