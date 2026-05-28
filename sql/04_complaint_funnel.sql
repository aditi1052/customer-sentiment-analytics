-- ============================================================
-- 04_complaint_funnel.sql
-- Complaint registration and resolution funnel analysis
-- ============================================================

-- -------------------------------------------------------
-- 1. Top-level complaint funnel
--    All reviews → Negative → Complained → Resolved
-- -------------------------------------------------------
SELECT
    'All reviews'                                                   AS stage,
    COUNT(*)                                                        AS count,
    100.0                                                           AS pct_of_total
FROM reviews

UNION ALL

SELECT
    'Negative reviews'                                              AS stage,
    SUM(CASE WHEN sentiment = 'negative' THEN 1 ELSE 0 END),
    ROUND(SUM(CASE WHEN sentiment = 'negative' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1)
FROM reviews

UNION ALL

SELECT
    'Complaints raised'                                             AS stage,
    SUM(CASE WHEN sentiment = 'negative' AND complaint_registered = 'yes' THEN 1 ELSE 0 END),
    ROUND(SUM(CASE WHEN sentiment = 'negative' AND complaint_registered = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1)
FROM reviews

UNION ALL

SELECT
    'Issues resolved'                                               AS stage,
    SUM(CASE WHEN sentiment = 'negative' AND complaint_registered = 'yes' AND issue_resolved = 'yes' THEN 1 ELSE 0 END),
    ROUND(SUM(CASE WHEN sentiment = 'negative' AND complaint_registered = 'yes' AND issue_resolved = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1)
FROM reviews;


-- -------------------------------------------------------
-- 2. Resolution impact on rating
--    Does resolving a complaint actually improve rating?
-- -------------------------------------------------------
SELECT
    issue_resolved,
    complaint_registered,
    COUNT(*)                        AS reviews,
    ROUND(AVG(customer_rating), 2)  AS avg_rating,
    ROUND(AVG(vader_compound), 3)   AS avg_vader_score
FROM reviews
GROUP BY issue_resolved, complaint_registered
ORDER BY avg_rating DESC;


-- -------------------------------------------------------
-- 3. Complaint rate by platform (who generates most complaints?)
-- -------------------------------------------------------
SELECT
    platform,
    COUNT(*)                                                                    AS total_reviews,
    SUM(complaint_registered_bin)                                               AS complaints,
    ROUND(SUM(complaint_registered_bin) * 100.0 / COUNT(*), 1)                 AS complaint_rate_pct,
    SUM(CASE WHEN complaint_registered_bin = 1 AND issue_resolved_bin = 1 THEN 1 ELSE 0 END) AS resolved,
    ROUND(SUM(CASE WHEN complaint_registered_bin = 1 AND issue_resolved_bin = 1 THEN 1 ELSE 0 END) * 100.0
        / NULLIF(SUM(complaint_registered_bin), 0), 1)                          AS resolution_rate_pct
FROM reviews
GROUP BY platform
ORDER BY complaint_rate_pct DESC;


-- -------------------------------------------------------
-- 4. Complaint rate by product category
-- -------------------------------------------------------
SELECT
    product_category,
    COUNT(*)                                                                    AS total_reviews,
    ROUND(SUM(complaint_registered_bin) * 100.0 / COUNT(*), 1)                 AS complaint_rate_pct,
    ROUND(SUM(issue_resolved_bin) * 100.0 / NULLIF(SUM(complaint_registered_bin), 0), 1) AS resolution_rate_pct,
    ROUND(AVG(customer_rating), 2)                                              AS avg_rating
FROM reviews
GROUP BY product_category
ORDER BY complaint_rate_pct DESC;


-- -------------------------------------------------------
-- 5. Unresolved complaints with high response time
--    (The worst-case customers — most at risk of churning)
-- -------------------------------------------------------
SELECT
    platform,
    product_category,
    region,
    COUNT(*)                        AS at_risk_customers,
    ROUND(AVG(response_time_hours), 1) AS avg_response_hrs,
    ROUND(AVG(customer_rating), 2)  AS avg_rating
FROM reviews
WHERE
    complaint_registered = 'yes'
    AND issue_resolved   = 'no'
    AND response_time_hours > 48
GROUP BY platform, product_category, region
ORDER BY at_risk_customers DESC
LIMIT 20;
