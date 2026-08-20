# Power BI Build Guide

Since I can't generate a `.pbix` file directly, here's everything needed to build it in Power BI Desktop in ~20-30 minutes.

## 1. Connect data
Home → Get Data → SQL Server/PostgreSQL/MySQL → point to the `customer_engagement` table (or Get Data → Text/CSV → `customer_engagement_churn_clean.csv` if you're skipping SQL).

## 2. DAX Measures to create

```DAX
Total Customers = COUNTROWS(customer_engagement)

Churned Customers = SUM(customer_engagement[churned])

Churn Rate % = DIVIDE([Churned Customers], [Total Customers], 0) * 100

Avg Order Value = AVERAGE(customer_engagement[purchase_amount_inr])

Return Rate % = DIVIDE(SUM(customer_engagement[returned_item]), [Total Customers], 0) * 100
```

## 3. Pages to build

**Page 1 — Overview**
- KPI cards: Total Customers, Churn Rate %, Avg Order Value
- Bar chart: Churn Rate % by `loyalty_tier`
- Line/column chart: Churn Rate % by recency bucket (create a calculated column bucketing `days_since_last_purchase` into 0-30/31-60/61-90/90+)

**Page 2 — Channel & Category**
- Clustered bar: Churn Rate % by `purchase_channel`
- Bar chart: Avg Order Value by `category`
- Slicers: `gender`, `loyalty_tier`

**Page 3 — Retention Priority**
- Table: `city`, Avg Order Value, Churn Rate % — sorted descending by churn rate, filtered to above-average order value (mirrors Q7 in the SQL file)
- Use this page to visually flag "high value, high churn risk" cities for the retention team

## 4. Tips for the interview
Be ready to explain *why* you picked churn rate + recency bucket as your headline metrics — that's the kind of question that comes up when you present this project.
