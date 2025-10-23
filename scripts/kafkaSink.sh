#!/bin/bash

# Create Kafka topics For Sink processed Data in Kafka Topics for Notif Usage Later
docker exec -u 0 kafka ./bin/kafka-topics.sh --create --topic notification-postgres --bootstrap-server kafka:9092 --partitions 1 --replication-factor 1
docker exec -u 0 kafka ./bin/kafka-topics.sh --create --topic notification-mysql --bootstrap-server kafka:9092 --partitions 1 --replication-factor 1

# Copy the Spark job to the Spark container
docker cp ../src/kafkaSink/kafkaSink-v2.py spark:/opt/spark

# Execute the Spark job using packages
docker exec -u 0 -it spark bash -c "/opt/spark/bin/spark-submit --packages org.apache.spark:spark-sql-kafka-0-10_2.12:3.5.4 /opt/spark/kafkaSink-v2.py"