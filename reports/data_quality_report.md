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
| DQ-001 | payments | Repeated payment identifiers / references observed | Payment identifier profiling and duplicate-event investigation | Retain payment references; exclude only verified exact duplicate rows | 3,284 repeated references were observed, but 0 exact duplicate rows and ₹0 exact-duplicate financial impact were identified |
| DQ-002 | accounts | Unmatched borrower identifiers observed | Account-to-borrower entity resolution | Preserve account and flag unresolved borrower relationship | May affect borrower-level segmentation and attribution; no validated financial impact quantified |
| DQ-003 | account_status_history | Current and historical account status may differ | Latest historical status comparison | Preserve history and flag mismatches | Prevents historical state from being silently overwritten |
| DQ-004 | payments | Payment timestamps are timezone-naive | Timestamp format and timezone-label profiling | Preserve source timestamps; do not apply an assumed timezone conversion | 21.25% of payment events occur between 22:00 and 02:59 and may be sensitive to calendar-date shifts |
| DQ-005 | vendor_telephony | Vendor mapping changes investigated | Vendor identifier consistency check | Retain vendor_id as the stable identifier | No conflicting vendor names, vendor accounts, timezones, or schema versions detected |
| DQ-006 | agents | Agent identifiers reused across conflicting identities | Agent identity profiling | Do not treat agent_id as a unique person-level key; flag identity conflicts | 1,000 agent IDs show conflicting identity attributes |
| DQ-007 | attribution | Multiple attribution records for the same payment | Payment-level attribution investigation | Use successful payments as source of truth; require mutually exclusive attribution for operational comparisons | 25 payments have multiple attribution records with ₹1,782,308.87 potential excess attributed recovery |

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

The investigation identified several data-quality and analytical limitations.

Repeated payment references do not represent confirmed duplicate payment
events. The investigation identified 3,284 repeated references but 0 exact
duplicate rows, so no duplicate-payment financial impact is claimed.

Payment timestamps are timezone-naive. No source timezone is explicitly
provided, so an assumed timezone conversion is not applied.

Agent identifiers are reused across conflicting identity attributes, requiring
caution when interpreting agent-level performance.

Attribution overlap can create double-counting within campaign, agent, or
vendor attribution views. The source-of-truth recovery metric therefore
remains based on successful payment events.

Where evidence does not support a reliable quantitative financial impact, no
monetary estimate is invented.