# Collections Analytics — Production Architecture

## 1. Project Overview

This project analyzes collections performance, recovery effectiveness,
portfolio risk, campaign performance, payment outcomes, and operational
collection performance.

The analytical design follows a production-oriented pipeline from raw
operational data to validated Golden datasets, analytical features,
business metrics, an executive dashboard, and decision-ready findings.

---

## 2. Production Analytics Pipeline

```text
RAW OPERATIONAL DATA
        ↓
STAGING / INGESTION
        ↓
CLEAN / STANDARDIZED DATA
        ↓
GOLDEN DATASET
        ↓
FEATURE LAYER
        ↓
METRICS LAYER
        ↓
POWER BI DATA MODEL
        ↓
ONE-SCREEN EXECUTIVE DASHBOARD
        ↓
BUSINESS FINDINGS & RECOMMENDATIONS

Raw Operational Data

Source systems include accounts, payments, borrowers, agents, calls,
campaigns, targeting, digital interactions, field visits, promises-to-pay,
and vendor data.

Staging / Ingestion

Raw records are ingested while preserving source identifiers, timestamps,
source-system fields, and ingestion-level audit information.

Clean / Standardized Data

Cleaning and standardization include identifier validation, status
normalization, timestamp treatment, duplicate detection, amount validation,
timezone handling, and schema/quality checks.

Golden Dataset

Validated and reconciled datasets provide the trusted analytical source
for downstream analysis.

Golden entities include accounts, payments, agents, calls, campaigns,
targeting, field visits, promises-to-pay, digital events, and vendor
telephony.

Feature Layer

Analytical features include DPD buckets, risk segments, payment outcomes,
calling-time buckets, attempt frequency, agent tenure, campaign/channel
attributes, cohort indicators, and payment-attribution features.

Metrics Layer

Business metrics include recovery rate, recovered amount, recovery per
account, recovery per agent-hour, contact rate, PTP rate, PTP kept rate,
channel conversion, and monthly recovery performance.

Metrics are defined consistently using documented numerator, denominator,
population, and attribution rules.

Power BI Data Model

The semantic model provides relationships, measures, calculated fields,
and standardized business definitions for dashboard reporting.

One-Screen Executive Dashboard

The executive dashboard is designed as a single-screen leadership view
covering recovery performance, portfolio exposure, monthly recovery,
operational performance, and recovery-claim validation.

Business Findings & Recommendations

Analytical findings are translated into business decisions, including
investment scenarios, break-even analysis, limitations, and recommended
next steps.

3. Data Contracts

Each analytical dataset should have a documented schema containing:

Dataset/entity name
Primary key
Required fields
Data types
Timestamp fields
Allowed status values
Referential relationships
Quality expectations
Schema version

Changes to critical schemas should be detected and reviewed before
downstream metrics are refreshed.

4. Primary Keys and Entity Integrity

Key entities use stable identifiers such as:

Entity	Primary Key
Accounts	account_id
Payments	payment_id
Agents	agent_id
Calls	call_id
Campaigns	campaign_id
Daily Targeting	target_id
Field Visits	visit_id
Promises to Pay	ptp_id
SMS Events	sms_event_id
WhatsApp Events	whatsapp_event_id
Vendor Telephony	vendor_id

Foreign-key relationships are validated where applicable, particularly
between accounts, payments, calls, agents, campaigns, and collection events.

5. Data Lineage

The analytical lineage is:

Source Systems
      ↓
Raw / Staging
      ↓
Cleaned & Standardized Records
      ↓
Golden Datasets
      ↓
Analytical Features
      ↓
Business Metrics
      ↓
Power BI Model
      ↓
Executive Dashboard

Processed outputs are retained as auditable analytical artifacts so that
key business metrics can be traced back to the underlying Golden datasets.

6. Incremental Processing

A production implementation should process new and changed records
incrementally using event timestamps, ingestion timestamps, or other
reliable change indicators.

Previously processed records should not be unnecessarily recomputed.

Metrics affected by late-arriving or corrected records should be
recalculated for the impacted reporting periods.

7. Late-Arriving Data

Late-arriving events can change historical metrics, particularly payments,
calls, promises-to-pay, and attribution outcomes.

The production design should:

Detect late-arriving records.
Preserve the original event timestamp.
Reprocess affected reporting periods.
Refresh impacted metrics.
Record the correction in an audit log.
8. Backfills

Backfills should be supported when source data is corrected, historical
records are reprocessed, or transformation logic changes.

Backfills should be:

Reproducible
Auditable
Limited to affected periods where possible
Validated through post-backfill data-quality checks
9. Data Quality Checks

The pipeline includes checks for:

Missing critical identifiers
Invalid or missing payment amounts
Duplicate payment records
Duplicate payment references
Invalid statuses
Referential integrity
Timestamp validity
Timezone consistency
Agent identity consistency
Historical status consistency
Schema changes
Unexpected population changes

Records failing critical rules should be flagged, rejected, or corrected
according to documented treatment rules.

10. Monitoring

Production monitoring should track:

Record volumes
Missing-value rates
Duplicate rates
Referential-integrity failures
Payment success volumes
Recovery amounts
Recovery-rate movements
Processing freshness
Schema changes
Failed pipeline checks

Threshold breaches should generate an operational alert and trigger
investigation before affected metrics are relied upon for decision-making.

11. Anomaly Detection

Business and data anomalies should be monitored using historical
baselines and predefined thresholds.

Examples include:

Unusual recovery-rate changes
Sudden payment-volume changes
Unexpected account-population changes
Large month-to-month recovery movements
Abnormal vendor/campaign volumes
Sudden changes in call outcomes
Attribution-window inconsistencies

Anomalies should be investigated before being interpreted as genuine
business performance changes.

12. Metric Governance

Core metrics require documented definitions covering:

Numerator
Denominator
Population
Time period
Attribution window
Inclusion/exclusion rules
Data source
Known limitations

Where the data does not support a reliable metric, the metric should be
explicitly marked as unavailable rather than estimated without evidence.

13. Production Decision Principles

The system is designed to separate:

Data-quality issues
Descriptive operational evidence
Correlation
Strong evidence
Hypotheses
Business recommendations

Observational relationships should not automatically be interpreted as
causal effects.

Investment decisions should use measured incremental outcomes and
documented assumptions rather than relying solely on raw recovery
differences.


## Data Coverage Limitation

The supplied payment data covers 8 observed months, from January 2026
through August 2026. The assignment references approximately 12 months
of historical performance; however, no additional payment months were
present in the supplied Golden payment dataset.

The analysis therefore uses the complete available 8-month observation
window rather than fabricating or extrapolating missing months.

Monthly and time-series findings should consequently be interpreted as
descriptive evidence over the available January–August 2026 period.

