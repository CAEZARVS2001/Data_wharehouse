WITH source AS
(
    SELECT *
    FROM {{  source('bronze', 'bronze_olist_order_payments_dataset')  }}
),

renamed AS
(
    SELECT
        order_id,
        payment_sequential::INTEGER AS payment_sequential,
        payment_type,
        payment_installments::INTEGER AS payment_installments,
        ROUND(payment_value::NUMERIC, 2) AS payment_value
    FROM source
)

SELECT *
FROM renamed