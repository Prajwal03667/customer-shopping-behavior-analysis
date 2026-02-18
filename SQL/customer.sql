select gender, SUM(purchase_amount) as revenue
from customer
group by gender

select customer_id,purchase_amount from customer 
where discount_applied ='Yes' and purchase_amount >=(select avg(purchase_amount )from customer)

select item_purchased, ROUND(avg(review_rating::numeric),2) as "Average Product Rating"
from customer
group by item_purchased
order by avg(review_rating)desc
limit 5;

select shipping_type, 
ROUND(avg(purchase_amount),2)
from customer
where shipping_type in ('Standard','Express')
group by shipping_type

select subscription_status,
count(customer_id) as total_customer,
ROUND(AVG(purchase_amount),2) as avg_spend,
ROUND(SUM(purchase_amount),2) as total_revenue
from customer
group by subscription_status
order by total_revenue, avg_spend desc;

SELECT item_purchased,
ROUND(
    SUM(CASE WHEN discount_applied = 'Yes' THEN 1 ELSE 0 END)::numeric 
    / COUNT(*) * 100, 
    2
) AS discount_rate
FROM customer
GROUP BY item_purchased
ORDER BY discount_rate DESC
LIMIT 5;


WITH customer_type AS (
    SELECT customer_id,
           previous_purchases,
           CASE
               WHEN previous_purchases = 1 THEN 'New'
               WHEN previous_purchases BETWEEN 2 AND 10 THEN 'Returning'
               ELSE 'Loyal'
           END AS customer_segment
    FROM customer
)

SELECT *
FROM customer_type;
from customer)
select customer_segment, count(*) as "Number of Customers"
from customer_type
group by customer_segment


WITH item_counts AS (
    SELECT 
        category,
        item_purchased,
        COUNT(customer_id) AS total_orders,
        ROW_NUMBER() OVER (
            PARTITION BY category 
            ORDER BY COUNT(customer_id) DESC
        ) AS item_rank
    FROM customer
    GROUP BY category, item_purchased
)

SELECT 
    item_rank,
    category,
    item_purchased,
    total_orders
FROM item_counts
WHERE item_rank <= 3;


select subscription_status, count(customer_id)as
repeat_buyers
from customer
where previous_purchases >5
group by subscription_status

select age_group,
sum(purchase_amount) as total_revenue
from customer
group by age_group
order by total_revenue desc;