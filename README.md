# Data Cleaning and Exploratory Data Analysis (EDA) Project

Welcome to the Data Cleaning and Exploratory Data Analysis (EDA) Project repository! 🚀  
This project demonstrates essential data preprocessing techniques, including data cleaning, transformation, and exploration, to ensure high-quality data for analysis and decision-making. Designed as a portfolio project, it showcases industry best practices in data cleaning and EDA using SQL.

## 🏗️ Data Architecture
The data pipeline for this project follows the **Medallion Architecture** with **Bronze, Silver, and Gold** layers:

- **Bronze Layer:** Stores raw data as-is from source systems (CSV files, SQL tables, etc.).
- **Silver Layer:** Involves data cleansing, standardization, and normalization to prepare structured data for analysis.
- **Gold Layer:** Houses business-ready, enriched data optimized for insights and reporting.

## 📖 Project Overview
This project covers:

✅ **Data Acquisition:** Importing data from CSV files into a SQL Server database.  
✅ **Data Cleaning:** Handling missing values, duplicates, inconsistent formatting, and outliers.  
✅ **Data Transformation:** Standardization, normalization, type conversions, and derived features.  
✅ **Exploratory Data Analysis (EDA):** Summary statistics, data distributions, and key trends using SQL queries.  
✅ **Data Validation & Quality Assurance:** Ensuring data accuracy and consistency.  
✅ **Insights & Visualization:** Generating meaningful insights for business decision-making.

## 🎯 Ideal for Professionals in:
- **SQL Development**
- **Data Engineering**
- **Data Analytics**
- **ETL Pipeline Development**
- **Business Intelligence (BI)**

## 🛠️ Tools & Technologies Used:
🔹 **SQL Server Express:** Lightweight SQL database for processing data.  
🔹 **SQL Server Management Studio (SSMS):** GUI for managing SQL queries and transformations.  
🔹 **Draw.io:** Designing data architecture and flow diagrams.  
🔹 **Power BI / Tableau:** Visualizing insights derived from cleaned data.  
🔹 **Notion:** Managing project tasks and documentation.  
🔹 **Git & GitHub:** Version control and collaboration.

## 🚀 Project Workflow
### **1️⃣ Data Ingestion (Bronze Layer)**
- Import raw data from CSV files.
- No transformations applied at this stage.

### **2️⃣ Data Cleaning & Standardization (Silver Layer)**
- Removing duplicates and handling NULL values.
- Standardizing data formats (dates, currency, text cases).
- Correcting data inconsistencies and errors.
- Handling outliers and irrelevant data points.

### **3️⃣ Data Transformation & Modeling (Gold Layer)**
- Creating standardized and enriched tables.
- Generating new variables (aggregations, categorical encodings).
- Normalizing or denormalizing tables based on analysis needs.

### **4️⃣ Exploratory Data Analysis (EDA)**
- Descriptive statistics (mean, median, mode, distribution).
- Detecting correlations and relationships between variables.
- Identifying trends and anomalies in the dataset.
- Preparing data for reporting and visualization.

### **5️⃣ Data Consumption & Insights**
- Running analytical queries for business insights.
- Creating Power BI / Tableau dashboards.
- Making data-driven recommendations.

## 📂 Repository Structure
```plaintext
data-cleaning-eda/
│
├── datasets/                           # Raw datasets (CSV files)
│
├── docs/                               # Documentation and architecture details
│   ├── data_architecture.drawio        # Data architecture diagram
│   ├── data_catalog.md                 # Dataset details and metadata
│   ├── cleaning_steps.md               # Documentation on cleaning processes
│
├── scripts/                            # SQL scripts for data processing
│   ├── bronze/                         # Scripts for loading raw data
│   ├── silver/                         # Scripts for cleaning and standardizing data
│   ├── gold/                           # Scripts for feature engineering and transformations
│   ├── eda/                            # SQL queries for exploratory data analysis
│
├── tests/                              # Quality assurance scripts and validation tests
│
├── README.md                           # Project overview and instructions
├── LICENSE                             # License information
├── .gitignore                          # Files to be ignored by Git
└── requirements.txt                    # Dependencies for the project

## 🛡️ License
This project is licensed under the **MIT License**. Feel free to use, modify, and share with proper attribution.

## 🌟 About Me
Hi there! I'm **Shoebur Rahman**, a **Data Analyst** passionate about data cleaning, analytics, and storytelling.  
Let’s connect and explore data together! 🚀

🔗 [LinkedIn](https://www.linkedin.com/in/shoeburrahman/) | 🔗 [GitHub](https://github.com/AnalystShoeb) | 🔗 [Medium](https://medium.com/@analystshoeb)
