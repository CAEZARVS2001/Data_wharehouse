WITH source AS
(
    SELECT *
    FROM {{  source('bronze', 'bronze_olist_sellers_dataset')  }}
),

renamed AS
(
    SELECT
        seller_id,
        seller_zip_code_prefix,
        TRIM(LOWER(seller_city)) AS seller_city,
        TRIM(UPPER(seller_state)) AS seller_state
    FROM source
)

SELECT *
FROM renamed