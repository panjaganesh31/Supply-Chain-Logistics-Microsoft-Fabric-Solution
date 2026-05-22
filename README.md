# 🏭 Samsung Supply Chain & Logistics Analytics — Microsoft Fabric

<p align="center">
  <img src="Supply_Chain_Dashboard.png" alt="Supply Chain Dashboard" width="100%"/>
</p>

<p align="center">
  <img alt="Microsoft Fabric" src="https://img.shields.io/badge/Microsoft%20Fabric-742774?style=for-the-badge&logo=microsoft&logoColor=white"/>
  <img alt="Power BI" src="https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black"/>
  <img alt="Dataflow Gen2" src="https://img.shields.io/badge/Dataflow%20Gen2-0078D4?style=for-the-badge&logo=microsoft&logoColor=white"/>
  <img alt="Power Query (M)" src="https://img.shields.io/badge/Power%20Query%20(M)-2C2F33?style=for-the-badge"/>
  <img alt="DAX" src="https://img.shields.io/badge/DAX-FFCA28?style=for-the-badge"/>
  <img alt="Parquet" src="https://img.shields.io/badge/Parquet-50ABF1?style=for-the-badge&logo=apacheparquet&logoColor=white"/>
  <img alt="Lakehouse" src="https://img.shields.io/badge/Lakehouse-1F6FEB?style=for-the-badge"/>
</p>

> **End-to-end analytics solution simulating Samsung's global supply chain operations** — built on Microsoft Fabric to unify procurement, production, inventory, sales, and shipment data into a single, refresh-automated dashboard for executive decision-making.

---

## 🎯 At a Glance

| | |
|---|---|
| **Role** | Solo end-to-end build: Data Engineer + BI Developer + Analyst |
| **Stack** | Microsoft Fabric · Lakehouse · Dataflow Gen2 · Power Query (M) · DAX · Power BI · Parquet |
| **Scope** | 10 tables · ~24K fact records · 5 dashboard pages · automated daily refresh |
| **Domain** | Supply Chain & Logistics (procurement → production → inventory → sales → shipment) |
| **Outcome** | Single-pane-of-glass dashboard surfacing 10+ executive KPIs across global operations |

---

## 💡 The Business Problem

Global manufacturers operate across fragmented systems: ERP for procurement, MES for production, WMS for inventory, CRM for sales, and TMS for shipments. Executives lose visibility into **cross-functional KPIs** — *Are we profitable on the customers we ship most to? Which suppliers cause our worst delays? Are inventory levels aligned with safety stock?*

This project simulates that problem for a Samsung-style operation and builds the **unified analytics layer** that answers those questions in seconds — not days.

---

## 📋 Table of Contents

- [Skills Demonstrated](#-skills-demonstrated)
- [Key Business Insights](#-key-business-insights-from-the-dashboard)
- [Dashboard KPIs](#-dashboard-kpis)
- [Architecture](#-architecture)
- [Data Model](#-data-model)
- [Design Decisions & Trade-offs](#-design-decisions--trade-offs)
- [Project Structure](#-project-structure)
- [Pipeline Flow](#-pipeline-flow)
- [Prerequisites](#-prerequisites)
- [Getting Started](#-getting-started)
- [Import Guide](#-import-guide)
- [What I Learned](#-what-i-learned)
- [Roadmap](#-roadmap)
- [Contact](#-contact)

---

## 🧠 Skills Demonstrated

**Data Engineering**
- Designed and built a **Lakehouse architecture** on Microsoft Fabric (Bronze → Silver pattern: raw `/Files` CSV → curated `/Tables` Parquet)
- Authored **Dataflow Gen2** transformations in **Power Query (M)** with **Fast Copy** enabled for high-throughput ingestion
- Built **scheduled Data Pipelines** orchestrating Dataflow refresh → Semantic Model refresh in dependency order

**Data Modeling**
- Designed a **star schema** with 5 conformed dimensions and 5 fact tables across the supply chain value chain
- Modeled grain carefully per fact table (daily inventory snapshot vs. transactional sales vs. shipment events)
- Built calculated measures in **DAX** for revenue, profit margin, perfect-order rate, and lead-time variance

**BI & Visualization**
- Designed a **5-page executive dashboard** (Overview · Supplier · Inventory · Shipment · Customer) in **Power BI**
- Implemented cross-page filtering (Year · Month · Customer) and consistent KPI cards across views
- Applied dashboard design principles: visual hierarchy, color discipline, drill-down navigation

**Domain & Business Acumen**
- Translated **supply chain operations** (procurement, production, inventory, sales, shipment) into measurable KPIs
- Mapped logistics concepts — safety stock, reorder point, perfect-order %, carrier delay reasons, supplier tier — into the data model

**DevOps & Documentation**
- Versioned all Fabric assets in **Git** (Lakehouse SQL project, Dataflow JSON, XMLA semantic model definition, .pbix)
- Wrote import/deployment documentation enabling reproducible setup in any Fabric workspace

---

## 🔍 Key Business Insights from the Dashboard

Real value is in the *findings* a dashboard surfaces, not just the visuals. A few that this solution reveals:

- **Profit margin (27.44%) is healthy, but the 24.71% imperfect-order rate** signals meaningful revenue leakage from delays, defects, or short shipments — quantifiable improvement target.
- **Inventory value of 160K vs. shipment quantity of 3M** highlights inventory turnover efficiency — a leading indicator for working-capital optimization.
- **Carrier-level delay tracking** on the Shipment page allows procurement to renegotiate SLAs with underperforming carriers using evidence, not anecdote.
- **Supplier lead-time variance** on the Supplier page exposes which Tier-1 vs Tier-2 suppliers are reliability risks for production planning.
- **Channel-level revenue analysis** on the Customer page enables sales leadership to prioritize the channels with the highest profit contribution, not just the highest top-line.

---

## 📊 Dashboard KPIs

The Supply Chain Dashboard (Overview page) surfaces these executive metrics:

| KPI | Value | Business Meaning |
|-----|-------|------------------|
| 💰 Gross Revenue | **186.86M** | Top-line before discounts/returns |
| 💵 Total Revenue | **176.95M** | Net revenue recognized |
| 📈 Total Profit | **48.56M** | Bottom-line contribution |
| 📉 Profit Margin | **27.44%** | Operational efficiency |
| ✅ Perfect Order % | **75.29%** | Supply chain reliability |
| 🚚 Total Shipment | **7,500** | Outbound logistics volume |
| 📦 Order Quantity | **129K** | Demand throughput |
| 🏭 Inventory Value | **160K** | Working capital tied in stock |
| 🚢 Shipment Quantity | **3M** | Units in motion |
| 📬 Delivered Quantity | **187.13K** | Fulfillment completion |

**Filters:** Year · Month · Customer Name  
**Pages:** Overview · Supplier · Inventory · Shipment · Customer

---

## 🏗️ Architecture

```
GitHub Repository (source of truth for all Fabric assets)
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
       │         ├── Source: Lakehouse /Files (CSV — Bronze)
       │         ├── Transform: Power Query (M) — cleansing, typing, joins
       │         └── Destination: Lakehouse /Tables (Parquet — Silver)
       │
       ├── ⚙️  Supply_Chain_Pipeline_for_schedule_refresh
       │         ├── Step 1: Run Supply_Chain_Dataflow
       │         └── Step 2: Refresh Supply Chain Semantic Model
       │
       └── 🏠 Supply_Chain_Lakehouse
                 ├── /Files   (10 raw CSV source files)
                 └── /Tables  (10 transformed Parquet tables)
```

**Why this architecture:** Separating raw (`/Files`) from curated (`/Tables`) follows the **medallion pattern** — raw is replayable, curated is consumption-ready. Pipeline orchestration guarantees the semantic model never refreshes against stale data.

---

## 📊 Data Model

A classic **star schema** — 5 dimensions, 5 facts, conformed on `date_key`, `product_id`, `customer_id`, `facility_id`, and `supplier_id`.

### Dimension Tables

| Table | Rows | Key Columns |
|-------|------|-------------|
| `dim_customer` | 5 | customer_id, customer_name, country, channel_type, size, annual_volume_usd |
| `dim_date` | 731 | date_key, date, year, quarter, month, month_name, week, day, is_weekend |
| `dim_facility` | 6 | facility_id, facility_name, country, city, facility_type, specialization, annual_capacity |
| `dim_product` | 16 | product_id, product_name, category, product_line, spec, color, unit_price, unit_cost |
| `dim_supplier` | 7 | supplier_id, supplier_name, country, city, specialty, tier, avg_quality_score |

### Fact Tables

| Table | Rows | Grain | Key Columns |
|-------|------|-------|-------------|
| `fact_inventory` | 1,152 | Daily snapshot per product per facility | date_key, product_id, facility_id, stock_level, safety_stock_level, reorder_point |
| `fact_procurement` | 2,200 | Purchase order line | product_id, supplier_id, order_quantity, unit_cost, total_cost, lead_time_days, quality_score |
| `fact_production` | 4,500 | Production run | product_id, facility_id, quantity_produced, defective_units, defect_rate_pct |
| `fact_sales` | 8,500 | Sales transaction | product_id, customer_id, quantity_sold, gross_revenue, net_revenue, profit, profit_margin_pct |
| `fact_shipment` | 7,500 | Shipment event | product_id, customer_id, quantity, carrier, status, shipping_cost, delay_reason |

> **Total Records:** ~24,052 rows across fact tables  
> **Date Range:** 2023–2024 (731 days)  
> **Storage Format:** Parquet (columnar, compressed — chosen for analytical scan performance)

---

## ⚖️ Design Decisions & Trade-offs

| Decision | Why | Trade-off Considered |
|----------|-----|----------------------|
| **Lakehouse over Warehouse** | Need to handle both raw CSV (`/Files`) and structured tables (`/Tables`) in one place; lower entry cost | Warehouse offers better T-SQL DML; not needed for read-heavy BI workload |
| **Dataflow Gen2 over Notebooks** | Low-code Power Query is faster to author and maintain for tabular CSV ingestion | Notebooks (PySpark) would scale further for big data — but overkill at 24K rows |
| **Parquet output format** | Columnar compression dramatically speeds up DAX scans vs. row-based formats | Slightly larger write time vs. CSV — acceptable trade for read perf |
| **Pipeline (not direct refresh)** | Guarantees Dataflow completes *before* semantic model refresh — eliminates stale-data risk | Adds one orchestration layer to maintain |
| **Star schema (not snowflake)** | Simpler DAX, faster query performance, easier for business users to understand | Some attribute redundancy in dims — acceptable at this scale |

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

## ⚙️ Pipeline Flow

The pipeline `Supply_Chain_Pipeline_for_schedule_refresh` runs two steps sequentially:

```
Step 1: Supply_Chain_Dataflow      (ingest + transform)
        ↓ (on success)
Step 2: Semantic Model refresh     (re-cache for Power BI)
```

This dependency ordering ensures the report is **never served stale data**. Schedule is configured in Pipeline settings — currently daily, easily switched to hourly or event-triggered.

---

## ✅ Prerequisites

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
Follow the [Import Guide](#-import-guide) below in order.

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

## 🎓 What I Learned

- **Orchestration matters more than transformation.** Building the Dataflow was straightforward; getting the *pipeline dependency order* right was what made refresh reliable.
- **Grain discipline pays compounding interest.** A clear per-fact-table grain definition upfront eliminated DAX double-counting bugs that would have been painful later.
- **Format choice is a performance lever.** Switching curated output from CSV to Parquet measurably improved DAX scan times — a free win.
- **Dashboards earn their value at the page level, not the KPI card.** The Overview page sells the story; the Supplier/Inventory/Shipment/Customer pages let executives *answer follow-up questions* — which is what drives adoption.

---

## 🗺️ Roadmap

Future enhancements I'd prioritize if extending this project:

- [ ] **Real-time ingestion** via Eventstream for shipment status updates
- [ ] **Anomaly detection** on lead-time spikes using Fabric Data Science notebooks
- [ ] **Row-level security (RLS)** to scope dashboards by region/business unit
- [ ] **Incremental refresh** on `fact_sales` and `fact_shipment` to scale beyond the current volume
- [ ] **Alerting** via Data Activator on perfect-order % falling below threshold

---

## 📅 Version History

| Version | Date | Description |
|---------|------|-------------|
| v1.0.0 | March 2026 | Initial release — 10 tables, ~24K records, full pipeline & dashboard |

---

## 📬 Contact

For questions, feedback, or collaboration, please open an **Issue** in this repository — or connect with me on LinkedIn.

---

<p align="center">
  <em>Built with Microsoft Fabric · Power BI · Dataflow Gen2 · Data Pipelines · Parquet</em><br/>
  <em>Simulated Samsung Supply Chain & Logistics dataset</em>
</p>
