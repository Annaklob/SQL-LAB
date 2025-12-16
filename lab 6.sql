DROP DATABASE IF EXISTS company;
CREATE DATABASE company;
USE company;

CREATE TABLE IF NOT EXISTS department (
  department_id INT NOT NULL AUTO_INCREMENT,
  department_name VARCHAR(30) NOT NULL UNIQUE,
  city VARCHAR(30) NOT NULL DEFAULT 'Lviv',
  street VARCHAR(50),                  
  building_no INT NOT NULL,                     
  PRIMARY KEY (department_id)
);

CREATE TABLE IF NOT EXISTS employee (
  employee_id INT NOT NULL AUTO_INCREMENT,
  user_name VARCHAR(50) NOT NULL UNIQUE,
  first_name VARCHAR(30) NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  position VARCHAR(50),
  employment_date DATE,
  department_id INT,          
  manager_id INT,
  rate DECIMAL(10,2) NOT NULL,
  bonus DECIMAL(10,2),
  PRIMARY KEY (employee_id)
);

CREATE TABLE IF NOT EXISTS customer (
  customer_id INT NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(30) NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  gender CHAR(1),
  birth_date DATE,
  phone_number VARCHAR(20) UNIQUE, 
  email VARCHAR(100) UNIQUE,
  discount INT,
  PRIMARY KEY (customer_id)
);

CREATE TABLE IF NOT EXISTS product (
  product_id INT NOT NULL AUTO_INCREMENT,
  product_name VARCHAR(100) NOT NULL,
  product_description VARCHAR(255),
  category VARCHAR(50),
  manufacture VARCHAR(50),
  product_type VARCHAR(50),
  amount INT,
  price DECIMAL(10,2),
  PRIMARY KEY (product_id)
);

CREATE TABLE IF NOT EXISTS invoice (
  invoice_id BIGINT NOT NULL,         
  employee_id INT,                      
  customer_id INT,                    
  payment_method TINYINT,
  transaction_moment DATETIME,
  status varchar(10) NOT NULL,
  PRIMARY KEY (invoice_id)
);

CREATE TABLE IF NOT EXISTS orders (
  orders_id INT NOT NULL AUTO_INCREMENT,
  invoice_id BIGINT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL,
  order_datetime DATETIME NOT NULL,   
  PRIMARY KEY (orders_id)
);

ALTER TABLE employee
  ADD CONSTRAINT fk_employee_department FOREIGN KEY (department_id) REFERENCES department(department_id),
  ADD CONSTRAINT fk_employee_manager FOREIGN KEY (manager_id) REFERENCES employee(employee_id);

ALTER TABLE invoice
  ADD CONSTRAINT fk_invoice_employee FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
  ADD CONSTRAINT fk_invoice_customer FOREIGN KEY (customer_id) REFERENCES customer(customer_id);

ALTER TABLE orders
  ADD CONSTRAINT fk_orders_invoice FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id),
  ADD CONSTRAINT fk_orders_product FOREIGN KEY (product_id) REFERENCES product(product_id);

INSERT INTO department (department_id, department_name, city, street, building_no) VALUES
(1,'Sales','Lviv','Shevchenka',10),
(2,'IT','Kyiv','Khreshchatyk',1),
(3,'HR','Odesa','Deribasivska',25),
(4,'Accounting','Lviv','Naukova',5),
(5,'Logistics','Dnipro','Centralna',7);

INSERT INTO employee (employee_id, user_name, first_name, last_name, position, employment_date, department_id, manager_id, rate, bonus) VALUES
(1,'ceo','Oleh','Koval','CEO','2015-02-10',2,NULL,100000.00,20000.00),
(2,'sales_manager','Iryna','Shevchenko','Sales Manager','2018-05-15',1,1,45000.00,8000.00),
(3,'seller1','Andrii','Melnyk','Seller','2020-09-01',1,2,30000.00,2000.00),
(4,'seller2','Yuliia','Bondar','Seller','2021-03-20',1,2,31000.00,NULL),
(5,'it_manager','Taras','Hnatiuk','IT Manager','2019-01-10',2,1,50000.00,6000.00),
(6,'dev1','Sofiia','Kravets','Developer','2022-06-05',2,5,38000.00,1500.00),
(7,'dev2','Mykola','Rudenko','Developer','2023-02-12',2,5,36000.00,NULL),
(8,'hr_manager','Olena','Vovk','HR Manager','2017-11-01',3,1,42000.00,5000.00),
(9,'recruiter','Daria','Polishchuk','Recruiter','2023-10-01',3,8,25000.00,500.00),
(10,'accountant','Nazar','Savchuk','Accountant','2021-07-07',4,11,29000.00,1200.00),
(11,'acc_manager','Mariia','Tkachenko','Chief Accountant','2016-04-01',4,1,47000.00,7000.00),
(12,'logistics','Ivan','Sydor','Logistics Specialist','2022-01-15',5,1,28000.00,NULL);

INSERT INTO customer (customer_id, first_name, last_name, gender, birth_date, phone_number, email, discount) VALUES
(1,'Svitlana','Oliinyk','F','1999-04-12','+380501111111','svitlana.oliinyk@mail.com',5),
(2,'Oksana','Klymenko','F','2001-08-02','+380502222222','oksana.klymenko@mail.com',10),
(3,'Dmytro','Kozak','M','1998-11-30','+380503333333','dmytro.kozak@mail.com',0),
(4,'Bohdan','Marchenko','M','1997-02-18','+380504444444','bohdan.marchenko@mail.com',7),
(5,'Iryna','Hrytsenko','F','2000-12-05','+380505555555','iryna.hrytsenko@mail.com',3),
(6,'Nadiia','Kovalchuk','F','1996-06-20','+380506666666','nadiia.kovalchuk@mail.com',12),
(7,'Serhii','Lysenko','M','1995-09-09','+380507777777','serhii.lysenko@mail.com',8),
(8,'Tetiana','Sakalo','F','2002-01-14','+380508888888','tetiana.sakalo@mail.com',5),
(9,'Roman','Ivashchenko','M','1994-03-03','+380509999999','roman.ivashchenko@mail.com',15),
(10,'Yana','Bilan','F','2003-07-27','+380501010101','yana.bilan@mail.com',0),
(11,'Viktor','Semenov','M','1993-10-10','+380502020202','viktor.semenov@mail.com',6),
(12,'Alina','Fedorchuk','F','2001-05-01','+380503030303','alina.fedorchuk@mail.com',9);

INSERT INTO product (product_id, product_name, product_description, category, manufacture, product_type, amount, price) VALUES
(1,'ACER - Nitro 5 AN515-57 /N57','Gaming notebook','Notebook','ACER','Devices',20,42000.00),
(2,'A4 - A4B318 BLOODY LIGHT STRIKE /E','Keyboard','Keyboard','A4','Devices',100,1200.00),
(3,'A4 - A4Tech X89 /X89','Mouse','Mouse','A4','Devices',120,800.00),
(4,'ADATA - XPG Spectrix D50 16GB /D50','RAM DDR4','RAM','ADATA','Hardware',60,2100.00),
(5,'AMD - Ryzen 7 5800X /5800X','CPU','CPUs','AMD','Hardware',40,9000.00),
(6,'Samsung - 970 EVO Plus 1TB /970E','SSD','SSD','Samsung','Hardware',50,3500.00),
(7,'Logitech - G102 Lightsync /G102','Mouse','Mouse','Logitech','Devices',80,1100.00),
(8,'HP - LaserJet Pro M404dn /M404','Printer','Printer','HP','Devices',15,11000.00),
(9,'Lenovo - ThinkPad E14 Gen 4 /E14','Business notebook','Notebook','Lenovo','Devices',25,36000.00),
(10,'Canon - EOS R50 Kit /R50','Camera','Camera','Canon','Devices',10,33000.00),
(11,'Apple - iPhone 15 Pro /A3102','Phone','Phone','Apple','Devices',12,55000.00),
(12,'Sony - WH-1000XM5 /XM5','Headphones','Headphones','Sony','Devices',18,15000.00);

INSERT INTO invoice (invoice_id, employee_id, customer_id, payment_method, transaction_moment, status) VALUES
(1000000001,3,1,1,'2025-01-05 11:10:00','PAID'),
(1000000002,3,2,2,'2025-01-10 15:40:00','PAID'),
(1000000003,3,3,1,'2025-01-18 10:05:00','PAID'),
(1000000004,3,4,1,'2025-02-02 13:20:00','PAID'),
(1000000005,3,5,2,'2025-02-15 09:55:00','PAID'),
(1000000006,3,6,1,'2025-02-26 18:30:00','PAID'),
(1000000007,3,7,2,'2025-03-03 12:00:00','PAID'),
(1000000008,3,8,1,'2025-03-11 16:10:00','PAID'),
(1000000009,3,9,2,'2025-03-25 14:45:00','PAID'),
(1000000010,3,10,1,'2025-04-06 11:15:00','PAID'),
(1000000011,3,11,2,'2025-04-17 19:05:00','PAID'),
(1000000012,3,12,1,'2025-04-29 10:25:00','PAID'),
(1000000013,4,1,1,'2025-05-04 13:33:00','PAID'),
(1000000014,4,2,2,'2025-05-19 17:20:00','PAID'),
(1000000015,2,3,1,'2025-06-01 09:10:00','PAID');

INSERT INTO orders (invoice_id, product_id, quantity, order_datetime) VALUES
(1000000001,2,2,'2025-01-05 11:10:00'),
(1000000001,3,1,'2025-01-05 11:10:00'),
(1000000002,1,1,'2025-01-10 15:40:00'),
(1000000003,6,2,'2025-01-18 10:05:00'),
(1000000004,11,1,'2025-02-02 13:20:00'),
(1000000005,9,1,'2025-02-15 09:55:00'),
(1000000006,5,2,'2025-02-26 18:30:00'),
(1000000007,2,5,'2025-03-03 12:00:00'),
(1000000008,10,1,'2025-03-11 16:10:00'),
(1000000009,11,1,'2025-03-25 14:45:00'),
(1000000010,1,1,'2025-04-06 11:15:00'),
(1000000011,8,2,'2025-04-17 19:05:00'),
(1000000012,4,6,'2025-04-29 10:25:00'),
(1000000013,7,3,'2025-05-04 13:33:00'),
(1000000014,12,2,'2025-05-19 17:20:00'),
(1000000015,11,1,'2025-06-01 09:10:00');

SELECT*FROM department;
SELECT*FROM employee;
SELECT*FROM customer;
SELECT*FROM product;
SELECT*FROM invoice;
SELECT*FROM orders;

SELECT
  LPAD(employee_id, 5, '0') AS `Employee ID`,
  CONCAT_WS(' ', last_name, first_name) AS `Full name`,
  LOWER(CONCAT(first_name, '.', last_name, '@company.com')) AS `email`
FROM employee;

SELECT
  first_name AS `First name`,
  last_name  AS `Last name`,
  DATE_FORMAT(employment_date, '%d %M %Y') AS `Date of hiring`,
  FORMAT(DATEDIFF(CURDATE(), employment_date) / 365.25, 1) AS `Length of service`,
  TIMESTAMPDIFF(YEAR, employment_date, CURDATE()) AS `Years of service`
FROM employee;

SELECT
  COUNT(*) AS `Count of all employees`,
  COUNT(bonus) AS `Count of employees who received bonus`
FROM employee;

SELECT
  MIN(rate) AS `Lowest salary`,
  MAX(rate) AS `Highest salary`
FROM employee;

SELECT
  FORMAT(AVG(bonus), 2) AS `Average bonus by Employee`
FROM employee
WHERE bonus IS NOT NULL;

SELECT
  FORMAT(AVG(IFNULL(bonus, 0)), 2) AS `Average bonus by Company`
FROM employee;

SELECT COUNT(*) AS `Count of offices`
FROM department;

SELECT COUNT(DISTINCT city) AS `Count of representative offices`
FROM department;

SELECT
  position AS `Position`,
  COUNT(*) AS `Count employees by position`
FROM employee
GROUP BY position
ORDER BY `Count employees by position` DESC, position;

SELECT
  d.department_id AS `Department ID`,
  d.department_name AS `Department`,
  COUNT(e.employee_id) AS `Count of employees`
FROM department d
LEFT JOIN employee e ON e.department_id = d.department_id
GROUP BY d.department_id, d.department_name
ORDER BY d.department_id;

SELECT
  d.department_id AS `Department ID`,
  d.department_name AS `Department`,
  e.position AS `Position`,
  COUNT(*) AS `Count employees by position for Department`
FROM employee e
JOIN department d ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name, e.position
ORDER BY d.department_id, e.position;

SELECT
  d.department_name AS `Department`,
  e.position AS `Position`,
  COUNT(*) AS `Count Employee by Position`
FROM employee e
JOIN department d ON e.department_id = d.department_id
WHERE d.city = 'Lviv'
GROUP BY d.department_name, e.position
HAVING COUNT(*) = 1
ORDER BY d.department_name, e.position;

SELECT
  d.department_name AS `Department`,
  e.last_name,
  e.first_name,
  e.position,
  COUNT(i.invoice_id) AS `Employee sales`
FROM employee e
JOIN department d ON d.department_id = e.department_id
JOIN invoice i ON i.employee_id = e.employee_id
WHERE d.department_name = 'Sales'
GROUP BY d.department_name, e.employee_id, e.last_name, e.first_name, e.position
HAVING COUNT(i.invoice_id) > 10
ORDER BY `Employee sales` DESC;

SELECT
  LPAD(product_id, 4, '0') AS `Product ID`,
  CONCAT(
    manufacture, ' :: ',
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(product_name, '/', 1), '-', -1))
  ) AS `Product Name`,
  UPPER(CONCAT(product_type, ' - ', category)) AS `Category`
FROM product
ORDER BY manufacture, product_id;

SELECT
  LPAD(MONTH(i.transaction_moment), 2, '0') AS `Month`,
  SUM(o.quantity * p.price) AS `Total revenue`,
  CONCAT('Quater ', QUARTER(i.transaction_moment), ' - ', YEAR(i.transaction_moment)) AS `Sales Period`
FROM invoice i
JOIN orders o ON o.invoice_id = i.invoice_id
JOIN product p ON p.product_id = o.product_id
WHERE i.status = 'PAID'
GROUP BY YEAR(i.transaction_moment), MONTH(i.transaction_moment), QUARTER(i.transaction_moment)
ORDER BY YEAR(i.transaction_moment), MONTH(i.transaction_moment);

SELECT
  LPAD(p.product_id, 4, '0') AS `Product ID`,
  p.product_name AS `Product`,
  SUM(o.quantity * p.price) AS `Total Amount`
FROM product p
JOIN orders o ON o.product_id = p.product_id
JOIN invoice i ON i.invoice_id = o.invoice_id
WHERE i.status = 'PAID'
GROUP BY p.product_id, p.product_name
HAVING SUM(o.quantity * p.price) > 50000
ORDER BY `Total Amount` DESC;

SELECT
  LPAD(c.customer_id, 4, '0') AS `Customer ID`,
  c.last_name AS `Customer last name`,
  c.first_name AS `Customer first name`,
  SUM(o.quantity * p.price) AS `Total Amount`
FROM customer c
JOIN invoice i ON i.customer_id = c.customer_id
JOIN orders o ON o.invoice_id = i.invoice_id
JOIN product p ON p.product_id = o.product_id
WHERE i.status = 'PAID'
GROUP BY c.customer_id, c.last_name, c.first_name
ORDER BY `Total Amount` DESC
LIMIT 10;