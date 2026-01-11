-- Duplicate customers
SELECT customer_id, COUNT(*) 
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Duplicate subscriptions
SELECT customer_id, start_date, COUNT(*)
FROM subscriptions
GROUP BY customer_id, start_date
HAVING COUNT(*) > 1;

-- Duplicate events
SELECT customer_id, event_type, event_date, COUNT(*)
FROM events
GROUP BY customer_id, event_type, event_date
HAVING COUNT(*) > 1;

---Delete duplicate subscriptions
DELETE s1
FROM subscriptions s1
JOIN subscriptions s2
  ON s1.customer_id = s2.customer_id
 AND s1.start_date = s2.start_date
 AND s1.subscription_id > s2.subscription_id;
 
--Delete duplicate events
DELETE e1
FROM events e1
JOIN events e2
  ON e1.customer_id = e2.customer_id
 AND e1.event_type = e2.event_type
 AND e1.event_date = e2.event_date
 AND e1.event_id > e2.event_id;

--Update null values of segment in subscriptions table
UPDATE subscriptions
SET segment = 'Unknown'
WHERE segment IS NULL OR segment = '';


---count of null signup_date in customers table
SELECT COUNT(*) AS null_signup_dates
FROM customers
WHERE signup_date IS NULL;


--update null signup_date in customers table

UPDATE customers c
JOIN (
    SELECT customer_id, MIN(event_date) AS inferred_signup
    FROM events
    WHERE event_type = 'signup'
      AND event_date IS NOT NULL
    GROUP BY customer_id
) e
ON c.customer_id = e.customer_id
SET c.signup_date = e.inferred_signup
WHERE c.signup_date IS NULL;
