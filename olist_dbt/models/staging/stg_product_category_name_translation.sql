WITH source AS 
(
    SELECT *
    FROM {{  source('bronze', 'bronze_product_category_name_translation')  }}
),

renamed AS
(
    SELECT
        TRIM(LOWER(product_category_name)) AS product_category_name,
        TRIM(LOWER(product_category_name_english)) AS product_category_name_english
    FROM source
)

SELECT *
FROM renamed