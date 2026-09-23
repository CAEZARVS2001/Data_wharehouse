SELECT
    review_id,
    order_id,
    review_score,
    review_comment_title,
    review_comment_message,
    review_creation_ts,
    review_answer_ts
FROM {{ ref('stg_order_reviews') }}