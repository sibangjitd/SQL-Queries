-- Scenario 03: Container Network (SQL Server). Run once.

CREATE TABLE carriers (
    carrier_id INT PRIMARY KEY,
    carrier_name VARCHAR(20) NOT NULL,
    home_country VARCHAR(20)
)

CREATE TABLE ports (
    port_id INT PRIMARY KEY,
    port_name VARCHAR(30) NOT NULL,
    country VARCHAR(20)
)

CREATE TABLE shipments (
    shipment_id INT PRIMARY KEY,
    container_no VARCHAR(15) NOT NULL,
    carrier_id INT NULL,
    origin_port_id INT NOT NULL,
    dest_port_id INT NOT NULL,
    cargo_type VARCHAR(20),
    weight_kg INT,
    freight_cost DECIMAL(10,2),
    status VARCHAR(15)
)

CREATE TABLE bookings_2025 (container_no VARCHAR(15), carrier_name VARCHAR(20), cargo_type VARCHAR(20))
CREATE TABLE bookings_2026 (container_no VARCHAR(15), carrier_name VARCHAR(20), cargo_type VARCHAR(20))

CREATE TABLE planners (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(30),
    manager_id INT NULL
)

INSERT INTO carriers VALUES
(1,'Maersk','Denmark'),(2,'MSC','Switzerland'),(3,'CMA CGM','France'),
(4,'ONE','Japan'),(5,'Hapag-Lloyd','Germany')

INSERT INTO ports VALUES
(1,'Shanghai','China'),(2,'Busan','South Korea'),(3,'Mumbai','India'),
(4,'Ningbo','China'),(5,'Vancouver','Canada'),(6,'Prince Rupert','Canada'),
(7,'Singapore','Singapore')

INSERT INTO shipments VALUES
(1,'MSKU1001',1,1,5,'Electronics',18000,4200,'In Transit'),
(2,'MSCU2002',2,2,6,'Auto Parts',22000,3800,'Delivered'),
(3,'CMAU3003',3,1,5,'Apparel',15000,3100,'Delayed'),
(4,'MSKU4004',1,3,5,'Textiles',20000,3600,'Delivered'),
(5,'ONEU5005',4,4,6,'Electronics',17000,4000,'In Transit'),
(6,'MSCU6006',2,2,5,'Machinery',26000,5200,'Delayed'),
(7,'CMAU7007',3,3,6,'Apparel',14000,2900,'Delivered'),
(8,'MSKU8008',1,1,6,'Machinery',25000,5000,'In Transit'),
(9,'UNAS9009',NULL,4,5,'Grocery',12000,2500,'Delayed')

INSERT INTO bookings_2025 VALUES
('MSKU1001','Maersk','Electronics'),('MSCU2002','MSC','Auto Parts'),
('CMAU3003','CMA CGM','Apparel'),('ONEU5005','ONE','Electronics')

INSERT INTO bookings_2026 VALUES
('MSKU1001','Maersk','Electronics'),('CMAU3003','CMA CGM','Apparel'),
('MSKU8008','Maersk','Machinery'),('MSCU6006','MSC','Machinery')

INSERT INTO planners VALUES
(1,'Priya Nair',NULL),(2,'Arjun Mehta',1),(3,'Lena Fischer',1),
(4,'Tom Chen',2),(5,'Sara Khan',2),(6,'Mike Ross',3)
