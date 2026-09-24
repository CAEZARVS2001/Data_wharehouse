WITH source AS
(
    SELECT
        p.order_id,
        p.payment_sequential,
        o.customer_id,
        TO_CHAR(o.order_purchase_ts::DATE, 'YYYYMMDD')::INT AS purchase_date_key,
        p.payment_type,
        p.payment_installments,
        p.payment_value
    FROM {{  ref('stg_order_payments')  }} AS p
    LEFT JOIN {{  ref('stg_orders')  }} AS o
        ON p.order_id = o.order_id
),

final AS
(
    SELECT  
        order_id,
        payment_sequential,
        customer_id,
        purchase_date_key,
        payment_type,
        payment_installments,
        payment_value
    FROM source
)

SELECT *
FROM final