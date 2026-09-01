# Collections Data Analytics

## Overview

A production-style collections analytics project designed to evaluate loan recovery performance, collection operations, payment outcomes, and the business case for scaling collection investment.

The project combines data validation, Golden Layer preparation, SQL analysis, Python-based statistical and operational analysis, and a Power BI dashboard to produce evidence-backed recommendations for collections leadership.

---

## Business Objective

The analysis answers four core questions:

1. How much recovery is being generated from the outstanding portfolio?
2. Which borrower, account, operational, and collection factors are associated with payment outcomes?
3. How reliable are the observed recovery and attribution metrics?
4. Should the business approve a ₹10 Cr investment to expand collections?

The analysis emphasizes descriptive and evidence-based conclusions and explicitly documents limitations where the available data does not support causal claims.

---

## Key Results

| Metric | Result |
|---|---:|
| Total accounts | 30,000 |
| Successful recovered amount | ₹129.15 Cr |
| Total outstanding portfolio | ₹1,048.90 Cr |
| Recovery rate | 12.31% |
| Overall successful-payment rate | 43.70% |
| Recovery per account | ₹43,048.77 |
| Recovery per agent-hour | ₹4,888.26 |
| Contact rate | 47.65% |
| PTP rate | 99.98% |
| PTP kept rate | 3.54% |

### Channel Conversion

| Channel | Conversion Rate |
|---|---:|
| FIELD | 45.05% |
| MIXED | 44.15% |
| VOICE | 43.83% |
| WHATSAPP | 43.76% |
| SMS | 42.82% |

Channel differences are descriptive and should not be interpreted as causal effects.

---

## Investment Decision

The analysis evaluated a proposed ₹10 Cr collection expansion investment.

### Break-even

The investment requires:

- ₹10 Cr of incremental recovery
- Approximately +0.95 percentage points of recovery-rate lift
- Baseline recovery rate: 12.31%
- Break-even recovery rate: approximately 13.27%

### Scenario Analysis

| Scenario | Incremental Recovery | Net Value | Simple ROI |
|---|---:|---:|---:|
| Downside | ₹5 Cr | -₹5 Cr | -50% |
| Base | ₹10 Cr | ₹0 | 0% |
| Upside | ₹15 Cr | +₹5 Cr | 50% |

### Recommendation

**Do not approve the full ₹10 Cr investment unconditionally.**

Proceed through a controlled pilot or staged investment. Scale only after measured incremental recovery demonstrates performance above the ₹10 Cr break-even threshold under a fixed and documented evaluation framework.

---

## Analytical Methodology

### 1. Data Profiling and Validation

The project begins with raw data profiling and validation of identifiers, timestamps, amounts, statuses, and relationships between datasets.

### 2. Golden Dataset

Validated source datasets are standardized into Golden datasets for downstream analysis.

Key Golden datasets include:

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

Successful payments are used to calculate:

- Recovered amount
- Outstanding portfolio
- Recovery rate
- Recovery by DPD
- Recovery by risk segment
- Recovery by loan type
- Monthly recovery
- Recovery mix
- Recovery claim validation

### 4. Operational Analysis

The project evaluates:

- Contact rate
- PTP rate
- PTP fulfillment
- Calling-time buckets
- Attempt frequency
- Agent tenure
- Campaign performance
- Vendor performance
- Channel conversion

### 5. Attribution Analysis

Payment-to-collection attribution is evaluated using multiple windows:

- 1 hour
- 6 hours
- 24 hours
- 72 hours

Material differences were observed across attribution windows. Therefore, attribution-sensitive metrics require a fixed and documented attribution window.

### 6. Cohort Analysis

Payment outcomes were evaluated by account-opening cohort.

Observed cohort payment rates ranged from approximately 41.33% to 46.30%, a range of approximately 4.97 percentage points.

This is treated as descriptive cohort variation rather than causal evidence.

---

## Required Metrics

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

### Data Limitations

RPC is not reliably measurable because a validated right-party-contact disposition mapping is unavailable.

Cost per ₹ recovered is not reliably measurable because reliable collection operating-cost data was not identified.

These metrics are intentionally not estimated or fabricated.

---

## Statistical and Analytical Controls

The project includes checks for:

- Cohort effects
- Selection bias
- Survivorship bias
- Attribution-window sensitivity
- Risk-segment variation
- Monthly recovery variation
- Simpson's paradox
- Business-driver data availability

These controls are intended to prevent misleading conclusions from observational collections data.

---

## Important Findings

### Risk Segment

Payment rates were broadly similar across risk segments:

- LOW: 44.46%
- MEDIUM: 43.58%
- NPA: 43.50%
- HIGH: 43.25%

No evidence of a reversal consistent with Simpson's paradox was detected in the tested risk-segment comparison.

### Agent Tenure

Payment rates were almost identical across the measured agent-tenure groups:

- 181–365 days: 43.74%
- 365+ days: 43.76%

The observed difference is approximately 0.02 percentage points and does not indicate a material tenure effect.

### Calling Time

Observed payment rates were also similar across calling-time buckets:

- Afternoon: 43.81%
- Evening: 43.95%
- Morning: 43.94%
- Night: 43.80%

No material difference is established from these descriptive results.

### Collection Touch

1,520 accounts received a collection touch compared with 28,480 without a recorded collection touch.

Measured DPD and outstanding amounts were broadly similar between the two groups, but selection bias cannot be ruled out because the collection-touch assignment process is observational.

---

## Dashboard

The project includes a Power BI dashboard:

`dashboard/collections_analytics_dashboard.pbix`

The dashboard is supported by a dashboard data manifest and processed analytical datasets.

---

## Repository Structure

```text
collections-data-analytics/
│
├── architecture/
│   ├── architecture.md
│   └── collections_analytics_architecture.png
│
├── dashboard/
│   ├── collections_analytics_dashboard.pbix
│   └── dashboard_data_manifest.csv
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
└── .gitignore