# 🏭 Supply Chain & Logistics — Microsoft Fabric Solution

<p align="center">
  <img src="Supply_Chain_Dashboard.png" alt="Supply Chain Dashboard" width="100%"/>
</p>

> An end-to-end **Samsung Supply Chain & Logistics** analytics solution built on Microsoft Fabric — covering inventory, procurement, production, sales, and shipment across global operations.

---

## 📋 Table of Contents

- [Overview](#overview)
- [Dashboard KPIs](#dashboard-kpis)
- [Architecture](#architecture)
- [Project Structure](#project-structure)
- [Data Model](#data-model)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Import Guide](#import-guide)
- [Pipeline Flow](#pipeline-flow)
- [Contributing](#contributing)

---

## 🔍 Overview

This repository contains all Microsoft Fabric components for the **Supply Chain** workspace, built for **Samsung Supply Chain & Logistics** operations. The solution provides real-time visibility across the full supply chain — from supplier procurement to customer delivery.

**Key Capabilities:**
- Real-time KPI monitoring: Revenue, Profit, Inventory & Shipment
- Supplier lead time analysis & performance tracking
- Inventory value management across product lines
- Shipment delay tracking by carrier
- Revenue analysis by customer channel
- Automated data refresh via scheduled pipelines (Dataflow → Semantic Model)

---

## 📊 Dashboard KPIs

The Supply Chain Dashboard (Overview page) displays the following metrics:

| KPI | Value |
|-----|-------|
| 💰 Gross Revenue | **186.86M** |
| 💵 Total Revenue | **176.95M** |
| 📈 Total Profit | **48.56M** |
| 📉 Profit Margin | **27.44%** |
| ✅ Perfect Order % | **75.29%** |
| 🚚 Total Shipment | **7,500** |
| 📦 Order Quantity | **129K** |
| 🏭 Inventory Value | **160K** |
| 🚢 Shipment Quantity | **3M** |
| 📬 Delivered Quantity | **187.13K** |

**Filters Available:** Year · Month · Customer Name

**Dashboard Pages:** Supplier · Inventory · Shipment · Customer

---

## 🏗️ Architecture

```
GitHub Repository
       │
       ▼
Supply Chain Workspace (Microsoft Fabric)
       │
       ├── 📊 Supply Chain Dashboard (Power BI)
       │         └── Reads from Semantic Model
       │
       ├── 🔷 Supply_Chain_Semantic_Model
       │         └── Reads from Lakehouse /Tables
       │
       ├── 🔄 Supply_Chain_Dataflow Gen2
       │         ├── Source: Lakehouse /Files (CSV)
       │         ├── Transform: Power Query (M language)
       │         └── Destination: Lakehouse /Tables (Parquet)
       │
       ├── ⚙️  Supply_Chain_Pipeline_for_schedule_refresh
       │         ├── Step 1: Run Supply_Chain_Dataflow
       │         └── Step 2: Refresh Supply Chain Semantic Model
       │
       └── 🏠 Supply_Chain_Lakehouse
                 ├── /Files   (10 raw CSV source files)
                 └── /Tables  (10 transformed Parquet tables)
```

---

## 📁 Project Structure

```
Supply-Chain/
│
├── README.md                                      # Project documentation
├── Supply_Chain_Dashboard.png                     # Dashboard screenshot
│
├── Supply_Chain_Dashboard.pbix                    # Power BI Dashboard
├── Supply_Chain_Dataflow.json                     # Dataflow Gen2 template
├── Supply_Chain_Lakehouse.sqlproj                 # Lakehouse SQL project
├── xmla.json                                      # Semantic Model XMLA definition
│
└── data/                                          # Source CSV files
    ├── dim_customer.csv                           # 5 customers
    ├── dim_date.csv                               # 731 dates (2023–2024)
    ├── dim_facility.csv                           # 6 facilities
    ├── dim_product.csv                            # 16 products
    ├── dim_supplier.csv                           # 7 suppliers
    ├── fact_inventory.csv                         # 1,152 records
    ├── fact_procurement.csv                       # 2,200 records
    ├── fact_production.csv                        # 4,500 records
    ├── fact_sales.csv                             # 8,500 records
    └── fact_shipment.csv                          # 7,500 records
```

---

## 📊 Data Model

### Dimension Tables

| Table | Rows | Key Columns |
|-------|------|-------------|
| `dim_customer` | 5 | customer_id, customer_name, country, channel_type, size, annual_volume_usd |
| `dim_date` | 731 | date_key, date, year, quarter, month, month_name, week, day, is_weekend |
| `dim_facility` | 6 | facility_id, facility_name, country, city, facility_type, specialization, annual_capacity |
| `dim_product` | 16 | product_id, product_name, category, product_line, spec, color, unit_price, unit_cost |
| `dim_supplier` | 7 | supplier_id, supplier_name, country, city, specialty, tier, avg_quality_score |

### Fact Tables

| Table | Rows | Key Columns |
|-------|------|-------------|
| `fact_inventory` | 1,152 | date_key, product_id, facility_id, stock_level, safety_stock_level, reorder_point |
| `fact_procurement` | 2,200 | product_id, supplier_id, order_quantity, unit_cost, total_cost, lead_time_days, quality_score |
| `fact_production` | 4,500 | product_id, facility_id, quantity_produced, defective_units, defect_rate_pct |
| `fact_sales` | 8,500 | product_id, customer_id, quantity_sold, gross_revenue, net_revenue, profit, profit_margin_pct |
| `fact_shipment` | 7,500 | product_id, customer_id, quantity, carrier, status, shipping_cost, delay_reason |

> **Total Records:** ~24,052 rows across all fact tables  
> **Date Range:** 2023–2024 (731 days)  
> **Output Format:** Parquet (Fast Copy enabled)

---

## ⚙️ Pipeline Flow

The pipeline `Supply_Chain_Pipeline_for_schedule_refresh` runs two steps sequentially:

```
Step 1: Supply_Chain_Dataflow
        ↓ (on success)
Step 2: Supply Chain Semantic Model refresh
```

This ensures data is always fresh before the report is updated. Configure the **Schedule** in Pipeline settings to automate daily/weekly refresh.

---

## ✅ Prerequisites

Before importing, ensure you have:

- [ ] **Microsoft Fabric** license (Trial, F64, or higher)
- [ ] **Power BI Desktop** — [Download latest](https://powerbi.microsoft.com/desktop/)
- [ ] Access to the **Supply Chain** Fabric workspace
- [ ] Contributor or Admin role in the workspace

---

## 🚀 Getting Started

### Step 1 — Clone the Repository

```bash
git clone https://github.com/<your-username>/supply-chain.git
cd supply-chain
```

### Step 2 — Create the Lakehouse & Upload CSVs

```
1. Fabric → Supply Chain workspace → + New → Lakehouse
2. Name: Supply_Chain_Lakehouse
3. Go to /Files → Upload → Select all 10 CSV files from /data folder
```

### Step 3 — Import All Components

Follow the [Import Guide](#import-guide) below in order.

### Step 4 — Update Connections

After import, update the **Lakehouse workspace ID and Lakehouse ID** in the Dataflow to match your environment.

### Step 5 — Run Pipeline

Trigger the pipeline manually first to verify the full refresh, then enable the schedule.

---

## 📥 Import Guide

> ⚠️ **Import in this order:** Lakehouse → Dataflow → Semantic Model → Pipeline → Dashboard

### 1. Lakehouse

```
Fabric → + New → Lakehouse → Name: Supply_Chain_Lakehouse
Upload all CSV files to /Files folder
```

### 2. Dataflow Gen2

```
Fabric → + New → Dataflow Gen2
Click ··· → Import template → Select Supply_Chain_Dataflow.json
Update Lakehouse connection credentials
Click Publish
```

### 3. Semantic Model

```
Use xmla.json to deploy via XMLA endpoint
OR: Let the Semantic Model auto-generate from Lakehouse tables
Update relationships if needed in Power BI Desktop
```

### 4. Pipeline

```
Fabric → + New → Data Pipeline
Click ··· → Import → Select Supply_Chain_Pipeline.json
Verify Dataflow and Semantic Model connections
Click Save → Set Schedule
```

### 5. Dashboard (.pbix)

```
Open Supply_Chain_Dashboard.pbix in Power BI Desktop
Click Home → Publish → Select "Supply Chain" workspace
```

---

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Export updated Fabric items and replace existing files
4. Commit: `git commit -m "Add: description of change"`
5. Push and open a Pull Request

---

## 📅 Version History

| Version | Date | Description |
|---------|------|-------------|
| v1.0.0 | March 2026 | Initial release — 10 tables, ~24K records, full pipeline & dashboard |

---

## 📬 Contact

For questions or support, please open an **Issue** in this repository.

---

*Built with Microsoft Fabric · Power BI · Dataflow Gen2 · Data Pipelines · Parquet · Samsung Supply Chain Data*
