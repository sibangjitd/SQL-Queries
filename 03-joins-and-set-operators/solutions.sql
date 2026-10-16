-- Scenario 03: solutions (SQL Server). Run setup.sql first.

/* Q1: every shipment with container number, carrier name and status */
SELECT
    s.container_no,
    c.carrier_name,
    s.status
FROM dbo.shipments AS s
    LEFT JOIN dbo.carriers AS c
        ON s.carrier_id = c.carrier_id

/* Q2: only shipments that have a carrier, with carrier name and home country */
SELECT
    s.shipment_id,
    c.carrier_name,
    c.home_country
FROM dbo.shipments AS s
    INNER JOIN dbo.carriers AS c
        ON s.carrier_id = c.carrier_id

/* Q3: carriers with no shipments at all */
SELECT
    c.carrier_id,
    c.carrier_name,
    s.container_no
FROM dbo.carriers AS c
    LEFT JOIN dbo.shipments AS s
        ON c.carrier_id = s.carrier_id
WHERE s.carrier_id IS NULL

/* Q4: container number with origin and destination port names */
SELECT
    s.container_no,
    op.port_name AS Origin,
    dp.port_name AS Destination
FROM dbo.shipments AS s
    LEFT JOIN dbo.ports AS op
        ON s.origin_port_id = op.port_id
    LEFT JOIN dbo.ports AS dp
        ON s.dest_port_id = dp.port_id

/* Q5: total freight per carrier, every carrier shown, zero if no shipments */
SELECT
    c.carrier_name,
    ISNULL(SUM(s.freight_cost), 0) AS Total_Freight
FROM dbo.carriers AS c
    LEFT JOIN dbo.shipments AS s
        ON c.carrier_id = s.carrier_id
GROUP BY c.carrier_name

/* Q6: destination ports with more than 4 shipments (with country) */
SELECT
    p.port_name,
    p.country,
    COUNT(s.shipment_id) AS Total_Shipments
FROM dbo.ports AS p
    LEFT JOIN dbo.shipments AS s
        ON p.port_id = s.dest_port_id
GROUP BY p.port_name, p.country
HAVING COUNT(s.shipment_id) > 4

/* Q7: ports never used as a destination */
SELECT
    p.port_name AS Destination_port
FROM dbo.ports AS p
    LEFT JOIN dbo.shipments AS s
        ON p.port_id = s.dest_port_id
WHERE s.dest_port_id IS NULL

/* Q8: each planner next to their manager's name (head of team still appears) */
SELECT
    l.emp_name AS Employee,
    r.emp_name AS Manager_Name
FROM dbo.planners AS l
    LEFT JOIN dbo.planners AS r
        ON l.manager_id = r.emp_id

/* Q9: every container booked in 2025 or 2026, no repeats */
SELECT
    b25.container_no
FROM dbo.bookings_2025 AS b25
UNION
SELECT
    b26.container_no
FROM dbo.bookings_2026 AS b26

/* Q10: all 2025 and 2026 bookings in one list, keeping every row */
SELECT
    b25.container_no
FROM dbo.bookings_2025 AS b25
UNION ALL
SELECT
    b26.container_no
FROM dbo.bookings_2026 AS b26

/* Q11: containers booked in both years */
SELECT
    b25.container_no
FROM dbo.bookings_2025 AS b25
INTERSECT
SELECT
    b26.container_no
FROM dbo.bookings_2026 AS b26

/* Q12: containers booked in 2025 but not in 2026 */
SELECT
    b25.container_no
FROM dbo.bookings_2025 AS b25
EXCEPT
SELECT
    b26.container_no
FROM dbo.bookings_2026 AS b26

/* Q13: containers booked in 2026 but not in 2025 */
SELECT
    b26.container_no
FROM dbo.bookings_2026 AS b26
EXCEPT
SELECT
    b25.container_no
FROM dbo.bookings_2025 AS b25

/* Q14: every carrier name from carriers and both booking tables, no repeats */
SELECT
    a.carrier_name
FROM dbo.bookings_2025 AS a
UNION
SELECT
    b.carrier_name
FROM dbo.bookings_2026 AS b
UNION
SELECT
    c.carrier_name
FROM dbo.carriers AS c

/* Q15: containers booked only in 2026, with current freight cost and status */
SELECT
    ex.container_no,
    s.freight_cost,
    s.status
FROM
(
    SELECT
        b26.container_no
    FROM dbo.bookings_2026 AS b26
    EXCEPT
    SELECT
        b25.container_no
    FROM dbo.bookings_2025 AS b25
) AS ex
LEFT JOIN dbo.shipments AS s
    ON ex.container_no = s.container_no

/* Q16: total freight per carrier plus an ALL CARRIERS total row */
SELECT
    c.carrier_name,
    ISNULL(SUM(s.freight_cost), 0) AS freight_cost
FROM dbo.carriers AS c
LEFT JOIN dbo.shipments AS s
    ON c.carrier_id = s.carrier_id
GROUP BY c.carrier_name
UNION ALL
SELECT
    'ALL CARRIERS',
    SUM(freight_cost)
FROM dbo.shipments
ORDER BY freight_cost ASC
