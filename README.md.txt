Zara Analytics – Sales & Inventory Dashboard

This project analyzes Zara’s sales data from February 19, 2024 to identify top-performing products, revenue drivers, promotional effectiveness, and gender-based purchasing behavior.


### Project Overview ###

This project is based on Zara store data from February 19, 2024 (store unspecified).
The analysis evaluates product group performance, identifies bestsellers and underperforming items, and compares customer behavior across MAN and WOMAN categories.
The project also examines how promotional items influence overall revenue and which segments contribute the most value.
The final Power BI dashboard supports decision-making on assortment optimization, promotion strategy, and improving overall sales efficiency.



## Dataset ###

This project uses several structured Excel files containing raw sales transactions, product metadata, lookup tables, and categorized attributes. These datasets serve as the foundation for the SQL analytical model and Power BI dashboard.

Included Files

zara_raw.xlsx — raw transaction-level sales data (product IDs, sales volume, promo flags, prices).

zara_products.xlsx — product identity data (SKU, name, description).

zara_section.xlsx — gender/section lookup (MAN, WOMAN).

zara_position.xlsx — product placement inside the store (aisle, end-cap, front, etc.).

zara_terms.xlsx — product type/category lookup (jackets, sweaters, etc.).

zara_fact.xlsx — cleaned and transformed fact table used for analytics and Power BI visuals.

Data period: February 19, 2024 (single-day snapshot).



## Business Questions ###


Which products generate the highest revenue?

Which products perform the worst?

How do MAN and WOMAN sections differ in customer behavior?

What share of revenue comes from promotional vs non-promotional items?

How many SKUs belong to each gender category?

What is the average revenue per product for MAN vs WOMAN?

How does promotion affect sales and revenue?



### Data Model & ETL Process ###

The data preparation consisted of three main stages:

1. Data Cleaning & Transformation (Power Query)

Raw Excel files were cleaned, standardized, and reshaped using Power Query.
Tables (products, terms, sections, positions, raw transactions) were linked through key fields to form a relational structure.

2. Loading & Processing in MySQL

After cleaning, the tables were imported into MySQL for further transformations:

joining lookup tables

creating a unified fact table

computing revenue metrics

enriching data with categories, gender, and placement attributes

3. Visualization in Power BI

The processed MySQL dataset was connected to Power BI to build an interactive dashboard with KPIs, promo impact, gender analysis, category breakdowns, and top/bottom product insights.


### Dashboard Overview ###


The Power BI dashboard provides a structured overview of Zara’s sales performance.

Main Components

Key KPIs: total revenue, promo vs non-promo revenue, SKU count by gender, average revenue per product

Gender Revenue Comparison: MAN vs WOMAN revenue and product distribution

Promo Analysis: share of revenue from promotional items

Top & Bottom Products: best-performing and underperforming items

Product Category Breakdown: jackets, sweaters, jeans, t-shirts, etc.

Dashboard Purpose: identify strong and weak product segments and support decisions on assortment, promotion, and merchandising.



### Key Insights ###

Promo items generated 51.28% of total revenue, showing strong customer response to discounts.

MAN section contributed 91.6% of total revenue, while WOMAN generated only 8.4% due to a very limited number of WOMAN SKUs.
Despite the small assortment, average revenue per WOMAN product is comparable to MAN, indicating strong potential if assortment is expanded.

Jackets are the top-performing category, with some items generating up to $650K.

Bottom 5 products generate less than $25K, showing low demand and possible overstock issues.

Product placement matters — items at End-cap and Front of Store positions show higher revenue.

Promo and Non-Promo revenue are nearly equal, reinforcing the impact of promotions.

### Possible Improvements ###

Expand the dataset to include longer time periods.

Add forecasting models for sales and promo impact.

Enrich product attributes and categories for deeper analysis.

## Tech Stack ###

Power BI — visualization and dashboard building

MySQL — data storage and analytics

Power Query — cleaning and preprocessing

Excel — raw data source

SQL — joins, transformations, calculations


### Repository Structure ###
/data                              # Raw and cleaned Excel datasets
/sql/schema                        # Table creation scripts
/sql/steps                         # Data cleaning and transformation queries
/sql/views                         # Analytical SQL views
/sql/zara_analytics_queries.sql    # Final analytical queries
/dashboard                         # Power BI report (Zara.dashboard.pbix)
README.md                          # Project documentation


### How To Run the Project ###

How to Run the Project
Download the repository and extract all /data files.
Create a MySQL database and run scripts from /sql/schema.
Import Excel datasets or load via Power Query.
Execute SQL scripts from /sql/steps and /sql/views.
Open Zara.dashboard.pbix in Power BI.
Update data connections and click Refresh.


Author

Devid Nõmmann
