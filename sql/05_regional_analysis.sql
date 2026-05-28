-- ============================================================
-- 05_regional_analysis.sql
-- Regional and demographic deep-dive queries
-- ============================================================

-- -------------------------------------------------------
-- 1. Region-level KPI summary
-- -------------------------------------------------------
SELECT
    region,
    COUNT(*)                                                        AS total_reviews,
    ROUND(AVG(customer_rating), 2)                                  AS avg_rating,
    ROUND(SUM(CASE WHEN sentiment = 'negative' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS neg_pct,
    ROUND(SUM(CASE WHEN sentiment = 'positive' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS pos_pct,
    ROUND(AVG(response_time_hours), 1)                              AS avg_response_hrs,
    ROUND(AVG(issue_resolved_bin) * 100, 1)                         AS resolution_rate_pct,
    ROUND(AVG(complaint_registered_bin) * 100, 1)                   AS complaint_rate_pct
FROM reviews
GROUP BY region
ORDER BY avg_rating ASC;


-- -------------------------------------------------------
-- 2. Region × product category heatmap data
--    (avg sentiment score for each cell)
-- -------------------------------------------------------
SELECT
    region,
    product_category,
    COUNT(*)                           AS reviews,
    ROUND(AVG(sentiment_score_label), 3) AS avg_sentiment,   -- -1 to +1
    ROUND(AVG(customer_rating), 2)     AS avg_rating,
    ROUND(AVG(complaint_registered_bin) * 100, 1) AS complaint_rate_pct
FROM reviews
GROUP BY region, product_category
ORDER BY region, avg_sentiment ASC;


-- -------------------------------------------------------
-- 3. Region × platform — where are the worst experiences?
-- -------------------------------------------------------
SELECT
    region,
    platform,
    COUNT(*)                                                        AS reviews,
    ROUND(AVG(customer_rating), 2)                                  AS avg_rating,
    ROUND(SUM(CASE WHEN sentiment = 'negative' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS neg_pct
FROM reviews
GROUP BY region, platform
HAVING COUNT(*) >= 50           -- filter out small sample cells
ORDER BY region, neg_pct DESC;


-- -------------------------------------------------------
-- 4. Demographic analysis — gender × sentiment
-- -------------------------------------------------------
SELECT
    gender,
    sentiment,
    COUNT(*)                                                        AS count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY gender), 1) AS pct_within_gender,
    ROUND(AVG(customer_rating), 2)                                  AS avg_rating
FROM reviews
GROUP BY gender, sentiment
ORDER BY gender, sentiment;


-- -------------------------------------------------------
-- 5. Age group × product category — who buys what and rates it how?
-- -------------------------------------------------------
SELECT
    age_group,
    product_category,
    COUNT(*)                        AS reviews,
    ROUND(AVG(customer_rating), 2)  AS avg_rating,
    ROUND(SUM(CASE WHEN sentiment = 'negative' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS neg_pct
FROM reviews
GROUP BY age_group, product_category
ORDER BY age_group, avg_rating ASC;


-- -------------------------------------------------------
-- 6. Window function: running avg rating per platform over response time
--    (Shows how rating degrades as response time increases)
-- -------------------------------------------------------
SELECT
    platform,
    response_time_hours,
    customer_rating,
    ROUND(AVG(customer_rating) OVER (
        PARTITION BY platform
        ORDER BY response_time_hours
        ROWS BETWEEN 49 PRECEDING AND CURRENT ROW
    ), 2) AS rolling_avg_rating
FROM reviews
ORDER BY platform, response_time_hours;
