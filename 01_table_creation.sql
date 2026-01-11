drop table customers;
drop table subscriptions;
drop table events;

CREATE TABLE customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    signup_date DATE,
    segment VARCHAR(50),
    country VARCHAR(10),
    is_enterprise BOOLEAN
);

CREATE TABLE subscriptions (
    subscription_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10),
    start_date DATE,
    end_date DATE,
    monthly_price INT,
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE events (
    event_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10),
    event_type VARCHAR(15),
    event_date DATE,
    source VARCHAR(15),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);