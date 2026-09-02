# Executive Memo — Collections Performance Review

## Executive Summary

The business-reported claim that recovery has improved by 11% month-on-month is **not supported as a sustained improvement** by the supplied data.

Using the reconciled recovery definition, independently calculated recovery rate is **12.31%**, compared with the reported **11.00%**. Monthly recovery shows a rebound of approximately 11% in one period, but the broader trend does not establish a sustained month-on-month improvement.

Recovery also varies across DPD and risk segments, while campaign, channel, agent, and vendor performance show operational differences. These comparisons are observational and should not be interpreted as causal without controlling for portfolio mix and attribution.

## What Happened?

- Independently calculated recovery rate: **12.31%**
- Reported recovery rate: **11.00%**
- Variance: **+1.31 percentage points**
- Total recovered: **₹129.15 Cr**
- Total outstanding: **₹1,048.90 Cr**
- Total accounts: **30,000**
- Paying accounts: **13,109**
- PTP fulfillment rate: **7.09%**

The data supports a short-term recovery rebound, but not a reliable conclusion that recovery has continuously improved by 11% month-on-month.

## Why Did It Happen?

Several factors can influence the aggregate recovery result:

1. **Portfolio mix:** Recovery varies descriptively across DPD and risk segments. Statistical tests did not establish significant differences in successful-payment outcomes by risk segment (p = 0.468456) or DPD bucket (p = 0.091219).

2. **Campaign and channel differences:** Collection outcomes vary across campaigns and channels, but these are observational comparisons and do not establish causal effects.

3. **Operational variation:** Agent and vendor performance differs. However, **1,000 agent IDs have conflicting identity attributes**, requiring caution in agent-level comparisons.

4. **PTP conversion:** Recorded PTPs do not necessarily result in successful payments. The observed PTP fulfillment rate is only **7.09%**, so PTP outcomes should be validated against subsequent successful payments.

5. **Attribution limitations:** **25 payments** have multiple attribution records, creating a potential excess attributed recovery of **₹1,782,308.87**. Source-of-truth successful payments should therefore remain the primary recovery metric.

6. **Data-quality and timestamp limitations:** Payment timestamps are timezone-naive, with **21.25%** of payment events occurring near midnight. There are also **3,284 repeated payment references**, although **0 exact duplicate payment rows** were identified.

These findings indicate contributing factors and data limitations, not proof of causality.

## How Confident Are We?

**High confidence:** The reconciled recovery rate of **12.31%** is supported by the supplied payment and portfolio data.

**Strong evidence:** Differences exist across campaigns, channels, agents, and vendors, but these are observational comparisons.

**Statistical evidence:** Successful-payment outcomes were not statistically significantly different across risk segments or DPD buckets at the 5% significance level.

**Limited causal confidence:** The available observational data does not establish that any specific campaign, channel, agent, vendor, DPD bucket, or risk segment caused the observed recovery differences.

## Investment Recommendation

A **₹10 Cr investment** was evaluated using explicit downside, base, and upside recovery scenarios.

| Scenario | Incremental Recovery | Net Value After Investment | Simple ROI |
|---|---:|---:|---:|
| Downside | ₹5 Cr | -₹5 Cr | -50% |
| Base | ₹10 Cr | ₹0 | 0% |
| Upside | ₹15 Cr | +₹5 Cr | +50% |

The investment requires at least **₹10 Cr of incremental recovery to break even**.

Against the current **12.31% baseline recovery rate**, this corresponds to approximately **+0.95 percentage points** of recovery-rate lift, producing a break-even total recovery rate of approximately **13.27%**.

The base case therefore represents break-even rather than an attractive return. The available observational data does not provide sufficient evidence to assume the upside outcome will occur.

### Decision

**Do not approve the full ₹10 Cr investment unconditionally.**

Run a **controlled pilot or staged investment** and scale only if measured incremental recovery exceeds the **₹10 Cr break-even threshold** under a fixed attribution and evaluation framework.

## Key Assumptions

- The ₹10 Cr represents the full investment cost.
- Incremental recovery is measured against the reconciled baseline.
- Evaluation uses a fixed and documented attribution window.
- Incremental recovery is measured against a comparable control or baseline population.
- Downside, base, and upside scenarios are decision scenarios, not causal forecasts.

## Management Actions

Management should:

- Use the reconciled **12.31% recovery rate** consistently rather than relying on the reported 11% figure.
- Track recovery using consistent DPD and risk-segment cohorts.
- Compare campaigns using common targeting and attribution definitions.
- Use normalized productivity and recovery metrics for agent and vendor evaluation.
- Measure PTP fulfillment using independently matched payment outcomes.
- Maintain explicit data-quality flags and metric definitions.
- Evaluate the ₹10 Cr investment through a controlled pilot with predefined success and stop/scale criteria.