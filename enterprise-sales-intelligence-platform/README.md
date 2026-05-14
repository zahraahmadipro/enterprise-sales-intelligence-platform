# Enterprise Sales Intelligence Platform

Enterprise-grade Data Warehouse and Business Intelligence solution built with SQL Server and T-SQL.

This project demonstrates the complete lifecycle of a modern BI platform including data ingestion, staging, ETL pipelines, dimensional modeling, incremental loading, data quality validation, analytical reporting, and ETL monitoring.

Designed as a portfolio-level project for:
- Data Engineering
- Business Intelligence Development
- SQL Development
- Data Warehouse Engineering

---

# Project Overview

The Enterprise Sales Intelligence Platform transforms raw transactional sales data into structured analytical datasets optimized for reporting and decision-making.

The architecture follows a layered enterprise data engineering approach:

```text
OLTP Database
      ↓
Staging Layer
      ↓
ETL Pipelines
      ↓
Data Warehouse (Star Schema)
      ↓
BI Views & Reports
```

This project simulates a real-world enterprise BI environment where operational data is processed into analytical models for business reporting and performance analysis.

---

# Core Features

## Enterprise Data Warehouse
- Star schema architecture
- Fact and dimension modeling
- Surrogate key implementation
- Analytical query optimization

## ETL Framework
- Automated ETL procedures
- Incremental data loading
- Dimension synchronization
- ETL orchestration pipeline

## Data Quality System
- Validation checks
- DQ summary reporting
- ETL quality gates
- Data integrity verification

## Performance Optimization
- Indexing strategies
- Incremental processing optimization
- Query performance tuning
- Reporting optimization

## Business Intelligence Layer
Analytical SQL views for:
- Sales analysis by date
- Product performance analysis
- Customer analysis
- Top customer reporting

---

# Technologies Used

| Category | Technology |
|---|---|
| Database | SQL Server |
| Query Language | T-SQL |
| Architecture | Data Warehouse / Star Schema |
| ETL | SQL Stored Procedures |
| Reporting | SQL Analytical Views |
| BI Integration | Power BI Ready |
| Data Quality | SQL Validation Framework |

---

# Repository Structure

```text
Enterprise-Sales-Intelligence-Platform
│
├── BI/
│   ├── Sales analytical views
│
├── Database/
│   ├── OLTP database scripts
│   ├── Staging database scripts
│   └── Data warehouse scripts
│
├── DW/
│   ├── Dimension creation
│   ├── Fact table creation
│   └── Warehouse loading scripts
│
├── ETL/
│   ├── Staging procedures
│   ├── Incremental loading
│   ├── ETL orchestration
│   ├── Logging framework
│   └── Data quality processes
│
├── DQ/
│   ├── Data quality tables
│   └── Validation scripts
│
├── Reports/
│   └── Reporting queries
│
└── Staging/
    └── Raw data staging scripts
```

---

# Data Warehouse Design

## Fact Table
- FactSales

## Dimension Tables
- DimCustomer
- DimProduct
- DimCategory
- DimDate

The warehouse model is optimized for analytical workloads and reporting performance.

---

# ETL Workflow

## 1. Load Operational Data
Raw transactional data is loaded into staging tables.

## 2. Transform and Clean Data
Transformation logic standardizes and prepares data for analytics.

## 3. Load Dimension Tables
Dimension entities are populated and synchronized.

## 4. Load Fact Table
Sales transactions are processed into the fact table.

## 5. Run Data Quality Checks
Validation procedures verify consistency and integrity.

## 6. Generate BI Views
Business-ready analytical views are created for reporting tools and dashboards.

---

# Advanced Engineering Features

## Incremental Loading
The ETL pipeline supports efficient incremental processing using:
- ETL control tables
- Incremental load logic
- Optimized indexing strategies

## ETL Logging & Monitoring
The framework includes:
- ETL run tracking
- Step-level execution logging
- Error handling
- Pipeline monitoring

## Data Quality Gate
Automated validation checks include:
- Missing dimension validation
- Invalid foreign key detection
- Null critical field checks
- Fact table consistency validation

---

# Example Business Use Cases

- Revenue trend analysis
- Customer segmentation analysis
- Product performance tracking
- Sales reporting by time period
- Top customer identification
- Category performance analysis

---

# Execution Guide

## Step 1 — Create Databases
Execute scripts from:
```text
Database/
```

## Step 2 — Create Staging Environment
Execute scripts from:
```text
Staging/
```

## Step 3 — Create Data Warehouse Objects
Execute scripts from:
```text
DW/
```

## Step 4 — Run ETL Pipeline
Execute:
```sql
ETL/25_run_full_etl_pipeline.sql
```

or

```sql
ETL/27_run_full_etl_with_logging.sql
```

## Step 5 — Query BI Views
Use analytical views inside:
```text
BI/
```

---

# Future Enhancements

- Power BI dashboard integration
- SQL Server Agent scheduling
- Slowly Changing Dimensions (SCD)
- Cloud deployment (Azure / AWS)
- Real-time data ingestion
- CI/CD pipeline automation

---

# Skills Demonstrated

- Data Warehousing
- ETL Engineering
- SQL Development
- Query Optimization
- Data Quality Engineering
- BI Development
- Enterprise Database Design

---

# Author

Enterprise SQL Server & Business Intelligence Portfolio Project
