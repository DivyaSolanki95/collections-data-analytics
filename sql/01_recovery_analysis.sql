/*
============================================================
COLLECTIONS DATA ANALYTICS ASSIGNMENT
SQL RECOVERY ANALYSIS

Purpose:
- Validate core recovery metrics
- Analyse successful payments
- Analyse recovery by DPD
- Analyse recovery by risk segment
- Support the 11% recovery claim investigation

Source:
Company-provided datasets

Important:
Metric definitions must remain consistent with the Python analysis.
============================================================
*/

  -- ============================================================
-- 0. DATA CLEANING / VALIDATION
-- ============================================================

-- 0.1 Payment records with missing critical identifiers

SELECT
    COUNT(*) AS missing_payment_id_records
FROM payments
WHERE payment_id IS NULL;


-- 0.2 Payment records with missing account identifiers

SELECT
    COUNT(*) AS missing_account_id_records
FROM payments
WHERE account_id IS NULL;


-- 0.3 Payments with invalid / missing amounts

SELECT
    COUNT(*) AS invalid_amount_records
FROM payments
WHERE amount IS NULL
   OR amount <= 0;


-- 0.4 Payment status distribution

SELECT
    payment_status,
    COUNT(*) AS record_count
FROM payments
GROUP BY payment_status
ORDER BY record_count DESC;


-- 0.5 Repeated payment references

SELECT
    payment_reference,
    COUNT(*) AS reference_count
FROM payments
WHERE payment_reference IS NOT NULL
GROUP BY payment_reference
HAVING COUNT(*) > 1
ORDER BY reference_count DESC;


-- 0.6 Exact duplicate payment rows

SELECT
    payment_id,
    account_id,
    payment_reference,
    event_at,
    amount,
    payment_status,
    COUNT(*) AS duplicate_row_count
FROM payments
GROUP BY
    payment_id,
    account_id,
    payment_reference,
    event_at,
    amount,
    payment_status
HAVING COUNT(*) > 1;

-- ============================================================
-- 0.7 STANDARDIZED PAYMENT TRANSFORMATION
-- ============================================================

SELECT
    payment_id,
    account_id,
    payment_reference,

    -- Standardized payment status
    UPPER(TRIM(payment_status)) AS payment_status_std,

    -- Standardized amount
    CAST(amount AS DECIMAL(18,2)) AS amount_std,

    -- Standardized event timestamp
    CAST(event_at AS DATETIME) AS event_at_std,

    -- Calendar month for recurring reporting
    DATE_FORMAT(
        CAST(event_at AS DATETIME),
        '%Y-%m'
    ) AS payment_month

FROM payments;


-- ============================================================
-- 0.8 DPD BUCKET TRANSFORMATION
-- ============================================================

SELECT
    account_id,
    dpd,
    outstanding_amount,
    risk_segment,

    CASE
        WHEN dpd <= 30 THEN '0-30'
        WHEN dpd <= 60 THEN '31-60'
        WHEN dpd <= 90 THEN '61-90'
        WHEN dpd <= 120 THEN '91-120'
        ELSE '120+'
    END AS dpd_bucket

FROM accounts;

-- ============================================================
-- 0.9 RECONCILED CORE RECOVERY METRIC
-- ============================================================

WITH successful_recovery AS (
    SELECT
        account_id,
        SUM(amount) AS recovered_amount
    FROM payments
    WHERE UPPER(TRIM(payment_status)) = 'SUCCESS'
    GROUP BY account_id
),

portfolio AS (
    SELECT
        COUNT(DISTINCT account_id) AS total_accounts,
        SUM(outstanding_amount) AS total_outstanding
    FROM accounts
)

SELECT
    portfolio.total_accounts,
    portfolio.total_outstanding,

    COALESCE(
        SUM(successful_recovery.recovered_amount),
        0
    ) AS recovered_amount,

    ROUND(
        COALESCE(
            SUM(successful_recovery.recovered_amount),
            0
        )
        / NULLIF(portfolio.total_outstanding, 0)
        * 100,
        2
    ) AS recovery_rate_pct

FROM portfolio
LEFT JOIN successful_recovery
    ON 1 = 1

GROUP BY
    portfolio.total_accounts,
    portfolio.total_outstanding;


    -- ============================================================
-- 0.10 REPORTED 11% CLAIM RECONCILIATION
-- ============================================================

WITH recovery AS (
    SELECT
        SUM(amount) AS recovered_amount
    FROM payments
    WHERE UPPER(TRIM(payment_status)) = 'SUCCESS'
),

portfolio AS (
    SELECT
        SUM(outstanding_amount) AS total_outstanding
    FROM accounts
)

SELECT
    11.00 AS reported_recovery_rate_pct,

    ROUND(
        recovery.recovered_amount
        / NULLIF(portfolio.total_outstanding, 0)
        * 100,
        2
    ) AS calculated_recovery_rate_pct,

    ROUND(
        (
            recovery.recovered_amount
            / NULLIF(portfolio.total_outstanding, 0)
            * 100
        ) - 11.00,
        2
    ) AS difference_percentage_points

FROM recovery
CROSS JOIN portfolio;

-- ============================================================
-- 1. TOTAL SUCCESSFUL RECOVERY
-- ============================================================

SELECT
    COUNT(DISTINCT payment_id) AS successful_payment_count,
    SUM(amount) AS recovered_amount
FROM payments
WHERE payment_status = 'SUCCESS';

-- ============================================================
-- 2. TOTAL OUTSTANDING PORTFOLIO
-- ============================================================

SELECT
    COUNT(DISTINCT account_id) AS total_accounts,
    SUM(outstanding_amount) AS total_outstanding
FROM accounts;

-- ============================================================
-- 3. CORE RECOVERY RATE
-- ============================================================

SELECT
    SUM(
        CASE
            WHEN p.payment_status = 'SUCCESS'
            THEN p.amount
            ELSE 0
        END
    ) AS recovered_amount,

    SUM(a.outstanding_amount) AS total_outstanding,

    ROUND(
        SUM(
            CASE
                WHEN p.payment_status = 'SUCCESS'
                THEN p.amount
                ELSE 0
            END
        )
        / NULLIF(SUM(a.outstanding_amount), 0)
        * 100,
        2
    ) AS recovery_rate_pct

FROM accounts a
LEFT JOIN (
    SELECT
        account_id,
        SUM(amount) AS amount
    FROM payments
    WHERE payment_status = 'SUCCESS'
    GROUP BY account_id
) p
    ON a.account_id = p.account_id;


    -- ============================================================
-- 4. RECOVERY BY DPD
-- ============================================================

SELECT
    CASE
        WHEN dpd <= 30 THEN '0-30'
        WHEN dpd <= 60 THEN '31-60'
        WHEN dpd <= 90 THEN '61-90'
        WHEN dpd <= 120 THEN '91-120'
        ELSE '120+'
    END AS dpd_bucket,

    COUNT(DISTINCT account_id) AS accounts,
    SUM(outstanding_amount) AS outstanding_amount

FROM accounts

GROUP BY
    CASE
        WHEN dpd <= 30 THEN '0-30'
        WHEN dpd <= 60 THEN '31-60'
        WHEN dpd <= 90 THEN '61-90'
        WHEN dpd <= 120 THEN '91-120'
        ELSE '120+'
    END

ORDER BY
    MIN(dpd);

    -- ============================================================
-- 5. SUCCESSFUL RECOVERY BY DPD
-- ============================================================

SELECT
    CASE
        WHEN a.dpd <= 30 THEN '0-30'
        WHEN a.dpd <= 60 THEN '31-60'
        WHEN a.dpd <= 90 THEN '61-90'
        WHEN a.dpd <= 120 THEN '91-120'
        ELSE '120+'
    END AS dpd_bucket,

    COUNT(DISTINCT p.payment_id) AS successful_payments,

    COUNT(DISTINCT p.account_id) AS paying_accounts,

    SUM(p.amount) AS recovered_amount

FROM payments p

INNER JOIN accounts a
    ON p.account_id = a.account_id

WHERE p.payment_status = 'SUCCESS'

GROUP BY
    CASE
        WHEN a.dpd <= 30 THEN '0-30'
        WHEN a.dpd <= 60 THEN '31-60'
        WHEN a.dpd <= 90 THEN '61-90'
        WHEN a.dpd <= 120 THEN '91-120'
        ELSE '120+'
    END;


    -- ============================================================
-- 6. RECOVERY BY RISK SEGMENT
-- ============================================================

SELECT
    a.risk_segment,

    COUNT(DISTINCT a.account_id) AS accounts,

    SUM(a.outstanding_amount) AS outstanding_amount,

    COUNT(DISTINCT p.payment_id) AS successful_payments,

    COUNT(DISTINCT p.account_id) AS paying_accounts,

    COALESCE(SUM(p.amount), 0) AS recovered_amount

FROM accounts a

LEFT JOIN payments p
    ON a.account_id = p.account_id
    AND p.payment_status = 'SUCCESS'

GROUP BY
    a.risk_segment

ORDER BY
    recovered_amount DESC;



    -- ============================================================
-- 7. MONTHLY SUCCESSFUL RECOVERY
-- ============================================================

SELECT
    DATE_FORMAT(event_at, '%Y-%m') AS payment_month,

    COUNT(DISTINCT payment_id) AS successful_payments,

    SUM(amount) AS recovered_amount

FROM payments

WHERE payment_status = 'SUCCESS'

GROUP BY
    DATE_FORMAT(event_at, '%Y-%m')

ORDER BY
    payment_month;

  