-- Northwnd

CREATE DATABASE Northwnd

USE NORTHWND

-- CREATE CATEGORIES TABLE
CREATE TABLE Categories
(
	category_id INT IDENTITY PRIMARY KEY NOT NULL,
	category_name VARCHAR(20) NOT NULL,
	Description VARCHAR(200),
	picture VARBINARY(MAX)
)


-- CREATE SUPPLIERS TABLE
CREATE TABLE Suppliers
(	
	Supplier_id INT IDENTITY PRIMARY KEY NOT NULL,
	Company_name VARCHAR(50),
	Contact_name VARCHAR(50),
	Contact_title VARCHAR(50),
	Address VARCHAR(50),
	City VARCHAR(50),
	Religion VARCHAR(50),
	Postal_code VARCHAR(50),
	Country VARCHAR(50),
	Phone VARCHAR(50),
	Fax VARCHAR(50),
	Homepage VARBINARY(MAX)
)


-- CREATE PRODUCT TABLE
CREATE TABLE Products
(
	Product_id INT PRIMARY KEY NOT NULL,
	Product_name VARCHAR(50),
	Supplier_id INT FOREIGN KEY REFERENCES SUPPLIERS(SUPPLIER_ID),
	Category_id INT FOREIGN KEY REFERENCES CATEGORIES(CATEGORY_ID),
	Quantity_per_unit VARCHAR(50),
	Unit_price INT NOT NULL,
	Units_in_stock INT NULL,
	Units_in_order INT NULL,
	Reorder_level INT NULL,
	Discounted INT NULL
)

-- CREATE EMPLOYEES TABLE

CREATE TABLE Employees
(
	employee_id INT PRIMARY KEY NOT NULL,
	last_name VARCHAR(50),
	first_name VARCHAR(50),
	title VARCHAR(50),
	title_of_courtesy VARCHAR(50),
	birth_date DATE,
	hire_date DATE,
	address NVARCHAR(50),
	city NVARCHAR(50),
	region NVARCHAR(50),
	postal_code NVARCHAR(50),
	country VARCHAR(50),
	home_phone NVARCHAR(50),
	extension NVARCHAR(50),
	photo VARBINARY(MAX),
	notes VARCHAR(MAX) NULL,
	reports_to INT NULL,
	photo_path VARCHAR(50) NULL
)




-- CREATE EMPLOYEE TERRITORIES

CREATE TABLE employee_territories
(

	employee_id INT FOREIGN KEY REFERENCES EMPLOYEES(EMPLOYEE_ID) NOT NULL,
	territory_id NCHAR(10) FOREIGN KEY REFERENCES TERRITORIES(TERRITORY_ID) NOT NULL
)




---CREATE TERRITORIES TABLE

CREATE TABLE territories
(
	
	territory_id NCHAR(10) PRIMARY KEY NOT NULL,
	territory_description NVARCHAR(MAX),
	region_id INT FOREIGN KEY REFERENCES REGION(REGION_ID) NOT NULL
)


-- CREATE REGION TABLE
CREATE TABLE region
(
	region_id INT PRIMARY KEY NOT NULL,
	region_description NVARCHAR(MAX) NOT NULL
)


-- CREATE ORDERS TABLE
CREATE TABLE orders
(
	order_id INT PRIMARY KEY NOT NULL,
	customer_id NCHAR(15) FOREIGN KEY REFERENCES CUSTOMERS(CUSTOMER_ID),
	employee_id INT FOREIGN KEY REFERENCES EMPLOYEES(EMPLOYEE_ID),
	order_date DATE,
	required_date DATE,
	shipped_date DATE,
	ship_via INT NULL,
	freight DECIMAL(10,2),
	ship_name NVARCHAR(MAX),
	ship_address NVARCHAR(MAX),
	ship_city NVARCHAR(MAX),
	ship_region NVARCHAR(MAX),
	ship_postal_code NVARCHAR(MAX),
	ship_country NCHAR(50),
)


-- CREATE ORDER DETAILS
CREATE TABLE order_details
(
	order_id INT FOREIGN KEY REFERENCES ORDERS(ORDER_ID),
	product_id INT FOREIGN KEY REFERENCES PRODUCTS(PRODUCT_ID),
	unit_price DECIMAL NULL,
	quantity INT NULL,
	discount DECIMAL NULL
)

--  CREATE CUSTOMERS TBALE

CREATE TABLE customers
(
	customer_id NCHAR(15) PRIMARY KEY NOT NULL,
	company_name NVARCHAR(MAX),
	contact_name NCHAR(50),
	contact_title NCHAR(50),
	address NVARCHAR(MAX),
	city NVARCHAR(MAX),
	region NVARCHAR(MAX),
	postal_code NVARCHAR(MAX),
	country NCHAR(50),
	phone NVARCHAR(MAX),
	fax NVARCHAR(MAX)
)

-- CREATE CUSTOMER DEMOGRAPHIC TABLE
CREATE TABLE customer_demographics
(
	customer_type_id NCHAR(15) PRIMARY KEY NOT NULL,
	customer_desc NVARCHAR(MAX)
)


CREATE TABLE customer_customer_demo
(
	customer_id NCHAR(15) FOREIGN KEY REFERENCES CUSTOMERS(CUSTOMER_ID) NOT NULL,
	customer_type_id NCHAR(15) FOREIGN KEY REFERENCES CUSTOMER_DEMOGRAPHICS(CUSTOMER_TYPE_ID)
)


CREATE TABLE shippers
(
	shipper_id INT IDENTITY PRIMARY KEY NOT NULL,
	company_name NVARCHAR(MAX),
	phone NVARCHAR(MAX)
)

drop table shippers

CREATE TABLE US_states
(
	state_id INT PRIMARY KEY NOT NULL,
	state_name NCHAR(50),
	state_abbr NCHAR(10),
	state_region NVARCHAR(MAX)
)



INSERT INTO SUPPLIERS(company_name, contact_name, contact_title, address, city, religion, postal_code, country, phone, fax, homepage)
VALUES
		('Exotic Liquids', 'Charlotte Cooper', 'Purchasing Manager', '49 Gilbert St. ', 'London', NULL, 'EC1 4SD', 'UK', '(171) 555-2222', NULL, NULL),
		('New Orleans Cajun Delights', 'Shelley Burke', 'Order Administrator', 'P.O. Box 78934', 'New Orleans', 'LA', '70117', 'USA', '(100) 555-4822', NULL, '#CAJUN.HTM#'),
		('Grandma Kelly''s Homestead', 'Regina Murphy', 'Sales Representative', '707 Oxford Rd.', 'Ann Arbor', 'MI', '48104', 'USA', '(313) 555-5735', '(313) 555-3349', NULL),
		('Tokyo Traders', 'Yoshi Nagase', 'Marketing Manager', '9-8 Sekimai Musashino-shi', 'Tokyo', NULL, '100', 'Japan', '(03) 3555-5011', NULL, NULL),
		('Cooperativa de Quesos ''Las Cabras''', 'Antonio del Valle Saavedra', 'Export Administrator', 'Calle del Rosal 4', 'Oviedo', 'Asturias', '33007', 'Spain', '(98) 598 76 54', NULL, NULL),
	('Mayumi''s', 'Mayumi Ohno', 'Marketing Representative', '92 Setsuko Chuo-ku', 'Osaka', NULL, '545', 'Japan', '(06) 431-7877', NULL, 'Mayumi''s (on the World Wide Web)#http://www.microsoft.com/accessdev/sampleapps/mayumi.htm#'),
	('Pavlova, Ltd.', 'Ian Devling', 'Marketing Manager', '74 Rose St. Moonie Ponds', 'Melbourne', 'Victoria', '3058', 'Australia', '(03) 444-2343', '(03) 444-6588', NULL),
	('Specialty Biscuits, Ltd.', 'Peter Wilson', 'Sales Representative', '29 King''s Way', 'Manchester', NULL, 'M14 GSD', 'UK', '(161) 555-4448', NULL, NULL),
	('PB Kn ckebr d AB', 'Lars Peterson', 'Sales Agent', 'Kaloadagatan 13', 'G teborg', NULL, 'S-345 67', 'Sweden', '031-987 65 43', '031-987 65 91', NULL),
	( 'Refrescos Americanas LTDA', 'Carlos Diaz', 'Marketing Manager', 'Av. das Americanas 12.890', 'Sao Paulo', NULL, '5442', 'Brazil', '(11) 555 4640', NULL, NULL),
	( 'Heli S  waren GmbH & Co. KG', 'Petra Winkler', 'Sales Manager', 'Tiergartenstra e 5', 'Berlin', NULL, '10785', 'Germany', '(010) 9984510', NULL, NULL),
	( 'Plutzer Lebensmittelgro m rkte AG', 'Martin Bein', 'International Marketing Mgr.', 'Bogenallee 51', 'Frankfurt', NULL, '60439', 'Germany', '(069) 992755', NULL, 'Plutzer (on the World Wide Web)#http://www.microsoft.com/accessdev/sampleapps/plutzer.htm#'),
	( 'Nord-Ost-Fisch Handelsgesellschaft mbH', 'Sven Petersen', 'Coordinator Foreign Markets', 'Frahmredder 112a', 'Cuxhaven', NULL, '27478', 'Germany', '(04721) 8713', '(04721) 8714', NULL),
	( 'Formaggi Fortini s.r.l.', 'Elio Rossi', 'Sales Representative', 'Viale Dante, 75', 'Ravenna', NULL, '48100', 'Italy', '(0544) 60323', '(0544) 60603', '#FORMAGGI.HTM#'),
	( 'Norske Meierier', 'Beate Vileid', 'Marketing Manager', +'Hatlevegen 5', 'Sandvika', NULL, '1320', 'Norway', '(0)2-953010', NULL, NULL),
	( 'Bigfoot Breweries', 'Cheryl Saylor', 'Regional Account Rep.', '3400 - 8th Avenue Suite 210', 'Bend', 'OR', '97101', 'USA', '(503) 555-9931', NULL, NULL),
	( 'Svensk Sj f da AB', 'Michael Bj rn', 'Sales Representative', 'Brovallav gen 231', 'Stockholm', NULL, 'S-123 45', 'Sweden', '08-123 45 67', NULL, NULL),
	( 'Aux joyeux eccl siastiques', 'Guyl ne Nodier', 'Sales Manager', '203, Rue des Francs-Bourgeois', 'Paris', NULL, '75004', 'France', '(1) 03.83.00.68', '(1) 03.83.00.62', NULL),
	( 'New England Seafood Cannery', 'Robb Merchant', 'Wholesale Account Agent', 'Order Processing Dept. 2100 Paul Revere Blvd.', 'Boston', 'MA', '02134', 'USA', '(617) 555-3267', '(617) 555-3389', NULL),
	( 'Leka Trading', 'Chandra Leka', 'Owner', '471 Serangoon Loop, Suite #402', 'Singapore', NULL, '0512', 'Singapore', '555-8787', NULL, NULL),
	( 'Lyngbysild', 'Niels Petersen', 'Sales Manager', 'Lyngbysild Fiskebakken 10', 'Lyngby', NULL, '2800', 'Denmark', '43844108', '43844115', NULL),
	( 'Zaanse Snoepfabriek', 'Dirk Luchte', 'Accounting Manager', 'Verkoop Rijnweg 22', 'Zaandam', NULL, '9999 ZZ', 'Netherlands', '(12345) 1212', '(12345) 1210', NULL),
	( 'Karkki Oy', 'Anne Heikkonen', 'Product Manager', 'Valtakatu 12', 'Lappeenranta', NULL, '53120', 'Finland', '(953) 10956', NULL, NULL),
	( 'G''day, Mate', 'Wendy Mackenzie', 'Sales Representative', '170 Prince Edward Parade Hunter''s Hill', 'Sydney', 'NSW', '2042', 'Australia', '(02) 555-5914', '(02) 555-4873', 'G''day Mate (on the World Wide Web)#http://www.microsoft.com/accessdev/sampleapps/gdaymate.htm#'),
	( 'Ma Maison', 'Jean-Guy Lauzon', 'Marketing Manager', '2960 Rue St. Laurent', 'Montr al', 'Qu bec', 'H1J 1C3', 'Canada', '(514) 555-9022', NULL, NULL),
	( 'Pasta Buttini s.r.l.', 'Giovanni Giudici', 'Order Administrator', 'Via dei Gelsomini, 153', 'Salerno', NULL, '84100', 'Italy', '(089) 6547665', '(089) 6547667', NULL),
	( 'Escargots Nouveaux', 'Marie Delamare', 'Sales Manager', '22, rue H. Voiron', 'Montceau', NULL, '71300', 'France', '85.57.00.07', NULL, NULL),
	( 'Gai p turage', 'Eliane Noz', 'Sales Representative', 'Bat. B 3, rue des Alpes', 'Annecy', NULL, '74000', 'France', '38.76.98.06', '38.76.98.58', NULL),
	( 'For ts d'' rables', 'Chantal Goulet', 'Accounting Manager', '148 rue Chasseur', 'Ste-Hyacinthe', 'Qu bec', 'J2S 7S8', 'Canada', '(514) 555-2955', '(514) 555-2921', NULL)


INSERT INTO shippers(company_name, phone)
VALUES
		( 'Speedy Express', '(503) 555-9831'),
		( 'United Package', '(503) 555-3199'),
		( 'Federal Shipping', '(503) 555-9931'),
		( 'Alliance Shippers', '1-800-222-0451'),
		( 'UPS', '1-800-782-7892'),
		( 'DHL', '1-800-225-5345')


INSERT INTO US_states(state_id, state_name, state_abbr, state_region)
VALUES
		(1, 'Alabama', 'AL', 'south'),
	(2, 'Alaska', 'AK', 'north'),
	(3, 'Arizona', 'AZ', 'west'),
	(4, 'Arkansas', 'AR', 'south'),
	(5, 'California', 'CA', 'west'),
	(6, 'Colorado', 'CO', 'west'),
	(7, 'Connecticut', 'CT', 'east'),
	(8, 'Delaware', 'DE', 'east'),
	(9, 'District of Columbia', 'DC', 'east'),
	(10, 'Florida', 'FL', 'south'),
	(11, 'Georgia', 'GA', 'south'),
	(12, 'Hawaii', 'HI', 'west'),
	(13, 'Idaho', 'ID', 'midwest'),
	(14, 'Illinois', 'IL', 'midwest'),
	(15, 'Indiana', 'IN', 'midwest'),
	(16, 'Iowa', 'IO', 'midwest'),
	(17, 'Kansas', 'KS', 'midwest'),
	(18, 'Kentucky', 'KY', 'south'),
	(19, 'Louisiana', 'LA', 'south'),
	(20, 'Maine', 'ME', 'north'),
	(21, 'Maryland', 'MD', 'east'),
	(22, 'Massachusetts', 'MA', 'north'),
	(23, 'Michigan', 'MI', 'north'),
	(24, 'Minnesota', 'MN', 'north'),
	(25, 'Mississippi', 'MS', 'south'),
	(26, 'Missouri', 'MO', 'south'),
	(27, 'Montana', 'MT', 'west'),
	(28, 'Nebraska', 'NE', 'midwest'),
	(29, 'Nevada', 'NV', 'west'),
	(30, 'New Hampshire', 'NH', 'east'),
	(31, 'New Jersey', 'NJ', 'east'),
	(32, 'New Mexico', 'NM', 'west'),
	(33, 'New York', 'NY', 'east'),
	(34, 'North Carolina', 'NC', 'east'),
	(35, 'North Dakota', 'ND', 'midwest'),
	(36, 'Ohio', 'OH', 'midwest'),
	(37, 'Oklahoma', 'OK', 'midwest'),
	(38, 'Oregon', 'OR', 'west'),
	(39, 'Pennsylvania', 'PA', 'east'),
	(40, 'Rhode Island', 'RI', 'east'),
	(41, 'South Carolina', 'SC', 'east'),
	(42, 'South Dakota', 'SD', 'midwest'),
	(43, 'Tennessee', 'TN', 'midwest'),
	(44, 'Texas', 'TX', 'west'),
	(45, 'Utah', 'UT', 'west'),
	(46, 'Vermont', 'VT', 'east'),
	(47, 'Virginia', 'VA', 'east'),
	(48, 'Washington', 'WA', 'west'),
	(49, 'West Virginia', 'WV', 'south'),
	(50, 'Wisconsin', 'WI', 'midwest'),
	(51, 'Wyoming', 'WY', 'west')





ALTER TABLE SUPPLIERS
ALTER COLUMN Homepage NVARCHAR(250)

ALTER TABLE PRODUCTS
ALTER COLUMN Unit_price DECIMAL(10,2)






BULK INSERT  Categories
FROM 'C:\Users\bakin\OneDrive\Desktop\Data&Analyst\SQL\project\Categories.csv'
WITH
(
        FORMAT='CSV',
        FIRSTROW=2
		
)
GO


BULK INSERT  Products
FROM 'C:\Users\bakin\OneDrive\Desktop\Data&Analyst\SQL\project\Products.csv'
WITH
(
        FORMAT='CSV',
        FIRSTROW=2
)
GO


BULK INSERT  Employees
FROM 'C:\Users\mayow\OneDrive\Desktop\Data&Analyst\SQL\project\Employees.csv'
WITH
(
        FORMAT='CSV',
        FIRSTROW=2
)
GO


BULK INSERT  Employee_territories
FROM 'C:\Users\mayow\OneDrive\Desktop\Data&Analyst\SQL\project\EmployeeTerritories.csv'
WITH
(
        FORMAT='CSV',
        FIRSTROW=2
)
GO




BULK INSERT  territories
FROM 'C:\Users\mayow\OneDrive\Desktop\Data&Analyst\SQL\project\Territories.csv'
WITH
(
        FORMAT='CSV',
        FIRSTROW=2
)
GO


BULK INSERT  region
FROM 'C:\Users\mayow\OneDrive\Desktop\Data&Analyst\SQL\project\Region.csv'
WITH
(
        FORMAT='CSV',
        FIRSTROW=2
)
GO

BULK INSERT  orders
FROM 'C:\Users\mayow\OneDrive\Desktop\Data&Analyst\SQL\project\Orders.csv'
WITH
(
        FORMAT='CSV',
        FIRSTROW=2
)
GO


BULK INSERT  order_details
FROM 'C:\Users\mayow\OneDrive\Desktop\Data&Analyst\SQL\project\Order_details.csv'
WITH
(
        FORMAT='CSV',
        FIRSTROW=2
)
GO



BULK INSERT  customers
FROM 'C:\Users\mayow\OneDrive\Desktop\Data&Analyst\SQL\project\Customers.csv'
WITH
(
        FORMAT='CSV',
        FIRSTROW=2
)
GO



