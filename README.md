# Collections Data Analytics

## Overview

A production-style collections analytics project designed to evaluate loan
recovery performance, collection operations, payment outcomes, portfolio
risk, attribution sensitivity, and the business case for collection
investment.

The project combines data validation, Golden dataset preparation, SQL
analysis, Python analytics, operational diagnostics, statistical controls,
investment scenario analysis, and a Power BI executive dashboard.

---

## Business Objective

The analysis answers four core business questions:

1. How much recovery is being generated from the outstanding portfolio?
2. Which borrower, account, and collection-operation factors are associated
   with payment outcomes?
3. How reliable are the observed recovery and attribution metrics?
4. Should the business approve a proposed ₹10 Cr collection investment?

The analysis distinguishes descriptive evidence from causal claims and
explicitly documents limitations where the available data does not support
reliable conclusions.

---

## Key Results

| Metric | Result |
|---|---:|
| Total accounts | 30,000 |
| Successful recovered amount | ₹129.15 Cr |
| Total outstanding portfolio | ₹1,048.90 Cr |
| Recovery rate | 12.31% |
| Recovery per account | ₹43,048.77 |
| Recovery per agent-hour | ₹4,888.26 |
| Contact rate | 47.65% |
| PTP rate | 99.98% |
| PTP kept rate | 3.54% |

---

## Channel Conversion

| Channel | Conversion Rate |
|---|---:|
| FIELD | 45.05% |
| MIXED | 44.15% |
| VOICE | 43.83% |
| WHATSAPP | 43.76% |
| SMS | 42.82% |

These are descriptive channel comparisons and should not be interpreted as
causal effects.

---

## Investment Decision

A proposed **₹10 Cr collection investment** was evaluated using explicit
downside, base, and upside scenarios.

| Scenario | Incremental Recovery | Net Value After Investment | Simple ROI |
|---|---:|---:|---:|
| Downside | ₹5 Cr | -₹5 Cr | -50% |
| Base | ₹10 Cr | ₹0 | 0% |
| Upside | ₹15 Cr | +₹5 Cr | 50% |

### Break-even

The investment requires at least **₹10 Cr of incremental recovery** to
break even.

Against the baseline recovery rate of **12.31%**, this corresponds to
approximately:

- **+0.95 percentage points** of recovery-rate lift
- **13.27%** break-even total recovery rate

### Recommendation

**Do not approve the full ₹10 Cr investment unconditionally.**

Use a controlled pilot or staged investment and scale only if measured
incremental recovery exceeds the ₹10 Cr break-even threshold under a fixed
and documented attribution and evaluation framework.

---

## Dashboard

The project includes a **one-screen Power BI executive dashboard** covering
recovery performance, portfolio exposure, DPD, risk segments, monthly
recovery, and validation of the reported recovery claim.

### Dashboard Preview

[View Dashboard Preview](dashboard/dashboard_preview.png)

### Power BI Dashboard

[Download Power BI Dashboard](dashboard/collections_analytics_dashboard.pbix)

The dashboard is supported by
`dashboard/dashboard_data_manifest.csv` and the processed analytical
datasets.

---

## Analytical Methodology

### 1. Data Profiling and Validation

The project begins with profiling and validation of identifiers,
timestamps, amounts, statuses, relationships, duplicates, and data-quality
issues.

### 2. Golden Dataset

Validated source data is standardized into trusted Golden datasets for
downstream analysis.

Key Golden entities include:

- Accounts
- Payments
- Agents
- Calls
- Campaigns
- Daily targeting
- Field visits
- Promises to pay
- SMS events
- WhatsApp events
- Vendor telephony

### 3. Recovery Analysis

The analysis calculates and evaluates:

- Recovered amount
- Outstanding portfolio
- Recovery rate
- Recovery per account
- Recovery per agent-hour
- Recovery by DPD
- Recovery by risk segment
- Recovery by loan type
- Monthly recovery
- Recovery mix
- Recovery-claim validation

### 4. Operational Analysis

Collection operations are evaluated across:

- Contact rate
- PTP rate
- PTP fulfillment
- Calling-time buckets
- Attempt frequency
- Agent tenure
- Campaign performance
- Channel performance
- Vendor performance

### 5. Attribution Analysis

Payment-to-collection attribution is evaluated using multiple attribution
windows, including a 72-hour operational window.

Attribution-sensitive results are treated cautiously because overlapping
attribution records can affect attributed recovery.

### 6. Cohort and Bias Analysis

The project evaluates potential effects from:

- Portfolio mix
- Risk segments
- DPD
- Account cohorts
- Agent tenure
- Calling time
- Collection attempts
- Selection bias
- Survivorship bias
- Simpson's paradox
- Attribution-window bias
- Time-series variation

Observational differences are not automatically interpreted as causal
effects.

---

## Counterfactual Framework

The project documents a counterfactual evaluation framework for assessing
what recovery might have looked like without a change in targeting strategy.

The framework includes:

- Treatment group
- Control group
- Eligibility rules
- Outcome definition
- Assumptions
- Potential confounders
- Identification / matching approach
- Statistical evaluation
- Limitations

The current evidence is observational and does not establish a causal
effect without a controlled or quasi-experimental evaluation.

---

## Core Metrics

| Metric | Status |
|---|---|
| Contact Rate | Measured |
| RPC | Not reliably measurable |
| PTP Rate | Measured |
| PTP Kept Rate | Measured |
| Recovery Rate | Measured |
| Recovery per Account | Measured |
| Recovery per Agent-Hour | Measured |
| Cost per ₹ Recovered | Not reliably measurable |
| Channel Conversion | Measured |

### Metric Limitations

RPC is not reliably measurable because the available call data does not
provide a validated right-party-contact disposition mapping.

Cost per ₹ recovered is not reliably measurable because reliable collection
operating-cost data was not identified.

The project deliberately does not fabricate unsupported metrics.

---

## Key Operational Findings

### Risk Segment

Observed payment rates were:

| Risk Segment | Payment Rate |
|---|---:|
| LOW | 44.46% |
| MEDIUM | 43.58% |
| NPA | 43.50% |
| HIGH | 43.25% |

The observed differences are small and the statistical analysis did not
establish a significant difference in successful-payment outcome across
risk segments.

### Agent Tenure

Observed payment rates were:

| Tenure | Payment Rate |
|---|---:|
| 181–365 days | 43.74% |
| 365+ days | 43.76% |

The difference is approximately 0.02 percentage points, providing no
evidence of a material tenure effect in the observed population.

### Calling Time

Observed payment rates were:

| Calling Time | Payment Rate |
|---|---:|
| Afternoon | 43.81% |
| Evening | 43.95% |
| Morning | 43.94% |
| Night | 43.80% |

No material difference is established from these descriptive results.

### Attempts

Observed payment rates across attempt buckets were:

| Attempts | Payment Rate |
|---|---:|
| 1 attempt | 43.62% |
| 2–3 attempts | 42.94% |
| 4–5 attempts | 44.09% |
| 6–10 attempts | 44.92% |
| 11+ attempts | 42.86% |

These are observational results and should not be interpreted as evidence
that increasing attempts causes higher or lower payment rates.

---

## Data Quality and Analytical Controls

The project includes checks for:

- Missing critical identifiers
- Invalid or missing payment amounts
- Duplicate payment records
- Repeated payment references
- Invalid statuses
- Referential integrity
- Timestamp validity
- Timezone consistency
- Agent identity conflicts
- Historical status consistency
- Attribution overlap
- Unexpected population changes

Important limitations identified include:

- **3,284** repeated payment references
- **0** exact duplicate payment rows
- **1,000** agent IDs with conflicting identity attributes
- **25** multi-attributed payments
- **21.25%** of payment events occurring near midnight
- Timezone-naive payment timestamps

These limitations are explicitly considered when interpreting operational
comparisons.

---

## Data Coverage Limitation

The supplied payment data covers **8 observed months**, from January 2026
through August 2026.

The assignment references approximately 12 months of historical performance;
however, no additional payment months were present in the supplied Golden
payment dataset.

The analysis therefore uses the complete available 8-month observation
window rather than fabricating or extrapolating missing months.

Monthly and time-series findings should consequently be interpreted as
descriptive evidence over the available January–August 2026 period.

---

## Production Analytics Architecture

The project follows a production-oriented analytical design:

```text
Raw Operational Data
        ↓
Staging / Ingestion
        ↓
Clean / Standardized Data
        ↓
Golden Dataset
        ↓
Feature Layer
        ↓
Metrics Layer
        ↓
Power BI Data Model
        ↓
One-Screen Executive Dashboard
        ↓
Business Findings & Recommendations

The architecture documents:

Data contracts
Primary keys
Entity integrity
Data lineage
Incremental processing
Late-arriving data
Backfills
Data-quality checks
Monitoring
Anomaly detection
Metric governance
Production decision principles

See:

Architecture Documentation

Architecture Diagram

Repository Structure
collections-data-analytics/
│
├── architecture/
│   ├── architecture.md
│   └── collections_analytics_architecture.png
│
├── dashboard/
│   ├── collections_analytics_dashboard.pbix
│   ├── dashboard_data_manifest.csv
│   └── dashboard_preview.png
│
├── data/
│   └── processed/
│       ├── golden_*.csv
│       ├── core_kpis.csv
│       ├── executive_snapshot.csv
│       ├── final_findings.csv
│       ├── recovery_*.csv
│       ├── monthly_recovery.csv
│       ├── root_cause_evidence.csv
│       └── ...
│
├── notebooks/
│   ├── 01_raw_data_profiling.ipynb
│   ├── 02_golden_dataset.ipynb
│   ├── 03_data_quality_log.ipynb
│   └── 04_recovery_analysis.ipynb
│
├── reports/
│   ├── data_quality_report.md
│   └── executive_memo.md
│
├── sql/
│   └── 01_recovery_analysis.sql
│
├── README.md
└── .gitignore
Technology Stack
Python
Pandas
NumPy
Jupyter Notebooks
SQL / MySQL
Power BI
Git
GitHub
Project Deliverables
Data & Analytics
Data profiling
Data validation
Golden datasets
Data-quality analysis
SQL recovery analysis
Python recovery analysis
Statistical and operational analysis
Attribution sensitivity analysis
Investment scenario analysis
Business Outputs
One-screen Power BI executive dashboard
Executive memo
Data quality report
Final findings
Recovery summaries
Channel performance
Agent performance
Campaign performance
Vendor performance
Architecture
Production analytics architecture
Architecture diagram
Data contracts
Metric governance
Data lineage
Monitoring and anomaly-detection design
Interpretation Principles

The project distinguishes between:

Data-quality issues
Descriptive operational evidence
Correlation
Strong evidence
Hypotheses
Business recommendations

Observational relationships are not automatically interpreted as causal
effects.

Where the available data does not support a reliable metric or conclusion,
the limitation is explicitly documented rather than replaced with an
unsupported estimate.

Final Business Recommendation

The collections organization should not commit the full ₹10 Cr expansion
budget immediately.

A controlled pilot or staged investment is recommended, with scaling
conditional on measured incremental recovery exceeding the ₹10 Cr
break-even threshold, equivalent to approximately +0.95 percentage
points of recovery-rate lift from the 12.31% baseline.

This approach limits downside exposure while allowing the organization to
scale the investment if incremental recovery is demonstrated.

Executive Memo

Read the Executive Memo

Data Quality Report

Read the Data Quality Report

SQL Analysis

View SQL Analysis

Author

Collections Data Analytics Project

Built using Python, SQL, Power BI, and Git-based analytical workflows.