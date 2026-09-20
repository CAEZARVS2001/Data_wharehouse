WITH source AS
(
    SELECT 
        p.product_id AS product_id,
        COALESCE(p.product_category_name, 'sin_categoria') AS product_category_name,
        COALESCE(pc.product_category_name_english, 'unknown') AS product_category_name_english,
        p.product_weight_g AS product_weight_g,
        p.product_length_cm AS product_length_cm,
        p.product_height_cm AS product_height_cm, 
        p.product_width_cm AS product_width_cm
    FROM {{  ref('stg_products')  }} AS p
    LEFT JOIN {{ ref('stg_product_category_name_translation')  }} AS pc
        ON p.product_category_name = pc.product_category_name
),

final AS
(
    SELECT
        product_id,
        product_category_name,
        product_category_name_english,
        product_weight_g,
        product_length_cm,
        product_height_cm,
        product_width_cm,
        product_length_cm * product_height_cm * product_width_cm AS product_volume_cm3
    FROM source
)

SELECT *
FROM final