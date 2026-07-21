# Retail Business Performance & Profitability Analysis

**Elevate Labs — Data Analyst Internship Final Project**

## Objective
Analyze transactional retail data to uncover profit-draining categories, examine the relationship between fulfillment speed and profitability, and identify seasonal/regional sales patterns.

## Dataset
Retail Superstore order-level dataset — 8,399 transactions (2009–2012), covering Product Category, Sub-Category, Region, Sales, Profit, Order Priority, and Shipping details.

## Tools Used
- **SQL** (T-SQL / SSMS-compatible queries) — see `sql/retail_analysis_queries.sql`
- **Python** (Pandas, Seaborn, Matplotlib) — see `notebooks/Retail_Profitability_Analysis.ipynb`
- **Power BI** — dashboard built from `data/superstore_cleaned.csv` (filters: Region, Category, Season)

## Repo Structure
```
├── data/
│   ├── superstore_cleaned.csv          # cleaned dataset
│   └── result_*.csv                     # SQL query outputs
├── sql/
│   └── retail_analysis_queries.sql      # all SQL queries (SSMS-ready)
├── notebooks/
│   └── Retail_Profitability_Analysis.ipynb
├── charts/                              # exported chart images
├── report/
│   └── Retail_Profitability_Analysis_Report.pdf
└── README.md
```

## Key Findings
- **Furniture** is barely profitable (2.3% margin) vs. Technology (14.8%) and Office Supplies (13.8%) — dragged down by Tables and Bookcases.
- **Nunavut and Yukon** have the weakest regional profit margins.
- **Fulfillment speed (days to ship) has only a weak correlation (~0.29)** with profit margin — pricing/discounting is the bigger lever, not shipping efficiency.

## Recommendations
Audit discount policy on Furniture (Tables/Bookcases), review regional pricing in Nunavut/Yukon, and consider repricing or discontinuing the worst-performing sub-categories.

## Full Report
See `report/Retail_Profitability_Analysis_Report.pdf` for the full 2-page write-up.
