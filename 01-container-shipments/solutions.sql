-- Scenario 01: solutions (SQL Server). Run setup.sql first.

/* Q2: track expected arrival date */
ALTER TABLE Shipments
    ADD expected_arrival DATE

/* Q3: throwaway scratch table, then drop it */
CREATE TABLE carriers_temp
(
    carrier_id INT,
    carrier_name VARCHAR(20)
)

DROP TABLE carriers_temp

/* Q4: heavier than 20,000 kg */
SELECT *
FROM Shipments
WHERE weight_kg > 20000

/* Q5: Delayed shipments to Vancouver */
SELECT *
FROM Shipments
WHERE status = 'Delayed' AND dest_port = 'Vancouver'

/* Q6: from Shanghai or Busan */
SELECT *
FROM Shipments
WHERE origin_port IN ('Shanghai','Busan')

/* Q7: not delivered */
SELECT *
FROM Shipments
WHERE status != 'Delivered'

/* Q8: cost between 3,000 and 4,500 */
SELECT *
FROM Shipments
WHERE freight_cost BETWEEN 3000 AND 4500

/* Q9: Maersk or MSC */
SELECT *
FROM Shipments
WHERE carrier IN ('Maersk','MSC')

/* Q10: any other carrier */
SELECT *
FROM Shipments
WHERE carrier NOT IN ('Maersk','MSC')

/* Q11: container numbers beginning with MS */
SELECT *
FROM Shipments
WHERE container_no LIKE 'MS%'

/* Q12: cargo types ending with s */
SELECT *
FROM Shipments
WHERE cargo_type LIKE '%s'

/* Q13: distinct origin ports */
SELECT DISTINCT origin_port
FROM Shipments

/* Q14: total freight spend per carrier */
SELECT carrier,
       SUM(freight_cost) AS Total_freight
FROM Shipments
GROUP BY carrier

/* Q15: total weight per destination port, only above 40,000 kg */
SELECT dest_port,
       SUM(weight_kg) AS Total_weight
FROM Shipments
GROUP BY dest_port
HAVING SUM(weight_kg) > 40000

/* Q16: shipments per cargo type, most common first */
SELECT cargo_type,
       COUNT(shipment_id) AS Shipments_no
FROM Shipments
GROUP BY cargo_type
ORDER BY COUNT(shipment_id) DESC

/* Q17: two most expensive shipments */
SELECT TOP 2 *
FROM Shipments
ORDER BY freight_cost DESC

/* Q18: ignoring delivered, top 2 carriers by total freight cost */
SELECT TOP 2 carrier,
       SUM(freight_cost) AS Total_freight
FROM Shipments
WHERE status != 'Delivered'
GROUP BY carrier
ORDER BY SUM(freight_cost) DESC

/* Q19: add shipment 9 (10 columns including expected_arrival) */
INSERT INTO Shipments
VALUES (9,'MSC00112','Busan','Vancouver','MSC','Grocery',85000,12000,'In Transit',NULL)

/* Q20: CMAU3003 arrived */
UPDATE Shipments
SET status = 'Delivered'
WHERE container_no = 'CMAU3003'

/* Q21: Machinery rates up 10% */
UPDATE Shipments
SET freight_cost = freight_cost * 1.10
WHERE cargo_type = 'Machinery'

/* Q22: drop the Mumbai lane */
DELETE FROM Shipments
WHERE origin_port = 'Mumbai'

/* Q23: In Transit or Delayed only, top carrier by total cost, total above 5,000 */
SELECT TOP 1 carrier,
       SUM(freight_cost) AS Total_cost
FROM Shipments
WHERE status IN ('In Transit', 'Delayed')
GROUP BY carrier
HAVING SUM(freight_cost) > 5000
ORDER BY SUM(freight_cost) DESC
