USE Northwnd

-- Retrieve all suppliers from the 'USA' whose city starts with 'N' or has 'O' in the second letter.

select Supplier_id, Company_name from Suppliers
where Country = 'USA' and (City like 'N%' or City like '_o%')

-- find all suppliers whose company name contains 'Liquids' or has 'o' in the third letter

select Supplier_id, Company_name from Suppliers
where Company_name like '%Liquids%' or Company_name like '__o%'

-- extract customer_id, address and phone where the phone number has open and close brackets and the address starts with C/

select customer_id, address, phone from customers
where phone like '%(%)%' and address like 'C/%'

-- suppliers whose contact name ends with 'i' or has 'a' in the third letter of their company name

select company_name, Contact_name from Suppliers
where Contact_name like '%i' or Company_name like'__a%'


-- retrieve suppliers whose city starts with 'M' or has 'Land' in their company name

select company_name from Suppliers
where City like 'M%' or company_name like '%Land%'

-- suppliers whose company_name contains 'Ltd' and the contact name contains 'a'

select company_name from Suppliers
where Contact_name like '%a%' and company_name like '%Ltd%'

-- suppliers with NULL fax numbers and whose company name contains 'Delights'

select * from Suppliers
where Fax is NULL and company_name like '%Delights%'

-- suppliers with not null postal codes and whose city contains 'er'

select * from Suppliers
where Postal_code is not NULL and City like '%er%'

-- suppliers with not null phone numbers and whose city starts with 'A'

select * from Suppliers
where Phone is not NULL and City like 'A%'

-- suppliers with null homepage and whose company name contains 'GmbH'

select *from Suppliers
where Homepage is null and Company_name like '%GmbH%'

--  extract company name and phone number for all customers whose phone numbers has open and close brackets

select company_name, phone from customers
where phone like '%(%)%'

-- extract customer details where phone number has more than one dot or the address starts with 'AV' 

select *from customers
where phone like '%.%.%' or address like 'AV%'


--------------------- -----------QUESTIONS ON LOGICAL OPERATOR USING ORDERS TABLE--------------------------------

-- For all Orders shipped from USA and shipvia is 1, extract all CustomerID, RequiredDate,ShippedDate,ShipCountry,
-- Freight, and ShipVia from orders for orders where Freight is 100 or more 

select  customer_id, required_date,shipped_date,ship_country, Freight, Ship_Via from orders
where freight >= 100 and ship_country = 'USA' and ship_via = 1


-- Extract all rows for all orders where the orderdate is after 1996 and Shipvia is not 1, and the freight is between 50 and 100

select *from orders
where freight between 50 and 100 and year(order_date) > 1996 and ship_via <> 1

-- How many orders shipped from USA from an address that starts with 187 were shipped before 1997?

select count(order_id) 
from orders 
	where ship_country = 'USA' and ship_address like '187%'
	and shipped_date < '1997-01-01'

-- How many orders shipped or ordered in 1997, excluding orders shipped from USA, Portugal or Ireland were not shipped via 3?

select count(order_id)
from orders
where order_date between '1997-01-01' and '1997-12-12'
	or (shipped_date between '1997-01-01' and '1997-12-12')
	and ship_country not in ('USA', 'Portugal', 'Ireland') 
	and ship_via != 3;

-- How many products are sold in bottles (use products table)

select count(product_id)
from Products
where Quantity_per_unit like '%bottles%'



---------------------------------------- PART THREE---------------------------------------------

-- Question 1: Retrieve the top 5 customers who have made the most orders. Include customer details and order counts. 

select top 5 c.customer_id, c.company_name, sum(od.quantity) as no_of_orders
from customers c
join orders o on o.customer_id = c.customer_id
join order_details od on od.order_id = o.order_id
group by c.customer_id, c.company_name
order by  no_of_orders desc



-- Question2: List the employees who have placed the most orders. Include employee details and order counts. 

select e.employee_id, e.first_name, count(o.order_id) as orders
from Employees e
join orders o on e.employee_id = o.employee_id
group by e.employee_id, e.first_name
order by orders desc

-- Question3: Retrieve all products and calculate the average price for each category. Show the category name, product name, and average price. 

select distinct c.category_name, p.product_name,  AVG(p.unit_price) as avg_price 
from Categories c 
inner join Products p on c.Category_id = p.Category_id
group by p.Product_name, c.category_name
order by c.category_name, avg_price 


-- Question4: List the top 3 customers who made the highest total purchases. Show customer details and total purchase amount.

select top 3 sum(od.quantity) as total_purchases, c.customer_id, c.company_name
from customers c 
join orders o on c.customer_id = o.customer_id
join order_details od on o.order_id = od.order_id
group by c.customer_id, c.company_name
order by  total_purchases desc

-- Question5: Calculate the rank of each product by price within its category. Show the product name, price, category, and rank. 

select p.product_name, p.unit_price, c.category_name,
	RANK() over (order by p.unit_price) as price_rank
from Products p
join Categories c on p.Category_id = c.category_id


-- Question6: List the employees and their orders in descending order of the number of orders placed. 

select e.first_name, e.last_name, count(o.order_id) as no_of_orders
from Employees e
join orders o on e.employee_id = o.employee_id
group by e.first_name, e.last_name
order by no_of_orders desc


-- Question7: Retrieve the product names and the number of orders they appear in. Show the most ordered products first. 

select p.Product_name, count(o.order_id) as no_of_orders
from Products p
join order_details od on p.Product_id = od.product_id
join orders o on od.order_id = o.order_id
group by p.Product_name
order by no_of_orders desc

-- Question8: Calculate the dense rank of products by price within their category. Show product name, price, category, and dense rank. 

select p.product_name, p.unit_price, c.category_name,
	DENSE_RANK() over (partition by c.category_name order by p.unit_price) as price_dense_hank
from Products p
join Categories c on p.Category_id = c.category_id


-- Question9: Calculate the row number for products within their category, ordered by price. Show product name, price, category, and row number. 

select p.product_name, p.unit_price, c.category_name,
	row_number() over (partition by c.category_name order by p.unit_price) as price_row_no
from Products p
join Categories c on p.Category_id = c.category_id

-- Question10: Create a stored procedure named GetOrderDetails that takes an OrderID as input and returns the details of that order.

create procedure GetOrderDetails
		@order_id int
as
begin
	select *from order_details where order_id = @order_id
end

exec GetOrderDetails @order_id = 10250


-- Question11: Create a stored procedure named GetEmployeeOrders that takes an EmployeeID as input and returns all orders placed by that employee. 

create procedure GetEmployeeOrders
		@employee_id int
as
begin
	select o.order_id, o.order_date, p.Product_name
	from orders o
	join Employees e on o.employee_id = o.employee_id
	join order_details od on o.order_id = od.order_id
	join Products p on od.product_id = od.product_id
	where e.employee_id = @employee_id
end

exec GetEmployeeOrders @employee_id = 5

-- Question12: Create a stored procedure named GetHighValueCustomers that returns a list of customers who have made purchases above a specified total purchase amount. 

create procedure GetHighValueCustomers
as
begin
	select c.company_name, sum(p.unit_price) as total_purchase
	from customers c
	join orders o on c.customer_id = o.customer_id
	join order_details od on o.order_id = od.order_id
	join Products p on od.product_id = p.Product_id
	group by c.company_name
	having sum(p.unit_price) > 300
	order by total_purchase
end

exec GetHighValueCustomers

-- Question13: Create a stored procedure named GetCategoryRevenue that takes a CategoryID as input and returns the total revenue for all products in that category.

create procedure GetCategoryRevenue 
	@category_id int
as
begin
	select sum(p.unit_price) as Total_revenue
	from Categories c
	join Products p on c.category_id = p.category_id
	where c.category_id = @category_id
	group by c.category_id
end

exec GetCategoryRevenue @category_id = 5

-- Question14: Create a stored procedure named GetProductSales that takes a ProductID as input and returns the total sales (revenue) for that product. 


create procedure GetProductSales
	@product_id int
as
begin
	select sum(p.unit_price) as Total_sales
	from Categories c
	join Products p on c.category_id = p.category_id
	where p.Product_id = @product_id
	group by p.Product_id
end

exec GetProductSales @product_id = 5

