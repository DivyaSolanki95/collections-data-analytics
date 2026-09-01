# Collections Analytics — Data Quality Report

## Purpose

This report documents the major data-quality findings identified during
profiling and entity-resolution analysis. Findings are treated conservatively:
an anomaly is not automatically classified as an error without sufficient
evidence.

---

## Data Quality Findings

| Issue ID | Dataset | Issue | Detection Method | Treatment / Decision | Business Impact |
|---|---|---|---|---|---|
| DQ-001 | payments | Repeated payment identifiers / references observed | Payment identifier profiling | Investigate before applying business-key deduplication | Potential recovery inflation if repeated identifiers represent duplicate payment events; no financial impact quantified yet |
| DQ-002 | accounts | Unmatched borrower identifiers observed | Account-to-borrower entity resolution | Preserve account and flag unresolved borrower relationship | May affect borrower-level segmentation and attribution; no financial impact quantified yet |
| DQ-003 | account_status_history | Current and historical account status may differ | Latest historical status comparison | Preserve history and flag mismatches | Prevents historical state from being silently overwritten; impact not quantified yet |

---

## Detailed Findings

### DQ-001 — Repeated Payment Identifiers / References

**Detection:** Payment identifier profiling identified repeated payment
identifiers or references.

**Treatment:** Repeated identifiers are not automatically treated as duplicate
payments. Business-key deduplication should only be applied after confirming
whether the records represent retries, legitimate repeated events, or
ingestion duplication.

**Business impact:** If true duplicate payment events are present, recovered
amount and recovery metrics could be overstated. No financial impact is
claimed until the duplicate event logic is validated.

---

### DQ-002 — Unmatched Borrower Identifiers

**Detection:** Account-to-borrower entity resolution identified accounts with
unmatched borrower identifiers.

**Treatment:** Accounts are preserved and the unresolved borrower relationship
is flagged rather than removing the account.

**Business impact:** Unresolved relationships can affect borrower-level
segmentation, attribution, and analysis. The account itself is not considered
invalid solely because the borrower relationship is unresolved.

---

### DQ-003 — Current vs Historical Account Status

**Detection:** Latest historical account status was compared with the current
account status.

**Treatment:** Historical status is preserved and mismatches are flagged.
Historical states are not silently overwritten by the current status.

**Business impact:** Preserving historical state prevents time-dependent
analysis from being distorted by replacing historical information with the
current account state.

---

## Data Treatment Principles

The analysis follows these principles:

1. Do not classify anomalies as errors without evidence.
2. Preserve source records wherever possible.
3. Flag unresolved relationships instead of silently dropping records.
4. Preserve historical states for time-dependent analysis.
5. Avoid deduplication unless a defensible business key is established.
6. Do not quantify financial impact where the available evidence does not
   support a reliable estimate.

---

## Limitations

The current quality log identifies potential data-quality risks but does not
provide a validated record count or financial impact for each issue.

Therefore, this report does not invent affected-record counts or monetary
impact estimates. Further validation is required before assigning a
quantitative financial impact to these findings.