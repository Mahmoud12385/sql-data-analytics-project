# 📊 Data Analytics Project

## 📝 Overview
This project demonstrates a structured **data analysis workflow** on a sales dataset, combining **Exploratory Data Analysis (EDA)**, **Change-Over-Time Analysis**, **Category & Gender Contribution Analysis**, and **Ranking Analysis**.  
The goal is to understand data distribution, trends, performance drivers, and top contributors to support informed business decisions.

---

## 🚀 Project Phases

### **Phase 1: EDA (Exploratory Data Analysis)**

Exploration of core dimensions and measures to understand data coverage and quality.

#### 1️⃣ Database Exploration
- 🗄 Count of rows and uniqueness checks
- ❓ Missing values and null distribution
- 🔑 Key coverage validation

#### 2️⃣ Dimensions Exploration
- 👤 `dim_customers`: gender, marital status, country, birth date ranges
- 📦 `dim_products`: category, subcategory, product lines, costs
- 🛒 `fact_sales`: order, shipping, and due date ranges

#### 3️⃣ Date Exploration
- 📅 Sales coverage by year, month, and year-month combination
- ⏳ Age ranges and customer creation timeline

#### 4️⃣ Measures Exploration
- 💰 Sales amount, quantity, price distribution
- Min, max, and average calculations

#### 5️⃣ Magnitude Exploration
- 📊 Summarize total sales per customer, product, category
- Validate extreme and anomalous values

#### 6️⃣ Ranking Exploration
- 🏆 Rank customers and products by total sales
- Rank by quantity purchased or average order value
- Monthly product ranking using window functions

---

### **Phase 2: Advanced Analytics**

#### 1️⃣ Change-Over-Time Analysis
- 📈 Yearly, monthly, and combined year-month trends
- Track total sales, total customers, and quantity trends

#### 2️⃣ Cumulative Analysis
- 🔄 Calculate running totals and cumulative contributions
- Identify growth patterns over time

#### 3️⃣ Performance Analysis
- 🌟 Measure top-performing categories, subcategories, and products
- Quantify total sales, quantity, and average prices

#### 4️⃣ Part-to-Whole Analysis
- 🍰 Category and subcategory contribution to total sales and quantity
- 👥 Customer gender contribution to overall sales
- Highlight most impactful dimensions

#### 5️⃣ Data Segmentation
- 🧩 Segment data by product line, category, and customer attributes
- Understand behavior patterns of different groups

#### 6️⃣ Reporting
- 📋 Prepare summary tables and dashboards for decision-making
- Highlight top contributors, trends, and KPIs

---

## 🛠 SQL Scripts Included
1. **Data Range Exploration** – Customer, product, and sales coverage  
2. **Ranking Analysis** – Top customers/products by sales, rank by quantity and average order value  
3. **Change-Over-Time** – Yearly, monthly, and year-month trend analysis  
4. **Category & Gender Contribution** – Part-to-whole analysis and sales contributions  

---

## ℹ️ About
This project follows **best practices for analytics documentation**:
- 📌 Each SQL script includes a **purpose statement** at the top
- 🧾 Clear and concise **comments around code blocks**
- 🚫 Avoided comments on obvious operations
- 🧩 Modular CTEs for readability and maintainability

**Tools & Technologies**
- 🖥 SQL Server / T-SQL
- 🏢 Data warehouse schema (`gold.dim_customers`, `gold.dim_products`, `gold.fact_sales`)
- 🗂 GitHub for version control and documentation

**Outcome**
- 🎯 Comprehensive understanding of sales trends and customer behavior
- 💎 Identified high-value products, categories, and customer segments
- 📊 Ready for reporting, visualization, and business decision support
