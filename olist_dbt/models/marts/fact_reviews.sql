WITH source AS
(
    SELECT
        r.review_id,
        r.order_id,
        o.customer_id,
        TO_CHAR(r.review_creation_ts::DATE, 'YYYYMMDD')::INTEGER AS review_date_key,
        r.review_score,
        r.review_comment_title,
        r.review_comment_message,
        r.review_creation_ts,
        r.review_answer_ts
    FROM {{ ref('stg_order_reviews') }} AS r
    LEFT JOIN {{  ref('stg_orders')  }} AS o
        ON r.order_id = o.order_id
),

final AS
(
    SELECT
        review_id,
        order_id,
        customer_id,
        review_date_key,
        review_score,
        review_comment_title,
        review_comment_message,
        review_creation_ts,
        review_answer_ts
    FROM source
)

SELECT *
FROM final