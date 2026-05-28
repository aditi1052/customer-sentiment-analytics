# Executive Summary — Customer Sentiment Analytics

**Project:** Customer Sentiment Analytics Pipeline  
**Dataset:** 25,000 reviews across 20 Indian e-commerce platforms  
**Analyst:** [Your Name]  
**Date:** [Date]

---

## 🎯 Business Questions Answered

1. Which platforms have the highest negative sentiment — and why?
2. Does response time impact customer satisfaction?
3. Which product categories and regions drive the most complaints?

---

## 📊 Key Findings

### Finding 1 — Response time is the #1 driver of negative sentiment

Customers who waited more than 48 hours for a support response showed a significantly higher rate of negative sentiment compared to those responded to within 12 hours. This is the single strongest lever available to improve customer satisfaction across all platforms.

**Recommendation:** Enforce a 24-hour first-response SLA across all platforms. Prioritise high-complaint categories (electronics, travel) for faster routing.

---

### Finding 2 — Electronics and travel categories generate the most complaints

Despite not having the highest review volume, electronics and travel consistently ranked at the top for complaint registration rate and negative sentiment. This suggests product quality or delivery expectation issues rather than platform-level failures.

**Recommendation:** Conduct a supplier audit for the top 3 electronics sub-categories. Review return and refund policy clarity for travel bookings.

---

### Finding 3 — Issue resolution has a measurable rating uplift

Customers whose complaints were resolved gave meaningfully higher ratings than those with unresolved complaints, even when controlling for response time. This confirms that resolution quality — not just speed — matters.

**Recommendation:** Track resolution rate as a primary KPI alongside response time. Set a target resolution rate of 85%+ for all platforms.

---

### Finding 4 — Regional performance gaps exist

Certain regions consistently underperformed on average rating and had higher complaint rates. This pattern is consistent across multiple platforms, suggesting a logistics or delivery-partner issue rather than a platform-specific problem.

**Recommendation:** Conduct a regional logistics audit focusing on last-mile delivery partners in underperforming regions.

---

### Finding 5 — VADER NLP aligns well with pre-labelled sentiment

VADER sentiment scoring achieved strong agreement with the pre-labelled sentiment column, validating the dataset quality and confirming that VADER is reliable for this type of Indian e-commerce review text. Mismatches were concentrated in neutral reviews that contained mixed positive and negative language.

---

## 📈 Dashboard Summary

The Power BI dashboard (`dashboard/sentiment_dashboard.pbix`) contains 4 pages:

| Page | Contents |
|---|---|
| Overview | Overall KPIs, sentiment donut, top/bottom platforms |
| Platform deep-dive | Side-by-side platform comparison with slicers |
| Regional analysis | Region × category heatmap, regional KPI table |
| Support performance | Response time buckets, complaint funnel, resolution impact |

---

## 🛠️ Tech Stack

| Layer | Tool |
|---|---|
| Data cleaning | Python (Pandas, NLTK) |
| NLP scoring | VADER (vaderSentiment) |
| SQL analysis | SQLite |
| Visualizations | Matplotlib, Seaborn, WordCloud |
| Dashboard | Power BI Desktop |

---

## 📁 Repository Structure

See `README.md` for full folder layout and setup instructions.

---

## ⚠️ Limitations & Next Steps

- **Dataset scope:** The dataset is synthetic/structured — findings should be validated against live platform data before acting on recommendations.
- **Time dimension missing:** The dataset lacks timestamps, so trend-over-time analysis was not possible. Adding a `review_date` column would significantly enhance the dashboard.
- **NLP depth:** VADER is lexicon-based and doesn't capture sarcasm or domain-specific language. A fine-tuned transformer model (e.g. IndicBERT for Indian-language reviews) would improve accuracy.
- **Next step:** Add a predictive churn model (Project 2) using the features identified here as drivers of negative sentiment.

---

*This project is part of a 3-project data analytics portfolio. See GitHub profile for the full portfolio.*
