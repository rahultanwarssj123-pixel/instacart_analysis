<div align="center">

# Instacart Market Basket Analysis

### Dataset & Data Documentation

**Customer Loyalty · Basket Behavior · Product Discovery**

</div>

---

## About the Dataset

This project uses the **Instacart Market Basket Analysis** dataset, a large-scale relational dataset containing anonymized grocery purchasing activity.

The dataset provides a detailed view of customer ordering behavior across products, orders, aisles, and departments. Its relational structure makes it suitable for analyzing:

- Customer loyalty and repeat purchasing
- Basket composition and size
- Purchasing behavior across days and hours
- Product and department-level reorder behavior
- Differences in purchasing patterns across customer tenure
- Product discovery versus routine replenishment

The project uses this transactional structure to answer five business questions using **PostgreSQL and Power BI**, with Python used for exploratory data analysis and validation.

---

## Dataset Source

The dataset was originally released by **Instacart** for its Market Basket Analysis competition and is available through Kaggle.

**Source:**  
[Instacart Market Basket Analysis — Kaggle](https://www.kaggle.com/datasets/psparks/instacart-market-basket-analysis/data)

The data used in this project was downloaded from the source above and analyzed locally.

---

## Relational Dataset Structure

The analysis uses six related tables:

| Table | Description |
|---|---|
| `orders` | Order-level information, including customer, order sequence, day, and hour |
| `order_products__prior` | Products purchased in customers' previous orders |
| `order_products__train` | Products associated with the designated training orders |
| `products` | Product-level information and product-to-aisle relationships |
| `aisles` | Aisle classification for products |
| `departments` | Higher-level department classification |

The relational structure connects:

**Customers → Orders → Products → Aisles → Departments**

This allows individual transactions to be analyzed at both the **customer level** and broader **product/category level**.

---

## Dataset Scale

| Metric | Scale |
|---|---:|
| **Customers analyzed** | **206,209** |
| **Orders analyzed** | **3,421,083** |
| **Order-product line items** | **32M+** |
| **Products** | **49K+** |
| **Aisles** | **134** |
| **Departments** | **21** |

### Project Baseline Metrics

| Metric | Result |
|---|---:|
| **Average basket size** | **10.11 items** |
| **Median basket size** | **8 items** |
| **Overall reorder rate** | **59%** |

These baseline measures were established during the exploratory analysis and provide context for the subsequent SQL analysis.

---

## Data Preparation & Validation

The six source CSV files were loaded and validated during the exploratory analysis phase using **Python and pandas**.

The validation process included:

- Schema and column inspection
- Data-type validation
- Missing-value assessment
- Relational join validation
- Orphan-record checks
- Order and basket-size distribution analysis
- Reorder-rate validation
- Summary-statistic generation

The relational joins were checked to ensure that the tables could be reliably combined for downstream analysis.

The validated data structure was then used as the foundation for the PostgreSQL business analysis.

---

## Data Availability

The raw CSV files are **not included in this GitHub repository because of their large size**.

Instead, the repository contains the analytical workflow required to understand and reproduce the project:

- Exploratory analysis
- SQL business analysis
- Power BI dashboard
- Project documentation

This keeps the repository lightweight while maintaining transparency around the analytical process.

---

## Reproducing the Analysis

To reproduce the analysis:

1. Download the dataset from the [Kaggle source](https://www.kaggle.com/datasets/psparks/instacart-market-basket-analysis/data).
2. Extract the downloaded files.
3. Place the required CSV files inside this `data/` directory.
4. Open the exploratory analysis notebook in `notebooks/`.
5. Load the required data into PostgreSQL.
6. Execute the SQL queries in `sql/`.
7. Open the Power BI dashboard from `visualization/`.

The repository separates the **source data, exploratory analysis, SQL analysis, visualization, and documentation** into dedicated components.

---

## Data Used Across the Analysis

| Business Area | Primary Tables |
|---|---|
| **Aisle reorder behavior** | `orders`, `order_products__prior`, `products`, `aisles` |
| **Basket size and timing** | `orders`, `order_products__prior` |
| **Customer tenure** | `orders`, `order_products__prior` |
| **Department behavior** | `orders`, `order_products__prior`, `products`, `departments` |
| **Order-size behavior** | `orders`, `order_products__prior` |

The same underlying relational data is used to examine customer behavior from several perspectives rather than treating each business question as an isolated analysis.

---

## Repository Components

| Component | Purpose |
|---|---|
| [`../notebooks/`](../notebooks/) | Python exploratory data analysis and data validation |
| [`../sql/`](../sql/) | PostgreSQL business analysis and query logic |
| [`../visualization/`](../visualization/) | Power BI dashboard |
| [`../images/`](../images/) | Dashboard screenshots used in the project documentation |
| [`../README.md`](../README.md) | Complete project overview, methodology, and findings |

---

<div align="center">

**Instacart Market Basket Analysis**

*From transactional data to customer behavior insights.*

</div>
