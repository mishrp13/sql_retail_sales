----SQL RETAILS SALES ANALYSIS -P1

create table sales_1(
transactions_id	 int primary key,
sale_date	date,
sale_time	time,
customer_id	int,
gender	varchar(15),
age	 int,
category varchar(15),	
quantity	int,
price_per_unit	float,
cogs	float,
total_sale float
)




select * from sales_1
where transactions_id is null
      or
	  sale_date is null
	  or
	  sale_time is null
	  or
	  gender is null
	  or
	  age is null
	  or 
	  category is null
	  or quantiy is null
	  or price_per_unit is null
	  or cogs is null
	  or total_sale is null


----Now deleting the null records


---Data cleaning

delete  sales_1
where  transactions_id is null
      or
	  sale_date is null
	  or
	  sale_time is null
	  or
	  gender is null
	  or
	  age is null
	  or 
	  category is null
	  or quantiy is null
	  or price_per_unit is null
	  or cogs is null
	  or total_sale is null


select * from sales_1

----Data Exploration

--How many salwes we have?

select count(1) as total_sale from sales_1

--How many unique customers we have?

select count(distinct customer_id) as total_sales from sales_1


--How many categories we have?

select count(distinct category) as Total_category from sales_1
select distinct category from sales_1

---Data Analysis , Business Key Problems and answers

--Q1 Write a SQL query to retrieve all columns for sales made on '2022-11-05**:


select * from sales_1
where (sale_date)='2022-11-05'


--Q2 Write a SQL query to retrieve all transactions where the category is 'Clothing' 
--and the quantity sold is more than 4 in the month of Nov-2022:

SELECT 
  *
FROM sales_1
WHERE 
    category = 'Clothing'
    AND 
    FORMAT(sale_date, 'yyyy-MM') = '2022-11'
    AND
    quantity >= 4;

--Q3> Write a SQL query to calculate the total sales (total_sale) for each category.:

select category,sum(total_sale) as [Total Sale],count(1) as total_orders
from sales_1
group by category

--Q4> Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

select category, Round(AVG(age),2) as [Average Age] from sales_1
where category='Beauty'
group by category

--Q5> Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * from sales_1
where total_sale>1000


--Q6> Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

select count(*) as total_transaction_count,gender,
category
from sales_1
group by category,gender
order by 3

--Q7> Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:


with cte as(
select  year(sale_date) as sale_year,
 month(sale_date) as sale_month ,
AVG(total_sale) as total_sales,
Rank() over(partition by year(sale_date) order by avg(total_sale) desc) as rnk
from sales_1
group by year(sale_date),month(sale_date)
)

select * from cte
where rnk=1


--Q8> **Write a SQL query to find the top 5 customers based on the highest total sales **
select top 5 customer_id,sum(total_sale) as Total_sales
from sales_1
group by customer_id
order by Total_sales desc

--Q9> Write a SQL query to find the number of unique customers who purchased items from each category.:

select count(distinct customer_id) as customer_Id,
category from sales_1
group by category

--Q10> Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

select * from sales_1



with cte as(
select * ,
case
    when DATEPART(Hour,sale_time) <12 then 'Morning'
	when DATEPART(Hour,sale_time) between 12 and 17 then 'Afternoon'
	else 'evening'
end as shift
from sales_1)


select shift,
count(*) as total_transactions
from cte
group by shift

















