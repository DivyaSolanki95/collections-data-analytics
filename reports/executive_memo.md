# Executive Memo — Collections Performance Review

## Executive Summary

The business-reported claim that recovery has improved by 11% is not
supported by the independent recovery calculation used in this analysis.

Using the reconciled recovery definition, the calculated recovery rate is
**12.31%**, compared with the reported **11.00%**.

The analysis also shows that aggregate recovery is influenced by differences
across DPD and risk segments, while campaign, channel, agent, and vendor
performance varies materially. These factors mean that aggregate recovery
should not be interpreted as pure operational improvement without controlling
for portfolio composition and attribution.

---

## What Happened?

The independently calculated recovery rate from the supplied data is
**12.31%**, compared with the reported **11.00%**.

Recovery also differs across DPD and risk segments, indicating that changes in
portfolio composition can materially influence the aggregate recovery result.

Campaign and channel performance varies, and agent and vendor performance also
shows differences across the collection operation.

PTP volume should not be treated as equivalent to successful collection.
The observed PTP fulfillment rate is only **7.09%**, so recorded PTPs need to
be validated against subsequent successful payments.

---

## Why Did It Happen?


The available evidence identifies several factors that can influence interpretation
of reported recovery:

1. **Portfolio mix:** Recovery varies descriptively across DPD and risk
   segments, but the statistical tests did not establish a significant
   difference in successful-payment outcome by risk segment (p = 0.468456)
   or DPD bucket (p = 0.091219).

2. **Campaign and channel differences:** Collection outcomes vary across
   campaigns and channels, but these observational differences should not be
   interpreted as causal effects.

3. **Operational variation:** Agent and vendor performance differs, while
   agent identity conflicts require caution when interpreting agent-level
   comparisons.

4. **PTP conversion:** Recorded PTPs do not necessarily result in successful
   payments. The observed PTP fulfillment rate is 7.09%.

5. **Attribution limitations:** 25 payments have multiple attribution records,
   creating a potential excess attributed amount of ₹1,782,308.87. Attributed
   recovery should therefore not replace the source-of-truth successful
   payment metric.

6. **Data-quality and timestamp limitations:** Payment timestamps are
   timezone-naive, and 21.25% of payment events occur near midnight. Repeated
   payment references were also observed, although no exact duplicate payment
   rows were identified.

These findings should be interpreted as evidence of contributing factors and
data limitations, not proof of causality.

## How Confident Are We?

**High confidence:** The independently calculated recovery rate is **12.31%**
under the reconciled recovery definition used in the analysis.

**Strong evidence:** The supplied data supports the existence of differences
across campaigns, channels, agents, and vendors, but these are observational
comparisons.

**Statistical evidence:** Successful-payment outcome was not statistically
significantly different across risk segments (p = 0.468456) or DPD buckets
(p = 0.091219) at the 5% significance level.

**Limitations:** Attribution overlap, agent identity conflicts, timezone-naive
timestamps, and repeated payment references require explicit consideration
when interpreting operational comparisons.

The analysis does not establish that any individual campaign, channel, agent,
vendor, DPD bucket, or risk segment caused the observed recovery differences.

## Recommendation

Management reporting should use the reconciled recovery definition
consistently rather than relying on the reported 11% figure.

For operational decisions:

- Track recovery using consistent DPD and risk-segment cohorts.
- Compare campaigns using common targeting and attribution definitions.
- Use normalized productivity and recovery metrics for agent and vendor
  evaluation.
- Measure PTP fulfillment using independently matched payment outcomes.
- Maintain explicit data-quality flags and metric definitions.

No single operational investment should be scaled solely from aggregate
recovery comparisons without controlling for portfolio mix and attribution.

---

## Expected Financial Impact

The supplied findings establish the difference between the reported **11.00%**
and calculated **12.31%** recovery rates, but they do not provide sufficient
evidence to reliably estimate incremental recovery, ROI, or break-even for a
specific investment.

Therefore, a precise financial-return claim is **not made**.

Before allocating a major investment, management should validate the
incremental effect using consistent cohorts, attribution rules, and a
controlled or quasi-experimental evaluation.

---


## Decision

**Do not treat the reported 11% improvement as standalone proof of
operational improvement.**

Use the reconciled **12.31% recovery rate** as the independently calculated
reference metric.

The analysis found no statistically significant difference in successful
payment outcome across risk segments (p = 0.468456) or DPD buckets
(p = 0.091219) at the 5% significance level.

Before making operational investment decisions, management should also account
for:

- **3,284** repeated payment references, with **0 exact duplicate rows**
- timezone-naive payment timestamps, with **21.25%** of events near midnight
- **1,000** agent IDs with conflicting identity attributes
- **25** multi-attributed payments with **₹1,782,308.87** potential excess
  attributed recovery

Campaign, channel, agent, and vendor comparisons should therefore use
validated attribution and identity rules and should not be interpreted as
causal evidence without a controlled or quasi-experimental evaluation.