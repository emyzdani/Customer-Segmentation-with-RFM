# Customer Segmentation with RFM Analysis (SQL + Power BI)

## 📌 Project Overview
This project demonstrates a **real-world customer segmentation workflow** using the **RFM (Recency, Frequency, Monetary) model**, fully implemented in **SQL** and visualized in **Power BI**.

The final output is a **Power BI dashboard** designed for business stakeholders to easily understand customer segments and take action.

---

## 🧩 Business Problem
Retail businesses often ask:
- Who are our **best customers**?
- Which customers are **at risk of churn**?
- Which segments should marketing focus on?

RFM analysis is a proven method to answer these questions using transactional data.

---

## 🗄️ Data Source
- **Database:** AdventureWorksDW2025
- **Main Tables Used:**
  - FactInternetSales
  - DimCustomer
  - DimGeography
  - DimDate

---

## 🧠 Methodology

### 1️⃣ Data Preparation & RFM Calculation (SQL)
All steps below were implemented **entirely in SQL**:

- **Recency:** Days since the customer's last purchase
- **Frequency:** Number of distinct orders per customer
- **Monetary:** Total sales amount per customer

### 2️⃣ RFM Scoring (SQL)
- Customers were scored using **quantile-based ranking**
- Each metric was assigned a score from **1 (low) to 4 (high)**

### 3️⃣ Customer Segmentation (SQL)
Based on RFM scores, customers were grouped into meaningful business segments such as:
- Champions
- Loyal Customers
- Potential Loyalists
- At Risk
- Lost Customers

The final result is a **clean segmentation table**, ready for BI and reporting.

---

## 📊 Power BI Dashboard
The SQL output was imported into **Power BI** to create an interactive dashboard including:

- Customer segment distribution
- Revenue contribution by segment
- Average RFM metrics per segment
- Customer count by segment

The dashboard is designed to be:
- Business-friendly
- Actionable
- Suitable for marketing and CRM teams

---

## 🛠️ Tools & Technologies
- **SQL Server**
- **Power BI**
- **AdventureWorksDW dataset**

---

## 🎯 Key Skills Demonstrated
- Business-oriented data analysis
- RFM modeling in SQL
- Customer segmentation logic
- Data modeling for BI
- Dashboard design for decision-making

---

## 📌 Notes
- No Python was used in this project
- Focused on realistic, entry-level data analyst tasks
- Designed to reflect actual workflows in retail analytics teams

---

## 🚀 Future Improvements
- Add time-based comparison of customer segments
- Combine RFM with product category analysis
- Automate refresh and reporting

---

## 📬 Contact
If you'd like to discuss this project or collaborate, feel free to reach out.
[LinkedIn](https://www.linkedin.com/in/mostafa-yaazdani/)
