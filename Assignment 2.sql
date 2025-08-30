create database Pizza

select * from order_details

select * from orders

select * from pizza_types

select * from pizzas

--Retrieve all columns from the orders table and sort the results by date in ascending order 
select * from orders
order by date asc

--Find all orders place on or before June 30
select * from orders 
where date <= '2015-06-30'

-- Identifying all orders where time is between 3pm and 7pm

select * from orders
where time between '15:00:00' and '19:00:00'
order by time desc

--Find all rows in order details where the quantity is greater than 2
select * from order_details
where quantity > 2

SELECT TOP (10) [order_details_id]
      ,[order_id]
      ,[pizza_id]
      ,[quantity]
  FROM [Pizza].[dbo].[order_details]
  order by quantity desc

select order_id, pizza_id, sum(quantity) as Total_Quantity_Ordered
from order_details
group by order_id, pizza_id
order by sum(quantity) desc

select * from pizzas

--
select size, avg(price) as Average_Price
from pizzas
group by size
order by avg(price) desc


--Join orders and order_details to retreive order_id, date, time, pizza_id, and quantity 

select * from order_details

select * from orders

select order_details.order_id, order_details.pizza_id, order_details.quantity, orders.date, orders.time
from order_details
left join orders
on order_details.order_id = orders.order_id

-- Join pizzas and pizza_types tables to list the name and category of each pizza 
select * from pizzas

select *from pizza_types

select pizza_types.pizza_type_id, pizza_types.name, pizza_types.category,pizzas.size, pizzas.price
from pizzas
left join pizza_types
on pizzas.pizza_id  = pizza_types.pizza_type_id

--Identify all orders placed during lunch hours on any date

select order_details.order_id, order_details.pizza_id, order_details.quantity, orders.date, orders.time
from order_details
left join orders
on order_details.order_id = orders.order_id
where time between '12:00:00' and '16:00:00'

--Group pizzas by size and calculate the total revenue (quantity * price ) generated for each size

select * from pizzas

select * from order_details


select pizzas.size, (sum(pizzas.price) * sum(order_details.quantity)) as Revenue 
from pizzas
left join order_details
on pizzas.pizza_id = order_details.pizza_id
group by pizzas.size
order by Revenue desc

--Determine the minimum and maximum price for each pizza size (size) in a single query 
select size, max(price) as Maximum_Price, min(price) as Minimum_Price
from pizzas
group by size

--Sort order details by order_id, and then by quantity in descending order, return the first 10 rows 

SELECT TOP (10) [order_details_id]
      ,[order_id]
      ,[pizza_id]
      ,[quantity]
  FROM [Pizza].[dbo].[order_details]

select * from order_details

select *from pizzas


select top(10) order_id, quantity
from order_details
order by quantity desc

--Retreive Pizza id and count the number of sales and calculate the total revenue for each pizza
-- include only pizza with more than 20 sales, and sort the results by total revenue in descending order 

select * from pizzas

select * from order_details

select a.pizza_id, count(a.pizza_id) as total_sales, (a.quantity * p.price) as total_revenue
from order_details as a
left join pizzas as p
on a.pizza_id = p.pizza_id
group by a.pizza_id, (a.quantity * p.price)
having count(a.pizza_id) > 20
order by (a.quantity * p.price) desc


