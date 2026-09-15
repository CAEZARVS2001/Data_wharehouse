WITH source AS
(
    SELECT *
    FROM {{  source('bronze', 'bronze_olist_order_items_dataset')  }}
),

renamed AS
(
    SELECT
        order_id,
        order_item_id::INTEGER AS order_item_id,
        product_id,
        seller_id,
        shipping_limit_date::TIMESTAMP AS shipping_limit_date_ts,
        ROUND(price::NUMERIC, 2) AS price,
        ROUND(freight_value::NUMERIC, 2) AS freight_value
    FROM source
)

SELECT *
FROM renamed