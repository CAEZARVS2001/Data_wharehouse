WITH source AS
(
    SELECT *
    FROM {{  source('bronze', 'bronze_olist_products_dataset')  }}
),

renamed AS
(
    SELECT
        product_id,
        TRIM(LOWER(product_category_name)) AS product_category_name,
        product_name_lenght::INTEGER AS product_name_length,
        product_description_lenght::INTEGER AS product_description_length,
        product_photos_qty::INTEGER AS product_photos_qty,
        product_weight_g::INTEGER AS product_weight_g,
        product_length_cm::INTEGER AS product_length_cm,
        product_height_cm::INTEGER AS product_height_cm,
        product_width_cm::INTEGER AS product_width_cm
    FROM source
)

SELECT *
FROM renamed