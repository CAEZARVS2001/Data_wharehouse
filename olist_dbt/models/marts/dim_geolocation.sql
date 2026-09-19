WITH source AS
(
    SELECT * 
    FROM {{  ref('stg_geolocation')  }}
),

final AS
(
    SELECT
        geolocation_zip_code_prefix,
        ROUND(AVG(geolocation_lat), 4) AS avg_lat,
        ROUND(AVG(geolocation_lng), 4) AS avg_lng,
        MODE() WITHIN GROUP(ORDER BY geolocation_city) AS geolocation_city,
        MODE() WITHIN GROUP(ORDER BY geolocation_state) AS geolocation_state
    FROM source
    GROUP BY geolocation_zip_code_prefix
)

SELECT *
FROM final