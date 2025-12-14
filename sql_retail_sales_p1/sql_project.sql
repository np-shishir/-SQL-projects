/*SQL Retail sales analysis*/
create database if not exists sql_project1;
use sql_project1;

create table if not exists retail_sales(
	transactions_id	int primary key,
	sale_date date,
    sale_time time,
    customer_id	int,
    gender varchar(15),
    age	int,
    category varchar(20),
    quantiy	int,
    price_per_unit float,
    cogs float,
    total_sale float
);






/*data exploration*/
SELECT *
FROM retail_sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantiy IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
   
/*data cleaning*/
delete from retail_sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantiy IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;

/*Total sales*/
select count(*) as total_sale from retail_sales;
/*no. of data*/
select count(*) from retail_sales;
/*-basic overview of type of data*/
select * from retail_sales limit 10;
/*no. of distinct customers*/
select count(distinct customer_id) from retail_sales;
/*no. of categories*/
select distinct category, count(distinct category) 
from retail_sales group by category;


/*Q.1 all sales made on '2022-11-05'*/
select * from retail_sales 
where sale_date ='2022-11-05';



/*Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing'
 and the quantity sold is more than 4 in the month of Nov-2022*/
 select * from retail_sales
 where category='Clothing' and 
 quantiy>=4 and 
 sale_date between '2022-11-01' and '2022-11-30';
 
 
 /*Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.*/
 select category, sum(total_sale) as net_sales, count(*) as total_orders
 from retail_sales
 group by category;
 
 
 /*Q.4 Write a SQL query to find the average age of customers
 who purchased items from the 'Beauty' category.*/
 select category, round(avg(age), 2) as average_age
 from retail_sales
 where category='Beauty';
 
 
 /*Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.*/
select * from retail_sales
where total_sale>1000;


/*Q.6 Write a SQL query to find the total number of transactions (transaction_id)
made by each gender in each category.*/
select category, gender, count(*) as total_trans
from retail_sales
group by category, gender
order by category;

/*IMP*/
/*Q.7 Write a SQL query to calculate the average sale for each month. 
Find out best selling month in each year*/
/*requires WINDOW FUNCTION*/
select year(sale_date) as year, 
month(sale_date) as month, 
round(avg(total_sale),2) as average_sales
from retail_sales
group by year, month
order by year, month;


/*Q.8 Write a SQL query to find the top 5 customers based on the highest total sales */
select customer_id, sum(total_sale) as total_sales
from retail_sales
group by customer_id
order by total_sales desc
limit 5;


/*Q.9 Write a SQL query to find the number of unique customers
 who purchased items from each category.*/
 select category, count(distinct customer_id) as unique_customers
 from retail_sales
 group by category
 order by unique_customers desc;
 
 
 
 /*Q.10 Write a SQL query to create each shift and number of orders 
 (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)*/
 
 with hourly_sale as
 (
 select *,
	case
		when hour(sale_time)<12 then 'Morning'
        when hour(sale_time) between 12 and 17 then 'Afternoon'
        else 'Evening'
	end as shift
from retail_sales
)
select shift, count(*) as total_orders
 from hourly_sale
group by shift;