#!/bin/bash

# Start Docker Compose
docker compose -p fraud-detection -f ../docker-compose.yaml up -d

# Wait for cluster to start
sleep 60
echo "Wait a little for our services to be run ..." 

# Run MariaDB initialization
# Variables
MYSQL_CONTAINER_NAME="mysql"
MYSQL_ROOT_PASSWORD="debezium" 
DATABASE_NAME="mariadb"                
TABLE_NAME="customer"                       

# Create database and table
docker exec -i $MYSQL_CONTAINER_NAME mysql -u root -p$MYSQL_ROOT_PASSWORD <<EOF
CREATE DATABASE IF NOT EXISTS $DATABASE_NAME;

USE $DATABASE_NAME;

CREATE TABLE customer (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    age INT,
    email VARCHAR(255),
    purchase INT,
    timestamp DATETIME,
    store VARCHAR(2),
    clerk VARCHAR(35)		
);
EOF

echo "Database and table created successfully."


# Run PostgreSQL initialization

# Variables
POSTGRES_CONTAINER_NAME="postgres"
POSTGRES_USER="postgres"           
POSTGRES_DB="postgres"                 
TABLE_NAME="customer"                  

# Create database and table
docker exec -i $POSTGRES_CONTAINER_NAME psql -U $POSTGRES_USER -d $POSTGRES_DB <<EOF
CREATE TABLE IF NOT EXISTS $TABLE_NAME (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    age INT,
    email VARCHAR(255),
    purchase INT,
    timestamp TIMESTAMP,
    store VARCHAR(2),
    clerk VARCHAR(35)	
);
EOF

echo "PostgreSQL Database and table created successfully."

# Run the Python script to generate and insert data
python3 ../src/generateData/generateItems.py

#wait for all containers run
sleep 30
