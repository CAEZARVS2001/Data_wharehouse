WITH source AS 
(
    SELECT *
    FROM {{  source('bronze', 'bronze_olist_customers_dataset')  }}
),

renamed AS
(
    SELECT
        customer_id,
        customer_unique_id,
        customer_zip_code_prefix,
        TRIM(LOWER(customer_city)) AS customer_city,
        TRIM(UPPER(customer_state)) AS customer_state
    FROM source
)

SELECT *
FROM renamed