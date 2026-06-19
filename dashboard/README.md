# Dashboard

## Status: 🚧 In Progress

The data pipeline (cleaning → EDA → VADER sentiment scoring → SQL analysis) is complete. The dashboard build is the current step — being built in **Power BI Service (web)** since this is being developed on a Mac without local Power BI Desktop access.

---

## Planned structure

| Page | Description |
|---|---|
| 1 — Overview | Overall sentiment KPIs, distribution donut chart, top/bottom platform ranking |
| 2 — Platform deep-dive | Side-by-side platform comparison — avg rating, neg%, resolution rate, response time. Includes a platform slicer. |
| 3 — Regional analysis | Region × product category sentiment heatmap. Regional KPI table with conditional formatting. |
| 4 — Support performance | Response time bucket chart, complaint funnel visual, resolution impact bar chart |

---

## Data source

The dashboard uses `data/processed/dashboard_data.csv` — a merged file combining `sentiment_scored.csv` and `platform_kpis.csv`, created to work around Power BI web's single-file upload flow.

Run notebooks `01` → `02` → `03` → `04` first to generate the source files, then run the merge script below to produce `dashboard_data.csv`.

```bash
python3 - << 'EOF'
import pandas as pd
scored = pd.read_csv('data/processed/sentiment_scored.csv')
kpis   = pd.read_csv('data/processed/platform_kpis.csv')
merged = scored.merge(kpis, on='platform', how='left', suffixes=('', '_kpi'))
merged.to_csv('data/processed/dashboard_data.csv', index=False)
EOF
```

---

## Key DAX measures (planned)

```dax
Negative % = 
DIVIDE(
    COUNTROWS(FILTER(dashboard_data, dashboard_data[sentiment] = "negative")),
    COUNTROWS(dashboard_data)
) * 100

Avg VADER Score = AVERAGE(dashboard_data[vader_compound])

Resolution Rate % = 
DIVIDE(
    COUNTROWS(FILTER(dashboard_data, dashboard_data[issue_resolved] = "yes")),
    COUNTROWS(FILTER(dashboard_data, dashboard_data[complaint_registered] = "yes"))
) * 100
```

---

## How to view (once published)

1. Open Power BI Service: [app.powerbi.com](https://app.powerbi.com)
2. Navigate to **My Workspace** → this report
3. Or use the published link: *[to be added]*

---

*Last updated: [date] — Page 1 (Overview) in progress.*
