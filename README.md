# Customer Engagement & Churn Analysis

This is an end-to-end data analytics project I built using Python, SQL and Power BI. The idea was to look at customer behavior data and figure out who's likely to stop buying (churn) and why, so a retention team would actually know where to focus.

## Why I picked this problem

Most retail businesses lose customers quietly. Someone just... stops ordering, and nobody notices until months later. I wanted to build something that catches that early, using signals like how long it's been since their last purchase, what loyalty tier they're in, and which channel they buy from.

## What I did

I started in Python, loading the raw customer data and cleaning it up (checking for duplicates, weird ages, missing values, that kind of thing). Once the data looked solid, I ran some quick exploratory analysis to get a feel for where churn was showing up the most.

From there I moved into SQL and wrote queries around specific business questions, mainly to get exact numbers I could trust instead of just eyeballing charts. Things like churn rate broken down by loyalty tier, by how long someone's been inactive, and by which city they're in.

Last step was Power BI, building a dashboard so someone non-technical (like a retention manager) could filter by tier or channel and see the churn picture without touching SQL themselves.

## What I found

The biggest thing that stood out was loyalty tier. Bronze tier customers churn at almost 24%, which is more than double every other tier. Gold and Silver sit around 8-10%. So the loyalty program is clearly doing something right, once people move up a tier they tend to stick around.

Inactivity was the other strong signal. The longer since someone's last purchase, the more likely they've churned, and this correlation was pretty strong in the data (~0.49). That's a fairly easy thing to flag and act on, like triggering a win-back email after 60-90 days of no activity.

I also noticed in-store buyers churn more than website buyers (about 19% vs 13%). Not totally sure why, could be a loyalty visibility gap in physical stores, or just a different type of customer shopping in person. Worth digging into more if this were a real business.

One thing that surprised me: discounts didn't really move the needle on churn or returns. I expected discounted customers to stick around more, but the numbers were nearly identical to full-price customers. So blanket discounting might not be doing much for retention on its own.

## Dashboard

Three pages in the Power BI file:
- Overview — KPI cards, churn by loyalty tier, churn by recency bucket
- Channel & Category — churn and order value split by channel and product category
- Retention Priority — a table of cities that have high order value but also high churn, basically a "look here first" list for the retention team

## Tools used

Python (pandas, numpy) for cleaning and EDA, SQL for the business questions, Power BI for the dashboard.

## Running it

1. `pip install pandas numpy`
2. Run through `Customer_Engagement_Churn_Analysis.ipynb` — this cleans the data and spits out `customer_engagement_churn_clean.csv`
3. Load that cleaned CSV into your SQL database as `customer_engagement`
4. Run `customer_engagement_sql_queries.sql`
5. Connect Power BI to the same table and build the dashboard (layout notes are in `POWERBI_GUIDE.md`)