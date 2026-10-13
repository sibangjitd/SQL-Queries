# Scenario 01: Port Container Tracker

A freight forwarder moves containers from Asia to Vancouver and Prince Rupert. All work is in SQL Server syntax.

**Table: `shipments`**
`shipment_id` INT, `container_no` VARCHAR(15), `origin_port` VARCHAR(30), `dest_port` VARCHAR(30), `carrier` VARCHAR(20), `cargo_type` VARCHAR(20), `weight_kg` INT, `freight_cost` DECIMAL(10,2), `status` VARCHAR(15)

Files:
- `setup.sql` builds the table and loads the data
- `solutions.sql` has my answers to every question below

## Part 1: Setup
1. Build the `shipments` table from the spec above.
2. Ops wants an expected arrival date tracked per shipment. Make that possible.
3. Create a throwaway scratch table for testing, then get rid of it.

## Part 2: Finding shipments
4. Which shipments are heavier than 20,000 kg?
5. Which Delayed shipments are headed to Vancouver?
6. Which shipments left from Shanghai or Busan?
7. Which shipments have not been delivered?
8. Which shipments cost between 3,000 and 4,500 (limits included)?
9. Which shipments are handled by Maersk or MSC?
10. Which shipments are handled by any carrier other than those two?
11. Which container numbers begin with MS?
12. Which cargo types end with the letter s?

## Part 3: Summaries
13. Give me a clean list of origin ports, no repeats.
14. What is our total freight spend per carrier?
15. What is the total weight going to each destination port? Show only ports above 40,000 kg.
16. How many shipments do we have per cargo type, most common first?
17. What are the two most expensive shipments?
18. Ignoring delivered shipments, which two carriers have the highest total freight cost?

## Part 4: Changing the data
19. Add shipment 9 with values of your choice.
20. CMAU3003 just arrived. Update the record.
21. Machinery rates went up 10%. Reflect that.
22. We are dropping the Mumbai lane. Remove those shipments.

## Challenge
23. Looking only at shipments that are In Transit or Delayed, find the single carrier with the highest total cost, as long as that total is above 5,000.
