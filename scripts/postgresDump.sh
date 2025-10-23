#!/bin/bash

# Create the database and Dump Processed Data (Spark) to Postgres
docker exec -it postgres psql -U postgres -c "CREATE DATABASE postgresql_dump;"

docker cp ../src/postgresSink/postgresSink.py spark:/opt/spark

docker exec -u 0 -it spark bash -c "/opt/spark/bin/spark-submit \
  --packages org.apache.spark:spark-sql-kafka-0-10_2.12:3.5.4,org.postgresql:postgresql:42.6.0 \
  /opt/spark/postgresSink.py"


