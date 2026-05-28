# GitHub Setup Guide

Step-by-step instructions to push this project to GitHub and make it portfolio-ready.

---

## 1. Create the GitHub repository

1. Go to [github.com/new](https://github.com/new)
2. Repository name: `customer-sentiment-analytics`
3. Description: `End-to-end sentiment analysis pipeline — 25K Indian e-commerce reviews, Python + SQL + VADER + Power BI`
4. Set to **Public** (so recruiters can find it)
5. Do NOT initialise with README (you already have one)
6. Click **Create repository**

---

## 2. Push your local project

Open terminal in the project folder and run:

```bash
git init
git add .
git commit -m "Initial commit: full sentiment analytics pipeline"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/customer-sentiment-analytics.git
git push -u origin main
```

---

## 3. Recommended commit strategy (shows progress to recruiters)

Don't push everything in one commit. Use this sequence:

```bash
# Commit 1 — project scaffold
git add README.md requirements.txt .gitignore
git commit -m "Add project structure, README, and requirements"

# Commit 2 — data cleaning notebook
git add notebooks/01_data_cleaning.ipynb data/processed/
git commit -m "Phase 1: data cleaning and preprocessing pipeline"

# Commit 3 — EDA
git add notebooks/02_eda.ipynb assets/
git commit -m "Phase 2: exploratory data analysis with visualizations"

# Commit 4 — NLP scoring
git add notebooks/03_sentiment_scoring.ipynb
git commit -m "Phase 3: VADER sentiment scoring + SQLite write-back"

# Commit 5 — SQL analysis
git add sql/
git commit -m "Phase 4: SQL analysis scripts (trends, funnel, regional)"

# Commit 6 — final visuals + report
git add notebooks/04_visualizations.ipynb reports/ dashboard/
git commit -m "Phase 5: final visualizations, Power BI dashboard, executive summary"
```

---

## 4. Pin the repo on your GitHub profile

1. Go to your GitHub profile page
2. Click **Customize your pins**
3. Select `customer-sentiment-analytics`
4. It now appears prominently on your profile

---

## 5. Add a preview image to the README

After building your Power BI dashboard:
1. Take a screenshot → save as `assets/dashboard_preview.png`
2. Commit and push the image
3. The README will automatically display it under "Dashboard Preview"

---

## 6. Optional: add GitHub topics for discoverability

On the repo page → click the gear icon next to **About** → add topics:

```
python pandas nlp sentiment-analysis data-analytics power-bi sql vader
e-commerce india data-science
```

This helps recruiters and other analysts find your project via GitHub search.
