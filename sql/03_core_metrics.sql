--Monthly MRR

WITH active_subs AS (
    SELECT
        customer_id,
        monthly_price,
        DATE_FORMAT(start_date, '%Y-%m-01') AS month
    FROM subscriptions
    WHERE status = 'active'
)
SELECT
    month,
    SUM(monthly_price) AS mrr
FROM active_subs
GROUP BY month
ORDER BY month;

--ARR

SELECT
    month,
    mrr * 12 AS arr
FROM (
    SELECT
        DATE_FORMAT(start_date, '%Y-%m-01') AS month,
        SUM(monthly_price) AS mrr
    FROM subscriptions
    WHERE status = 'active'
    GROUP BY month
) t;

--ARPC

SELECT
    month,
    SUM(monthly_price) / COUNT(DISTINCT customer_id) AS arpc
FROM (
    SELECT
        customer_id,
        monthly_price,
        DATE_FORMAT(start_date, '%Y-%m-01') AS month
    FROM subscriptions
    WHERE status = 'active'
) t
GROUP BY month;
