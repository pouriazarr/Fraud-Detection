# Fraud-Detection Dashboard

**Fraud Detection Data Engineering Project**:  
Detecting Fraud in Shopping Centers and Tracking Sellers Using **Apache Spark, Apache Kafka, Redis, PostgreSQL, Prometheus, Grafana**

<div align="center">
  <img src="images/2.png" alt="Dashboarding" style="max-width: 100%; height: auto;" />
</div>

- Debezium images used in Docker Compose for CDC (Change Data Capture)
- PostgreSQL and MySQL as Databases for transactional data (Data Source Layer)
- Kafka as a Message Broker and to store processed data for notification jobs (Data Ingestion Layer)
- Spark as a Processing/Transformation Unit (Data Processing Layer)
- Redis as a super-fast storage for real-time communication with Grafana
- Grafana for Monitoring Tasks and Dashboarding

<div align="left">
  <p><strong>Preview of Grafana Dashboard:</strong></p>
  <img src="images/4.png" alt="Dashboarding2" style="max-width: 100%; height: auto;" />
</div>
