--creates the database if it doesnt already exist
CREATE DATABASE IF NOT EXISTS Lincoln_Computer_Store;


--creates the staff table with the required datatypes if it doesnt already exist
CREATE TABLE IF NOT EXISTS Staff (
    Staff_Email varchar(255),
    Last_Name varchar(255),
    First_Name varchar(255) NOT NULL
    );

--creates the qualifications table with the required datatypes if it doesnt already exist
CREATE TABLE IF NOT EXISTS Qualifications (
    Staff_Email varchar(255),
    Staff_Qualifications varchar(255) NOT NULL
    );

--creates the service table with the required datatypes if it doesnt already exist
CREATE TABLE IF NOT EXISTS Service (
    Service_Name varchar(255),
    Service_Type varchar(255) NOT NULL,
    Item_Description varchar(255),
    Service varchar(255) NOT NULL,
    Price int
    );


--creates the customer table with the required datatypes if it doesnt already exist
CREATE TABLE IF NOT EXISTS Customer (
    Customer_Email varchar(255),
    First_Name varchar(255) NOT NULL,
    Last_Name varchar(255),
    House_No int NOT NULL,
    Postcode varchar(255) NOT NULL,
    City varchar(255) NOT NULL,
    County varchar(255) NOT NULL,
    Country varchar(255) NOT NULL,
    Age int
    );

--creates the order-table table with the required datatypes if it doesnt already exist
CREATE TABLE IF NOT EXISTS Order_Table (
    Customer_Email varchar(255),
    Order_DT datetime NOT NULL,
    Quantity int NOT NULL,
    Discount int NOT NULL,
    Staff_Email varchar(255) NOT NULL,
    Service_Name varchar(255) NOT NULL
    );


--thses alter the tables to be not null so they cant recieve a null value
ALTER TABLE staff MODIFY staff_email varchar(255) NOT NULL;
ALTER TABLE qualifications MODIFY staff_email varchar(255) NOT NULL;
ALTER TABLE service MODIFY service_name varchar(255) NOT NULL;
ALTER TABLE customer MODIFY customer_email varchar(255) NOT NULL;
ALTER TABLE order_table MODIFY order_dt datetime NOT NULL;
ALTER TABLE order_table MODIFY customer_email varchar(255) NOT NULL;

--alters the table to add primary and foreign keys
ALTER TABLE staff
ADD PRIMARY KEY (staff_email);

ALTER TABLE qualifications
ADD PRIMARY KEY (staff_email);

ALTER TABLE service
ADD PRIMARY KEY (service_name);

ALTER TABLE customer
ADD PRIMARY KEY (customer_email);

ALTER TABLE order_table
ADD PRIMARY KEY (order_dt);

ALTER TABLE order_table
ADD FOREIGN KEY (service_name) REFERENCES service(service_name);

ALTER TABLE order_table
ADD FOREIGN KEY (staff_email) REFERENCES staff(staff_email);

--creates unique indexs which speeds up queries
CREATE UNIQUE INDEX staff_index
on staff (staff_email);

CREATE UNIQUE INDEX qualification_index
on qualifications (staff_email);

CREATE UNIQUE INDEX service_index
on service (service_name);

CREATE UNIQUE INDEX customer_index
on customer (customer_email);

CREATE UNIQUE INDEX order_index
on order_table (order_dt);




--inserts the data into the selected tables

INSERT INTO staff
VALUES ('joebloggs12@gmail.com', 'Bloggs', 'Joe');

INSERT INTO staff
VALUES ('jefflynne83@hotmail.com', 'Lynne', 'Jeff');

INSERT INTO staff 
VALUES ('davecooper2@gmail.com', 'Cooper', 'Dave');

INSERT INTO staff
VALUES ('billystevens1995@gmail.com', 'Stevens', 'Billy');



INSERT INTO qualifications
VALUES ('joebloggs12@gmail.com', 'PhD');

INSERT INTO qualifications
VALUES ('jefflynne83@hotmail.com', 'MSc');

INSERT INTO qualifications
VALUES ('davecooper2@gmail.com', 'BSc');



INSERT INTO service
VALUES ('Keyboard repair', 'Maintenance', 'Keyboard repair and replace', 'Maintenance', 20);

INSERT INTO service
VALUES ('Mouse repair', 'Maintenance', 'Mouse repair and replace', 'Maintenance', 15);

INSERT INTO service
VALUES ('Graphics card', 'Stock purchase', 'Purchase of graphics card', 'Purchase', 450);



INSERT INTO customer
VALUES ('paulmaddens@gmail.com', 'Paul', 'Maddens', 45, 'LN1 1RE', 'Lincoln', 'Lincolnshire', 'United Kingdom', 48);

INSERT INTO customer
VALUES ('stevegrainger@gmail.com', 'Steve', 'Grainger', 12, 'LN2 8SH', 'Lincoln', 'Lincolnshire', 'United Kingdom', 32);

INSERT INTO customer
VALUES ('colinritman@gmail.com', 'Colin', 'Ritman', 67, 'LN4 7GR', 'North Hykeham', 'Lincolnshire', 'United Kingdom', 28);



INSERT INTO order_table
VALUES ('paulmaddens@gmail.com', '2018:08:22 09:35:23', 2, 50, 'joebloggs12@gmail.com', 'Graphics card');

INSERT INTO order_table
VALUES ('colinritman@gmail.com', '2019:01:03 13:10:23', 1, 5, 'jefflynne83@hotmail.com', 'Mouse repair');

INSERT INTO order_table
VALUES ('stevegrainger@gmail.com', '2018:04:13 11:12:45', 2, 7, 'davecooper2@gmail.com', 'Keyboard repair');

--These both update the data in their respective tables where the emails match a specific value

UPDATE staff
SET last_name = 'Stephenson', first_name = 'Alec'
WHERE staff_email = 'joebloggs12@gmail.com';

UPDATE customer
SET postcode = 'LE1 4GH', city = 'Leicester', county = 'Leicestershire'
WHERE customer_email = 'paulmaddens@gmail.com'

--This shows the deletion of data from specific tables where the data matches a unique value

DELETE FROM staff
WHERE staff_email = 'billystevens1995@gmail.com';

--This sets the value of the age to 1 for all of the new rows inputted if the age is left blank

ALTER TABLE customer
ALTER age SET DEFAULT '1';

--This sets the price to be 0 as a default value

ALTER TABLE service
ALTER price SET DEFAULT '0';


--inner join

SELECT staff.staff_email, qualifications.staff_qualifications
FROM staff
INNER JOIN qualifications ON staff.staff_email = qualifications.staff_email;


--left join

SELECT customer.first_name, customer.last_name, order_table.service_name
FROM customer
LEFT JOIN order_table ON customer.customer_email = order_table.customer_email
ORDER BY customer.last_name;

--right join to show the service and how far away it is, this will allow the staff to be able to add anymore cost onto the job.

SELECT order_table.service_name, customer.postcode, customer.city
FROM order_table
RIGHT JOIN customer
ON order_table.customer_email = customer.customer_email
ORDER BY order_table.customer_email;

--Union

SELECT customer_email FROM customer
UNION
SELECT staff_email FROM staff;







--copy all of the tables with copy_of_ prefix

CREATE TABLE IF NOT EXISTS copy_of_Staff LIKE staff;

CREATE TABLE IF NOT EXISTS copy_of_Qualifications LIKE qualifications;

CREATE TABLE IF NOT EXISTS copy_of_Service LIKE service;

CREATE TABLE IF NOT EXISTS copy_of_Customer LIKE customer

CREATE TABLE IF NOT EXISTS copy_of_Order_Table LIKE order_table


ALTER TABLE copy_of_staff MODIFY staff_email varchar(255) NOT NULL;
ALTER TABLE copy_of_qualifications MODIFY staff_email varchar(255) NOT NULL;
ALTER TABLE copy_of_service MODIFY service_name varchar(255) NOT NULL;
ALTER TABLE copy_of_customer MODIFY customer_email varchar(255) NOT NULL;
ALTER TABLE copy_of_order_table MODIFY order_dt datetime NOT NULL;
ALTER TABLE copy_of_order_table MODIFY customer_email varchar(255) NOT NULL;


ALTER TABLE copy_of_staff
ADD PRIMARY KEY (staff_email);

ALTER TABLE copy_of_qualifications
ADD PRIMARY KEY (staff_email);

ALTER TABLE copy_of_service
ADD PRIMARY KEY (service_name);

ALTER TABLE copy_of_customer
ADD PRIMARY KEY (customer_email);

ALTER TABLE copy_of_order_table
ADD PRIMARY KEY (order_dt);

ALTER TABLE copy_of_order_table
ADD FOREIGN KEY (service_name) REFERENCES service(service_name);

ALTER TABLE copy_of_order_table
ADD FOREIGN KEY (staff_email) REFERENCES copy_of_staff(staff_email);


CREATE UNIQUE INDEX staff_index
on copy_of_staff (staff_email);

CREATE UNIQUE INDEX qualification_index
on copy_of_qualifications (staff_email);

CREATE UNIQUE INDEX service_index
on copy_of_service (service_name);

CREATE UNIQUE INDEX customer_index
on copy_of_customer (customer_email);

CREATE UNIQUE INDEX order_index
on copy_of_order_table (order_dt);






INSERT INTO copy_of_staff
VALUES ('joebloggs12@gmail.com', 'Bloggs', 'Joe');

INSERT INTO copy_of_staff
VALUES ('jefflynne83@hotmail.com', 'Lynne', 'Jeff');

INSERT INTO copy_of_staff 
VALUES ('davecooper2@gmail.com', 'Cooper', 'Dave');

INSERT INTO copy_of_staff
VALUES ('billystevens1995@gmail.com', 'Stevens', 'Billy');



INSERT INTO copy_of_qualifications
VALUES ('joebloggs12@gmail.com', 'PhD');

INSERT INTO copy_of_qualifications
VALUES ('jefflynne83@hotmail.com', 'MSc');

INSERT INTO copy_of_qualifications
VALUES ('davecooper2@gmail.com', 'BSc');



INSERT INTO copy_of_service
VALUES ('Keyboard repair', 'Maintenance', 'Keyboard repair and replace', 'Maintenance', 20);

INSERT INTO copy_of_service
VALUES ('Mouse repair', 'Maintenance', 'Mouse repair and replace', 'Maintenance', 15);

INSERT INTO copy_of_service
VALUES ('Graphics card', 'Stock purchase', 'Purchase of graphics card', 'Purchase', 450);



INSERT INTO copy_of_customer
VALUES ('paulmaddens@gmail.com', 'Paul', 'Maddens', 45, 'LN1 1RE', 'Lincoln', 'Lincolnshire', 'United Kingdom', 48);

INSERT INTO copy_of_customer
VALUES ('stevegrainger@gmail.com', 'Steve', 'Grainger', 12, 'LN2 8SH', 'Lincoln', 'Lincolnshire', 'United Kingdom', 32);

INSERT INTO copy_of_customer
VALUES ('colinritman@gmail.com', 'Colin', 'Ritman', 67, 'LN4 7GR', 'North Hykeham', 'Lincolnshire', 'United Kingdom', 28);



INSERT INTO copy_of_order_table
VALUES ('paulmaddens@gmail.com', '2018:08:22 09:35:23', 2, 50, 'joebloggs12@gmail.com', 'Graphics card');

INSERT INTO copy_of_order_table
VALUES ('colinritman@gmail.com', '2019:01:03 13:10:23', 1, 5, 'jefflynne83@hotmail.com', 'Mouse repair');

INSERT INTO copy_of_order_table
VALUES ('stevegrainger@gmail.com', '2018:04:13 11:12:45', 2, 7, 'davecooper2@gmail.com', 'Keyboard repair');



--configure read permissions

GRANT SELECT ON Lincoln_Computer_Store.* TO 'Harry'@'%' IDENTIFIED by 'Xzdaa2DvbUsMrY5S'

--Revoking DROP priviledges from user 'Harry'

REVOKE DROP ON Lincoln_Computer_Store.* FROM 'Harry'@'localhost';