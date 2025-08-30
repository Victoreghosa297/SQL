Let me explain what’s happening in the script you uploaded (`Assignment 2.sql`) in simple terms.

The database here is called **Pizza**, and the queries explore different aspects of orders, pizzas, and customers.

**Step-by-Step Explanation**

1. **Database creation**

```sql
create database Pizza
```

This creates a new database called **Pizza** where all the tables and data will be stored.

---

2. **Basic Table Views**

```sql
select * from order_details
select * from orders
select * from pizza_types
select * from pizzas
```

These statements display all the records from each table, useful to check what’s inside.

---

3. **Orders sorted by date**

```sql
select * from orders
order by date asc
```

Retrieves all orders and sorts them from **earliest to latest**.

---

4. **Orders placed on or before June 30, 2015**

```sql
select * from orders 
where date <= '2015-06-30'
```

Filters orders up to a specific date.

---

5. **Orders between 3 PM and 7 PM**

```sql
select * from orders
where time between '15:00:00' and '19:00:00'
order by time desc
```

Finds all orders made between lunch and evening hours, sorted latest first.

---

6. **Orders with more than 2 pizzas**

```sql
select * from order_details
where quantity > 2
```

Shows only orders where customers bought more than two pizzas.

---

7. **Top 10 orders with the highest quantity**

```sql
SELECT TOP (10) [order_details_id], [order_id], [pizza_id], [quantity]
FROM [Pizza].[dbo].[order_details]
order by quantity desc
```

Lists the **top 10 order lines** with the largest pizza quantities.

---

8. **Total quantity of each pizza per order**

```sql
select order_id, pizza_id, sum(quantity) as Total_Quantity_Ordered
from order_details
group by order_id, pizza_id
order by sum(quantity) desc
```

Groups orders by pizza type and shows how many of each pizza was ordered.

---

9. **Average price by pizza size**

```sql
select size, avg(price) as Average_Price
from pizzas
group by size
order by avg(price) desc
```

Finds the average price of pizzas grouped by size (small, medium, large, etc.).

---

10. **Join: Orders + Order Details**

```sql
select order_details.order_id, order_details.pizza_id, order_details.quantity, orders.date, orders.time
from order_details
left join orders
on order_details.order_id = orders.order_id
```

Combines both tables so you can see details like **pizza ID, quantity, and order time** together.

---

11. **Join: Pizzas + Pizza Types**

```sql
select pizza_types.pizza_type_id, pizza_types.name, pizza_types.category, pizzas.size, pizzas.price
from pizzas
left join pizza_types
on pizzas.pizza_id  = pizza_types.pizza_type_id
```

Matches pizzas with their type (like “Veggie Pizza” or “Chicken Pizza”) and category (like Classic, Supreme, etc.).

---

12. **Orders placed during lunch hours (12 PM – 4 PM)**

```sql
where time between '12:00:00' and '16:00:00'
```

Filters lunch-time orders.

---

13. **Total revenue by pizza size**

```sql
select pizzas.size, (sum(pizzas.price) * sum(order_details.quantity)) as Revenue 
from pizzas
left join order_details
on pizzas.pizza_id = order_details.pizza_id
group by pizzas.size
order by Revenue desc
```

Calculates how much money each pizza **size** generated.

---

14. **Minimum and maximum price for each size**

```sql
select size, max(price) as Maximum_Price, min(price) as Minimum_Price
from pizzas
group by size
```

Shows the cheapest and most expensive pizza in each size category.

---

15. **Sort orders by order ID and quantity (top 10)**

```sql
select top(10) order_id, quantity
from order_details
order by quantity desc
```

Finds the 10 orders with the highest pizza quantities.

---

16. **Pizza sales and revenue analysis**

```sql
select a.pizza_id, count(a.pizza_id) as total_sales, (a.quantity * p.price) as total_revenue
from order_details as a
left join pizzas as p
on a.pizza_id = p.pizza_id
group by a.pizza_id, (a.quantity * p.price)
having count(a.pizza_id) > 20
order by (a.quantity * p.price) desc
```

* Counts how many times each pizza was sold.
* Calculates revenue (quantity × price).
* Only shows pizzas sold more than 20 times.
* Sorts results by highest revenue.

---

