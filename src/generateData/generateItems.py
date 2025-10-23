from datetime import datetime
import random
import time
import psycopg2
import pymysql

# postgres (host) --> postgres (database) --> public (schema) --> customer (table)
postgres_conn_params = {
    'database': 'postgres',
    'user': 'postgres',
    'password': '123456',
    'host': 'localhost',
    'port': 6543
}

#mysql (host) --> mariadb (database) --> customer (table) 
mariadb_conn_params = {
    'database': 'mariadb',
    'user': 'root',
    'password': 'debezium',
    'host': 'localhost',
    'port': 3306
}


def generate_random_data_postgres():
    return {
        'name': f'User{random.randint(1, 10000)}',
        'age': random.randint(18, 75),
        'email': f'user{random.randint(1, 10000)}@example.com',
        'purchase': random.randint(1_000, 100_000_000),
        'timestamp': datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
        'store': random.choice(['S1', 'S3', 'S5', 'S7']),
        'clerk': random.choice(['Sara Bayat', 'Amin Mohammadi', 'Reza Heshmati', 'Reza Aslani', 'Mahshid Khorshidmanesh'])
    }

def generate_random_data_mysql():
    return {
        'name': f'Customer{random.randint(1, 10000)}',
        'age': random.randint(18, 75),
        'email': f'user{random.randint(1, 10000)}@example.com',
        'purchase': random.randint(1_000, 100_000_000),
        'timestamp': datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
        'store': random.choice(['S2', 'S4', 'S6']),
        'clerk': random.choice(['Baran Safavi', 'Mohammad Atabaki', 'Maniya Kochaki', 'Hojat Garmroudi'])
    }

def insert_postgres(data):
    with psycopg2.connect(**postgres_conn_params) as conn:
        with conn.cursor() as cur:
            cur.execute("""
                INSERT INTO customer (name, age, email, purchase, timestamp, store, clerk)
                VALUES (%s, %s, %s, %s, %s, %s, %s)
            """, (data['name'], data['age'], data['email'], data['purchase'], data['timestamp'], data['store'], data['clerk']))
            conn.commit()


def insert_mariadb(data):
    with pymysql.connect(**mariadb_conn_params) as conn:
        with conn.cursor() as cur:
            cur.execute("""
                INSERT INTO customer (name, age, email, purchase, timestamp, store, clerk)
                VALUES (%s, %s, %s, %s, %s, %s, %s)
            """, (data['name'], data['age'], data['email'], data['purchase'], data['timestamp'], data['store'], data['clerk']))
            conn.commit()


if __name__ == "__main__":
    while True:
        random_data_postgres = generate_random_data_postgres()
        random_data_mysql = generate_random_data_mysql()
        insert_postgres(random_data_postgres)
        insert_mariadb(random_data_mysql)
        print("Inserted:", random_data_postgres)
        print("Inserted:", random_data_mysql)
        sleep_time = random.randint(1, 25)
        print(f"Next item will be generated in {sleep_time} seconds...")
        time.sleep(sleep_time)
