-- ============================================================
-- 01_create_tables.sql
-- Schema definition for Customer Sentiment Analytics project
-- ============================================================

-- Drop tables if they already exist (for fresh runs)
DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS platform_kpis;
DROP TABLE IF EXISTS regional_summary;

-- -------------------------------------------------------
-- Main reviews table
-- -------------------------------------------------------
CREATE TABLE reviews (
    customer_id             INTEGER,
    gender                  TEXT,
    age_group               TEXT,
    region                  TEXT,
    product_category        TEXT,
    purchase_channel        TEXT,
    platform                TEXT,
    customer_rating         INTEGER,          -- 1 to 5
    review_text             TEXT,
    review_text_clean       TEXT,             -- cleaned version
    sentiment               TEXT,             -- positive / neutral / negative
    sentiment_score_label   INTEGER,          -- 1 / 0 / -1
    response_time_hours     INTEGER,
    response_time_bucket    TEXT,             -- <12h / 12-24h / 24-48h / >48h
    issue_resolved          TEXT,             -- yes / no
    issue_resolved_bin      INTEGER,          -- 1 / 0
    complaint_registered    TEXT,             -- yes / no
    complaint_registered_bin INTEGER,         -- 1 / 0
    vader_compound          REAL,
    vader_pos               REAL,
    vader_neg               REAL,
    vader_neu               REAL,
    vader_sentiment         TEXT              -- positive / neutral / negative
);

-- -------------------------------------------------------
-- Platform KPIs aggregation table
-- -------------------------------------------------------
CREATE TABLE platform_kpis (
    platform            TEXT PRIMARY KEY,
    avg_rating          REAL,
    neg_pct             REAL,    -- % negative sentiment
    resolution_rate     REAL,    -- % issues resolved
    avg_response_hrs    REAL,
    review_count        INTEGER
);

-- -------------------------------------------------------
-- Regional summary table
-- -------------------------------------------------------
CREATE TABLE regional_summary (
    region              TEXT,
    product_category    TEXT,
    avg_sentiment_score REAL,
    avg_rating          REAL,
    complaint_rate      REAL,
    review_count        INTEGER,
    PRIMARY KEY (region, product_category)
);

-- Verify tables created
SELECT name FROM sqlite_master WHERE type = 'table';
