SELECT
    source,
    COUNT(DISTINCT CASE WHEN event_type = 'signup' THEN customer_id END) AS signup,
    COUNT(DISTINCT CASE WHEN event_type = 'trial' THEN customer_id END) AS trial,
    COUNT(DISTINCT CASE WHEN event_type = 'activated' THEN customer_id END) AS activated,
    COUNT(DISTINCT CASE WHEN event_type = 'paid' THEN customer_id END) AS paid,
    COUNT(DISTINCT CASE WHEN event_type = 'churned' THEN customer_id END) AS churned
FROM events
GROUP BY source;
