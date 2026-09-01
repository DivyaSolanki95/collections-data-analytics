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