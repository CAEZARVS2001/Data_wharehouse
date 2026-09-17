WITH source AS
(
    SELECT *
    FROM {{ source('bronze', 'bronze_olist_order_reviews_dataset') }}
),

renamed AS
(
    SELECT
        review_id,
        order_id,
        review_score::INTEGER AS review_score,
        TRIM(review_comment_title) AS review_comment_title,
        TRIM(review_comment_message) AS review_comment_message,
        review_creation_date::TIMESTAMP AS review_creation_date_ts,
        review_answer_timestamp::TIMESTAMP AS review_answer_ts
    FROM source
)

SELECT *
FROM renamed