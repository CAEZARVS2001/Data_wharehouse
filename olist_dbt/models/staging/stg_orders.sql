WITH source AS (
    SELECT *
    FROM {{ source('bronze', 'bronze_olist_orders_dataset') }}
),

renamed AS (
    SELECT
        order_id,
        customer_id,
        order_status,
        CAST(order_purchase_timestamp AS TIMESTAMP) AS order_purchase_ts,
        CAST(order_approved_at AS TIMESTAMP) AS order_approved_at_ts,
        CAST(order_delivered_carrier_date AS TIMESTAMP) AS order_delivered_carrier_date_ts,
        CAST(order_delivered_customer_date AS TIMESTAMP) AS order_delivered_customer_date_ts,
        CAST(order_estimated_delivery_date AS TIMESTAMP) AS order_estimated_delivery_date_ts
    FROM source
    WHERE order_id IS NOT NULL
)

SELECT * 
FROM renamed