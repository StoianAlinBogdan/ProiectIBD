FROM ubuntu:22.04

RUN	apt-get update; apt-get install -y wget ca-certificates curl gnupg software-properties-common

RUN	curl -fsSL https://apt.corretto.aws/corretto.key | apt-key add -
RUN	add-apt-repository 'deb https://apt.corretto.aws stable main' \
	apt-get update; apt-get install -y java-11-amazon-corretto-jdk

ENV	JAVA_HOME=/usr/lib/jvm/java-11-amazon-corretto 
ENV	KAFKA_HOME=/opt/kafka

RUN	wget https://archive.apache.org/dist/kafka/3.5.1/kafka_2.13-3.5.1.tgz
RUN	tar xzf kafka_2.13-3.5.1.tgz
RUN	mv kafka_2.13-3.5.1 /opt/kafka
RUN	rm kafka_2.13-3.5.1.tgz

ENV	PATH=${PATH}:${KAFKA_HOME}/bin

RUN	KAFKA_CLUSTER_ID="$(kafka-storage.sh random-uuid)" \
&& kafka-storage.sh format -t ${KAFKA_CLUSTER_ID} -c ${KAFKA_HOME}/config/kraft/server.properties
CMD	kafka-server-start.sh ${KAFKA_HOME}/config/kraft/server.properties
