-- ============================================================
-- 02_sentiment_trends.sql
-- Sentiment breakdowns by platform, category, and response time
-- ============================================================

-- -------------------------------------------------------
-- 1. Overall sentiment distribution
-- -------------------------------------------------------
SELECT
    sentiment,
    COUNT(*)                                        AS review_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS pct
FROM reviews
GROUP BY sentiment
ORDER BY review_count DESC;


-- -------------------------------------------------------
-- 2. Sentiment breakdown by platform (sorted by negative %)
-- -------------------------------------------------------
SELECT
    platform,
    COUNT(*)                                                   AS total_reviews,
    SUM(CASE WHEN sentiment = 'positive' THEN 1 ELSE 0 END)   AS positive_count,
    SUM(CASE WHEN sentiment = 'neutral'  THEN 1 ELSE 0 END)   AS neutral_count,
    SUM(CASE WHEN sentiment = 'negative' THEN 1 ELSE 0 END)   AS negative_count,
    ROUND(SUM(CASE WHEN sentiment = 'negative' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS neg_pct,
    ROUND(AVG(customer_rating), 2)                             AS avg_rating
FROM reviews
GROUP BY platform
ORDER BY neg_pct DESC;


-- -------------------------------------------------------
-- 3. Sentiment breakdown by product category
-- -------------------------------------------------------
SELECT
    product_category,
    COUNT(*)                                                   AS total_reviews,
    ROUND(SUM(CASE WHEN sentiment = 'negative' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS neg_pct,
    ROUND(AVG(customer_rating), 2)                             AS avg_rating,
    ROUND(AVG(vader_compound), 3)                              AS avg_vader_score
FROM reviews
GROUP BY product_category
ORDER BY neg_pct DESC;


-- -------------------------------------------------------
-- 4. Sentiment by response time bucket
--    Key insight: does slower response = more negative?
-- -------------------------------------------------------
SELECT
    response_time_bucket,
    COUNT(*)                                                   AS total_reviews,
    ROUND(SUM(CASE WHEN sentiment = 'negative' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS neg_pct,
    ROUND(SUM(CASE WHEN sentiment = 'positive' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS pos_pct,
    ROUND(AVG(customer_rating), 2)                             AS avg_rating
FROM reviews
WHERE response_time_bucket IS NOT NULL
GROUP BY response_time_bucket
ORDER BY
    CASE response_time_bucket
        WHEN '<12h'   THEN 1
        WHEN '12-24h' THEN 2
        WHEN '24-48h' THEN 3
        WHEN '>48h'   THEN 4
    END;


-- -------------------------------------------------------
-- 5. Sentiment by age group
-- -------------------------------------------------------
SELECT
    age_group,
    COUNT(*)                                                   AS total_reviews,
    ROUND(AVG(customer_rating), 2)                             AS avg_rating,
    ROUND(SUM(CASE WHEN sentiment = 'negative' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS neg_pct,
    ROUND(SUM(complaint_registered_bin) * 100.0 / COUNT(*), 2) AS complaint_rate_pct
FROM reviews
GROUP BY age_group
ORDER BY age_group;


-- -------------------------------------------------------
-- 6. Sentiment by region
-- -------------------------------------------------------
SELECT
    region,
    COUNT(*)                                                   AS total_reviews,
    ROUND(AVG(customer_rating), 2)                             AS avg_rating,
    ROUND(SUM(CASE WHEN sentiment = 'negative' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS neg_pct,
    ROUND(AVG(response_time_hours), 1)                         AS avg_response_hrs
FROM reviews
GROUP BY region
ORDER BY avg_rating ASC;
