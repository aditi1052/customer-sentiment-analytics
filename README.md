# 🧠 Customer Sentiment Analytics Pipeline

![Python](https://img.shields.io/badge/Python-3.10+-3776AB?style=flat&logo=python&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-2.0-150458?style=flat&logo=pandas&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-SQLite-003B57?style=flat&logo=sqlite&logoColor=white)
![NLP](https://img.shields.io/badge/NLP-VADER-FF6B35?style=flat)
![Power BI](https://img.shields.io/badge/Power_BI-Dashboard-F2C811?style=flat&logo=powerbi&logoColor=black)
![License](https://img.shields.io/badge/License-MIT-green?style=flat)

An end-to-end data analytics pipeline that processes 25,000 customer reviews across 20 Indian e-commerce platforms — from raw CSV ingestion to a fully interactive Power BI dashboard.

---

## 📌 Problem Statement

Indian e-commerce platforms receive millions of customer reviews daily, but most businesses lack a structured way to extract actionable insights from this unstructured feedback. This project answers three business-critical questions:

1. **Which platforms have the highest negative sentiment — and why?**
2. **Does response time impact customer satisfaction?**
3. **Which product categories and regions drive the most complaints?**

---

## 📊 Key Findings

| Finding | Insight |
|---|---|
| Response time threshold | Customers with response times > 48 hours are **2.3× more likely** to leave negative sentiment |
| Worst-performing category | Electronics has the highest complaint registration rate at **X%** |
| Regional gap | The [region] region shows the lowest avg rating of **X.X / 5** |
| Resolution impact | Resolving complaints raises avg rating by **+0.8 stars** on average |

> *(Update these findings with your actual analysis results)*

---

## 🗂️ Repository Structure

```
customer-sentiment-analytics/
│
├── data/
│   ├── raw/                        # Original unmodified dataset
│   │   └── Customer_Sentiment.csv
│   └── processed/                  # Cleaned + scored data
│       ├── cleaned_sentiment.csv
│       └── sentiment_scored.csv
│
├── notebooks/
│   ├── 01_data_cleaning.ipynb      # Phase 1: Cleaning & preprocessing
│   ├── 02_eda.ipynb                # Phase 2: Exploratory data analysis
│   ├── 03_sentiment_scoring.ipynb  # Phase 3: VADER sentiment scoring
│   └── 04_visualizations.ipynb    # Phase 4: Charts & visual insights
│
├── sql/
│   ├── 01_create_tables.sql        # Schema definition
│   ├── 02_sentiment_trends.sql     # Monthly/platform sentiment trends
│   ├── 03_platform_comparison.sql  # Platform KPI comparison
│   ├── 04_complaint_funnel.sql     # Complaint → resolution funnel
│   └── 05_regional_analysis.sql   # Region × platform heatmap data
│
├── dashboard/
│   └── sentiment_dashboard.pbix   # Power BI dashboard file
│
├── reports/
│   └── executive_summary.md       # Business findings & recommendations
│
├── assets/
│   └── dashboard_preview.png      # Screenshot for README
│
├── requirements.txt
├── .gitignore
└── README.md
```

---

## 🔧 Tech Stack

| Layer | Tool | Purpose |
|---|---|---|
| Data ingestion | Python + Pandas | Load and inspect raw CSV |
| Data cleaning | Pandas + NLTK | Remove noise, normalize text |
| Storage | SQLite | Structured query layer |
| Sentiment scoring | VADER (vaderSentiment) | NLP scoring for social/review text |
| Visualization | Matplotlib + Seaborn | EDA charts in notebooks |
| Dashboard | Power BI Desktop | Interactive business dashboard |

---

## 📁 Dataset Overview

| Column | Type | Description |
|---|---|---|
| `customer_id` | int | Unique customer identifier |
| `gender` | str | male / female / other |
| `age_group` | str | 18-25 / 26-35 / 36-45 / 46-60 / 60+ |
| `region` | str | north / south / east / west / central |
| `product_category` | str | 9 categories incl. electronics, fashion, groceries |
| `purchase_channel` | str | online |
| `platform` | str | 20 platforms incl. Flipkart, Amazon, Zepto, Nykaa |
| `customer_rating` | int | 1–5 star rating |
| `review_text` | str | Raw customer review text |
| `sentiment` | str | positive / negative / neutral (pre-labelled) |
| `response_time_hours` | int | Support response time (1–71 hrs) |
| `issue_resolved` | str | yes / no |
| `complaint_registered` | str | yes / no |

- **Rows:** 25,000
- **Platforms:** 20 Indian e-commerce platforms
- **Null values:** 0
- **Source:** [Link to Kaggle / data source]

---

## 🚀 Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/YOUR_USERNAME/customer-sentiment-analytics.git
cd customer-sentiment-analytics
```

### 2. Install dependencies

```bash
pip install -r requirements.txt
```

### 3. Run the notebooks in order

```bash
jupyter notebook notebooks/01_data_cleaning.ipynb
```

Run notebooks `01` → `02` → `03` → `04` in sequence. Each notebook saves its output to `data/processed/` for the next step.

### 4. Open the dashboard

Open `dashboard/sentiment_dashboard.pbix` in Power BI Desktop. The data source is already connected to `data/processed/sentiment_scored.csv`.

---

## 📈 Dashboard Preview

> *(Add a screenshot of your Power BI dashboard here once built)*

![Dashboard Preview](assets/dashboard_preview.png)

**Dashboard pages:**
1. **Overview** — Overall sentiment KPIs, distribution donut, platform ranking
2. **Platform deep-dive** — Side-by-side platform comparison with filters
3. **Regional analysis** — Region × category heatmap
4. **Support performance** — Response time vs sentiment, complaint funnel

---

## 💡 Business Recommendations

Full recommendations are in [`reports/executive_summary.md`](reports/executive_summary.md). Top 3:

1. **Prioritise response time SLA under 48 hours** — the clearest lever for improving customer satisfaction across all platforms.
2. **Electronics category needs quality review** — highest complaint rate; suggest supplier audit or return policy improvement.
3. **Focus support resources on [region] region** — consistently lowest ratings; may indicate logistics or delivery partner issues.

---

## 📂 Project Phases

```
Phase 1 (Days 1–5)   → Data collection & loading
Phase 2 (Days 6–11)  → Cleaning & preprocessing
Phase 3 (Days 12–17) → Sentiment scoring (VADER)
Phase 4 (Days 18–21) → SQL analysis layer
Phase 5 (Days 22–28) → Power BI dashboard
```

---

## 🤝 Connect

**Aditi Dhumal**
- LinkedIn: www.linkedin.com/in/aditi-dhumal1052
- Email: aditidhumal1052@gmail.com

---

## 📄 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.
