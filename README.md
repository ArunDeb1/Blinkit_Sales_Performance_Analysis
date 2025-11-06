# Blinkit_Sales_Performance_Analysis

## 📘 Project Overview

This project focuses on analyzing Blinkit’s (formerly Grofers') sales performance across different outlets and product categories. Using SQL and Excel, the goal is to uncover key business insights related to product mix, outlet performance, and operational efficiency. The project replicates a real-world retail analytics case study, where raw transactional and metadata tables are used to answer business questions through SQL analysis and Excel-based reporting.

## 📌 Problem Statement

"Analyze Blinkit's sales performance across different products and outlets to identify key factors that drive sales, optimize product placement, and recommend strategies for outlet expansion."

## 🎯 Core Business Objective

To evaluate sales performance drivers across Blinkit’s product categories and outlets, and provide data-driven recommendations to improve revenue, efficiency, and outlet strategy.

Specifically:
1. Identify which item types, categories, and outlets contribute most to revenue.
2. Analyze how factors like outlet size, location, and age impact performance.
3. Compare product attributes (visibility, fat content, weight) and their influence on sales.

## 🧾 Initial Dataset Summary

## 🥅 Objective

The dataset simulates Blinkit’s retail transaction records, allowing for sales performance, outlet comparison, and category analysis through SQL queries.

## 📦 Dataset Composition

The project uses three relational tables:
Table Name	Description	Key Columns
Items	Contains item-level metadata	Item_ID, Item_Type, Item_Category, Item_Weight, Item_Fat_Content, Visibility_Band, Rating
| Outlet | Contains outlet/store information | Outlet_ID, Outlet_Type, Outlet_Size, Outlet_Location_Type, Outlet_Establishment_Year|
| Sales | Transactional sales data linking items and outlets | Item_ID, Outlet_ID, Sales|

## 🛠️ Tools & Technologies

1. SQL (MySQL Workbench) – Data querying and Business Metrics
2. Excel – Data Cleaning, Feature Engineering, summary dashboards, and visualization

## ✅ What’s Working

1. ✔️ Supermarket outlets drive most revenue — especially Supermarket Type 1, showing strong customer traffic and product mix. 
2. ✔️ Medium-sized outlets are the most efficient, generating higher average sales per item than small or large ones. 
3. ✔️ Packaged Foods and Household categories dominate, contributing the largest share of total sales. 
4. ✔️ Regular-fat items outperform low-fat, suggesting customers prefer traditional options over health-focused ones. 
5. ✔️ High-visibility products generate more revenue, confirming the impact of good product placement.

## ⚠️ What’s Not Working

1. ⚠️ Small outlets underperform, likely due to limited inventory and footfall. 
2. ⚠️ Certain categories (like Health & Hygiene) show weak sales, needing better visibility or promotion. 
3. ⚠️ Heavy, low-value items reduce efficiency, leading to poor sales per weight unit. 
4. ⚠️ Sales depend heavily on a few top outlets, creating concentration risk. 
5. ⚠️ Low-visibility products sell poorly, showing a need for improved merchandising.


## 🔍 Key Insights

1. 📈 Outlet Type: Supermarket Type 1 dominates total sales volume
2. 🏬 Outlet Size: Medium outlets generate more consistent average sales
3. 🍪 Item Categories: Packaged Foods and Household products lead in revenue contribution
4. 🥤 Fat Content: Regular items slightly outperform Low Fat in total revenue
5. 💡 Outlet Age: Older outlets remain strong performers, but newer ones show faster ramp-up
6. ⚖️ Visibility: Higher visibility products show higher average sales per item

## 💼 Recommendations

1. ✅ Expand medium-sized supermarkets in high-performing locations
2. ✅ Increase shelf visibility and promotion for underperforming categories
3. ✅ Focus inventory on high revenue-per-weight categories (efficient logistics)
4. ✅ Maintain consistent customer experience in older outlets through modernization
5. ✅ Launch performance-based incentives for low-performing outlets

## 📌 Next Steps / Future Scope

1. POWER BI VISUALIZATION
2. PYTHON - Build a machine learning model to predict churn
