use sales_task;

select * from sales_data;
----------------------------

select distinct product
from sales_data;
----------------------------

select distinct category
from sales_data;

update sales_data
set category = case 
	when category = 'Bgas' then 'Bags'
	when category = 'Clohting' then 'Clothing'
	when category = 'Shoeses' then 'shoes'
	else category
end;

select distinct category
from sales_data;
----------------------------

select distinct price
from sales_data;

ALTER TABLE sales_data
ADD ID INT IDENTITY(1,1);

select *
from sales_data
where price is null;

select a.date, a.product, a.price, b.product, b.price, ISNULL(a.price, b.price)
from sales_data a left join sales_data b
on a.product = b.product 
	and a.ID <> B.ID
where a.price is null
group by a.date, a.product, a.price, b.product, b.price;

update a
set price = ISNULL(a.price, b.price)
from sales_data a left join sales_data b
on a.product = b.product 
	and a.ID <> B.ID
where a.price is null;

alter table sales_data
drop column ID;

select *
from sales_data;
----------------------------

select distinct quantity
from sales_data;

select * , revenue/price
from sales_data
where quantity is null;

update sales_data
set quantity = revenue / price
where quantity is null;
----------------------------

select distinct revenue
from sales_data;

select * , price * quantity
from sales_data
where revenue is null;

update sales_data
set revenue = price * quantity
where revenue is null;

select *
from sales_data;
----------------------------

select SUM(revenue) as total_revenue
from sales_data;

select top 1 product, SUM(revenue) as total_revenue
from sales_data
group by product
order by total_revenue desc;

with product_price_cte 
as (
select product, AVG(price) as avg_price
from sales_data
group by product
) 
select AVG(avg_price)
from product_price_cte;

select product, SUM(quantity) as total_quantity
from sales_data
group by product;

select SUM(quantity) as total_quantity
from sales_data;

select top 1 category, SUM(revenue) as total_revenue
from sales_data
group by category
order by total_revenue desc;

select AVG(revenue) as avg_revenue
from sales_data
order by avg_revenue desc;

select DATEPART(QUARTER, date) as sale_quarter, sum(revenue) as total_revenue
from sales_data
group by DATEPART(QUARTER, date);
