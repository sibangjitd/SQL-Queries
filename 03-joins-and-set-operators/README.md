# Scenario 03: Container Network (joins and set operators)

SQL Server syntax. Run `setup.sql` once. Tables: `carriers`, `ports`, `shipments`, `bookings_2025`, `bookings_2026`, `planners`.

## Part A: Combining tables
1. Show every shipment with its container number, carrier name and status. Every shipment must appear, even if no carrier is assigned yet.
2. Show only shipments that have a carrier assigned, with the carrier name and the carrier's home country.
3. Which carriers have no shipments at all?
4. For each shipment show the container number, origin port name and destination port name.
5. Show total freight cost per carrier name. Every carrier must appear, and carriers with no shipments should show a total of zero.
6. Which destination ports (by name) received more than 4 shipments?
7. Which ports have never been used as a destination?
8. Show each planner next to their manager's name. The head of the team has no manager but must still appear.

## Part B: Stacking results
9. Give me one list of every container booked in 2025 or 2026, no repeats.
10. Put all the 2025 bookings and all the 2026 bookings into one list, keeping every row. If a container was booked in both years, it should show up twice. How many rows does the combined list have?
11. Which containers were booked in both years?
12. Which containers were booked in 2025 but not in 2026?
13. Which containers were booked in 2026 but not in 2025?
14. Give me a single list of every carrier name we know about, from the carriers table and from the booking records, no repeats.

## Challenge
15. For containers booked only in 2026 (not 2025), show their current freight cost and status from the shipments table.
16. One report: total freight cost per carrier, with a final extra row labelled ALL CARRIERS showing the overall total.
