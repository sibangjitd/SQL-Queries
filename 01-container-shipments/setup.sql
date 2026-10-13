-- Scenario 01: Port Container Tracker (SQL Server)
-- Run once. To restart cleanly: DROP TABLE Shipments

CREATE TABLE Shipments
(
    shipment_id   INT NOT NULL,
    container_no  VARCHAR(15) NOT NULL,
    origin_port   VARCHAR(30) NOT NULL,
    dest_port     VARCHAR(30) NOT NULL,
    carrier       VARCHAR(20) NOT NULL,
    cargo_type    VARCHAR(20),
    weight_kg     INT NOT NULL,
    freight_cost  DECIMAL(10,2) NOT NULL,
    status        VARCHAR(15),
    CONSTRAINT shipment_no PRIMARY KEY (shipment_id)
)

INSERT INTO Shipments
VALUES
    (1,'MSKU1001','Shanghai','Vancouver','Maersk','Electronics',18000,4200,'In Transit'),
    (2,'MSCU2002','Busan','Prince Rupert','MSC','Auto Parts',22000,3800,'Delivered'),
    (3,'CMAU3003','Shanghai','Vancouver','CMA CGM','Apparel',15000,3100,'Delayed'),
    (4,'MSKU4004','Mumbai','Vancouver','Maersk','Textiles',20000,3600,'Delivered'),
    (5,'ONEU5005','Ningbo','Prince Rupert','ONE','Electronics',17000,4000,'In Transit'),
    (6,'MSCU6006','Busan','Vancouver','MSC','Machinery',26000,5200,'Delayed'),
    (7,'CMAU7007','Mumbai','Prince Rupert','CMA CGM','Apparel',14000,2900,'Delivered'),
    (8,'MSKU8008','Shanghai','Prince Rupert','Maersk','Machinery',25000,5000,'In Transit')
