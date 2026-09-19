WITH date_bounds AS 
(
    SELECT
        LEAST(
            MIN(order_purchase_ts),
            MIN(order_approved_ts),
            MIN(order_delivered_carrier_ts),
            MIN(order_delivered_customer_ts),
            MIN(order_estimated_delivery_ts)
        )::DATE - INTERVAL '30 days' AS min_date,
        GREATEST(
            MAX(order_purchase_ts),
            MAX(order_approved_ts),
            MAX(order_delivered_carrier_ts),
            MAX(order_delivered_customer_ts),
            MAX(order_estimated_delivery_ts)
        )::DATE + INTERVAL '90 days' AS max_date
    FROM {{ ref('stg_orders') }}
),

date_spine AS
(
    SELECT
        GENERATE_SERIES(
            (SELECT min_date FROM date_bounds),
            (SELECT max_date FROM date_bounds),
            '1 day'::INTERVAL
        )::DATE AS full_date
),

final AS
(
    SELECT
        TO_CHAR(full_date, 'YYYYMMDD')::INTEGER AS date_key,
        full_date,
        EXTRACT(YEAR FROM full_date) AS year,
        EXTRACT(MONTH FROM full_date) AS month,
        EXTRACT(DAY FROM full_date) AS day,
        EXTRACT(QUARTER FROM full_date) as quarter,
        EXTRACT(DOW FROM full_date) AS day_of_week,
        TO_CHAR(full_date, 'Day') AS day_name,
        TO_CHAR(full_date, 'Month') AS month_name,
        CASE WHEN EXTRACT(DOW FROM full_date) IN (0,6) THEN True ELSE False END AS is_weekend 
    FROM date_spine
)

SELECT *
FROM final