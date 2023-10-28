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

