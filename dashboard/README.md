# Dashboard

## sentiment_dashboard.pbix

Power BI Desktop file with 4 report pages.

### Pages

| Page | Description |
|---|---|
| **1 — Overview** | Overall sentiment KPIs, distribution donut chart, top/bottom platform ranking |
| **2 — Platform deep-dive** | Side-by-side platform comparison — avg rating, neg%, resolution rate, response time. Includes a platform slicer. |
| **3 — Regional analysis** | Region × product category sentiment heatmap. Regional KPI table with conditional formatting. |
| **4 — Support performance** | Response time bucket chart, complaint funnel visual, resolution impact bar chart |

### How to open

1. Download and install [Power BI Desktop](https://powerbi.microsoft.com/desktop/) (free)
2. Open `sentiment_dashboard.pbix`
3. If prompted to update data source, point it to `../data/processed/sentiment_scored.csv`
4. Click **Refresh** on the Home ribbon

### Data source

The dashboard connects to `data/processed/sentiment_scored.csv`.  
Run notebooks `01` → `02` → `03` → `04` first to generate this file.

### Key DAX measures used

```dax
Negative % = 
DIVIDE(
    COUNTROWS(FILTER(reviews, reviews[sentiment] = "negative")),
    COUNTROWS(reviews)
) * 100

Avg VADER Score = AVERAGE(reviews[vader_compound])

Resolution Rate % = 
DIVIDE(
    COUNTROWS(FILTER(reviews, reviews[issue_resolved] = "yes")),
    COUNTROWS(FILTER(reviews, reviews[complaint_registered] = "yes"))
) * 100
```
