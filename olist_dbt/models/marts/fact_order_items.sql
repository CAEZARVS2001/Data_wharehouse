WITH source AS
(
    SELECT
        oi.order_id,
        oi.order_item_id,
        oi.product_id,
        oi.seller_id,
        s.seller_zip_code_prefix,
        o.customer_id,
        c.customer_zip_code_prefix,
        oi.price,
        oi.freight_value,
        oi.shipping_limit_date_ts,
        o.order_purchase_ts,
        o.order_approved_ts,
        o.order_delivered_carrier_ts,
        o.order_delivered_customer_ts,
        o.order_estimated_delivery_ts
    FROM {{  ref('stg_order_items')  }} AS oi
    LEFT JOIN {{ ref('stg_orders')  }} AS o
        ON oi.order_id = o.order_id
    LEFT JOIN {{  ref('stg_customers')  }} AS c
        ON o.customer_id = c.customer_id
    LEFT JOIN {{  ref('stg_sellers')  }} AS s
        ON oi.seller_id = s.seller_id
),

final AS
(
    SELECT
        order_id,
        order_item_id,
        product_id,
        seller_id,
        seller_zip_code_prefix,
        customer_id,
        customer_zip_code_prefix,
        price,
        freight_value,
        shipping_limit_date_ts,
        order_purchase_ts,
        TO_CHAR(order_purchase_ts::DATE, 'YYYYMMDD')::INTEGER AS purchase_date_key,
        TO_CHAR(order_approved_ts::DATE, 'YYYYMMDD')::INTEGER AS approved_date_key,
        TO_CHAR(order_delivered_carrier_ts::DATE, 'YYYYMMDD')::INTEGER AS delivered_carrier_date_key,
        TO_CHAR(order_delivered_customer_ts::DATE, 'YYYYMMDD')::INTEGER AS delivered_customer_date_key,
        TO_CHAR(order_estimated_delivery_ts::DATE, 'YYYYMMDD')::INTEGER AS estimated_delivery_date_key
    FROM source
)

SELECT *
FROM final