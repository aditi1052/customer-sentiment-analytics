-- ============================================================
-- 03_platform_comparison.sql
-- Full KPI scorecard for every platform — the Power BI source
-- ============================================================

-- -------------------------------------------------------
-- 1. Platform KPI scorecard (all metrics in one view)
-- -------------------------------------------------------
SELECT
    platform,
    COUNT(*)                                                        AS total_reviews,
    ROUND(AVG(customer_rating), 2)                                  AS avg_rating,

    -- Sentiment split
    ROUND(SUM(CASE WHEN sentiment = 'positive' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS pos_pct,
    ROUND(SUM(CASE WHEN sentiment = 'neutral'  THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS neu_pct,
    ROUND(SUM(CASE WHEN sentiment = 'negative' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS neg_pct,

    -- Support performance
    ROUND(AVG(response_time_hours), 1)                              AS avg_response_hrs,
    ROUND(AVG(issue_resolved_bin) * 100, 1)                         AS resolution_rate_pct,
    ROUND(AVG(complaint_registered_bin) * 100, 1)                   AS complaint_rate_pct,

    -- VADER NLP score
    ROUND(AVG(vader_compound), 3)                                   AS avg_vader_score

FROM reviews
GROUP BY platform
ORDER BY avg_rating DESC;


-- -------------------------------------------------------
-- 2. Platform × product category cross-tab
--    (Which platform is worst for which category?)
-- -------------------------------------------------------
SELECT
    platform,
    product_category,
    COUNT(*)                                                        AS reviews,
    ROUND(AVG(customer_rating), 2)                                  AS avg_rating,
    ROUND(SUM(CASE WHEN sentiment = 'negative' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS neg_pct
FROM reviews
GROUP BY platform, product_category
ORDER BY platform, neg_pct DESC;


-- -------------------------------------------------------
-- 3. Platform × region performance
--    (Is a platform underperforming in a specific region?)
-- -------------------------------------------------------
SELECT
    platform,
    region,
    COUNT(*)                        AS reviews,
    ROUND(AVG(customer_rating), 2)  AS avg_rating,
    ROUND(SUM(CASE WHEN sentiment = 'negative' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS neg_pct
FROM reviews
GROUP BY platform, region
ORDER BY platform, neg_pct DESC;


-- -------------------------------------------------------
-- 4. Top 5 vs Bottom 5 platforms by avg rating
-- -------------------------------------------------------

-- Top 5
SELECT 'top_5' AS tier, platform, ROUND(AVG(customer_rating), 2) AS avg_rating
FROM reviews
GROUP BY platform
ORDER BY avg_rating DESC
LIMIT 5;

-- Bottom 5
SELECT 'bottom_5' AS tier, platform, ROUND(AVG(customer_rating), 2) AS avg_rating
FROM reviews
GROUP BY platform
ORDER BY avg_rating ASC
LIMIT 5;


-- -------------------------------------------------------
-- 5. Response time SLA compliance per platform
--    (% of tickets responded within 24 hours)
-- -------------------------------------------------------
SELECT
    platform,
    COUNT(*)                                                            AS total,
    ROUND(SUM(CASE WHEN response_time_hours <= 24 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS within_24h_pct,
    ROUND(SUM(CASE WHEN response_time_hours > 48 THEN 1 ELSE 0 END)  * 100.0 / COUNT(*), 1) AS over_48h_pct,
    ROUND(AVG(response_time_hours), 1)                                  AS avg_response_hrs
FROM reviews
GROUP BY platform
ORDER BY within_24h_pct DESC;
