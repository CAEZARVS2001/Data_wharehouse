WITH source AS 
(
    SELECT *
    FROM {{  source('bronze', 'bronze_olist_geolocation_dataset')  }}
),

renamed AS
(
    SELECT
        geolocation_zip_code_prefix,
        ROUND(geolocation_lat::numeric, 4) AS geolocation_lat,
        ROUND(geolocation_lng::numeric, 4) AS geolocation_lng,
        TRIM(LOWER(geolocation_city)) AS geolocation_city,
        TRIM(UPPER(geolocation_state)) AS geolocation_state
    FROM source
)

SELECT *
FROM renamed