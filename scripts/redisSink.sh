#!/bin/bash

#Copy Spark Job to Spark Container and Install redis & run redisSink.py for Sink data to redis for dashboarding and alerting using Grafana
docker cp ../src/redisSink/redisSink-v2.py spark:/opt/spark

docker exec -u 0 -it spark bash -c "pip install redis"

docker exec -u 0 -it spark bash -c "/opt/spark/bin/spark-submit \
  --packages org.apache.spark:spark-sql-kafka-0-10_2.12:3.5.4,com.redislabs:spark-redis_2.12:3.1.0 \
  /opt/spark/redisSink-v2.py"
