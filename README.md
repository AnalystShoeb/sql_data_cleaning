# Data Cleaning Project

Welcome to the Data Cleaning Project repository! 🚀  
This project demonstrates essential data preprocessing techniques, including data cleaning, transformation, and exploration, to ensure high-quality data for analysis and decision-making.

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


## 🎯 Ideal for Professionals in:
- **SQL Development**
- **Data Analytics**
- **Business Intelligence (BI)**

## 🛠️ Tools & Technologies Used:
🔹 **SQL Server Express:** Lightweight SQL database for processing data.  
🔹 **SQL Server Management Studio (SSMS):** GUI for managing SQL queries and transformations.  
🔹 **Git & GitHub:** Version control and collaboration.

## 🚀 Project Workflow
### **1️⃣ Data Ingestion (Bronze Layer)**
- Import raw data from CSV files (CRM and ERP).
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
│
├── tests/                              # Quality assurance scripts and validation tests
│
├── README.md                           # Project overview and instructions
├── LICENSE                             # License information
├── .gitignore                          # Files to be ignored by Git
└── requirements.txt                    # Dependencies for the project
```
---

## 🛡️ License
This project is licensed under the **MIT License**. Feel free to use, modify, and share with proper attribution.

## 🌟 About Me
Hi there! I'm **Shoebur Rahman**, a **Data Analyst** passionate about data cleaning, analytics, and storytelling.  
Let’s connect and explore data together! 🚀

🔗 [Portfolio](https://shoeburrahman.com) |🔗 [LinkedIn](https://www.linkedin.com/in/shoeburrahman/) | 🔗 [GitHub](https://github.com/AnalystShoeb) | 🔗 [Medium](https://medium.com/@analystshoeb)
