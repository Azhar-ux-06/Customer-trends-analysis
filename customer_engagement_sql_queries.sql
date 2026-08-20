-- ============================================================
-- Customer Engagement & Churn Analysis — SQL Business Questions
-- Table: customer_engagement
-- (load customer_engagement_churn_clean.csv into this table first)
-- ============================================================

-- Q1. Which loyalty tier has the highest churn rate?
SELECT
    loyalty_tier,
    COUNT(*) AS total_customers,
    SUM(churned) AS churned_customers,
    ROUND(SUM(churned) * 100.0 / COUNT(*), 2) AS churn_rate_pct
FROM customer_engagement
GROUP BY loyalty_tier
ORDER BY churn_rate_pct DESC;

-- Q2. Which purchase channel (Online App / Website / In-Store) retains customers best?
SELECT
    purchase_channel,
    COUNT(*) AS total_customers,
    ROUND(SUM(churned) * 100.0 / COUNT(*), 2) AS churn_rate_pct,
    ROUND(AVG(purchase_amount_inr), 2) AS avg_purchase_amount
FROM customer_engagement
GROUP BY purchase_channel
ORDER BY churn_rate_pct ASC;

-- Q3. Are customers inactive for 90+ days significantly more likely to churn?
SELECT
    CASE
        WHEN days_since_last_purchase <= 30 THEN '0-30 days'
        WHEN days_since_last_purchase <= 60 THEN '31-60 days'
        WHEN days_since_last_purchase <= 90 THEN '61-90 days'
        ELSE '90+ days'
    END AS recency_bucket,
    COUNT(*) AS total_customers,
    ROUND(SUM(churned) * 100.0 / COUNT(*), 2) AS churn_rate_pct
FROM customer_engagement
GROUP BY recency_bucket
ORDER BY MIN(days_since_last_purchase);

-- Q4. Which product category brings the highest average order value?
SELECT
    category,
    COUNT(*) AS total_orders,
    ROUND(AVG(purchase_amount_inr), 2) AS avg_order_value,
    ROUND(SUM(purchase_amount_inr), 2) AS total_revenue
FROM customer_engagement
GROUP BY category
ORDER BY avg_order_value DESC;

-- Q5. Does discounting actually reduce churn, or just cut margin without retention benefit?
SELECT
    discount_applied,
    COUNT(*) AS total_customers,
    ROUND(AVG(discount_pct), 2) AS avg_discount_pct,
    ROUND(SUM(churned) * 100.0 / COUNT(*), 2) AS churn_rate_pct,
    ROUND(AVG(purchase_amount_inr), 2) AS avg_purchase_amount
FROM customer_engagement
GROUP BY discount_applied;

-- Q6. Do newsletter subscribers churn less than non-subscribers?
SELECT
    subscribed_newsletter,
    COUNT(*) AS total_customers,
    ROUND(SUM(churned) * 100.0 / COUNT(*), 2) AS churn_rate_pct
FROM customer_engagement
GROUP BY subscribed_newsletter;

-- Q7. Which city segments show both high order value AND high churn risk
--     (priority list for the retention team)?
SELECT
    city,
    COUNT(*) AS total_customers,
    ROUND(AVG(purchase_amount_inr), 2) AS avg_purchase_amount,
    ROUND(SUM(churned) * 100.0 / COUNT(*), 2) AS churn_rate_pct
FROM customer_engagement
GROUP BY city
HAVING AVG(purchase_amount_inr) > (SELECT AVG(purchase_amount_inr) FROM customer_engagement)
ORDER BY churn_rate_pct DESC;

-- Q8. Return rate comparison: discounted vs full-price purchases
SELECT
    discount_applied,
    COUNT(*) AS total_orders,
    SUM(returned_item) AS total_returns,
    ROUND(SUM(returned_item) * 100.0 / COUNT(*), 2) AS return_rate_pct
FROM customer_engagement
GROUP BY discount_applied;
