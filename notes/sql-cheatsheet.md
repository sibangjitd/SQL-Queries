# SQL Cheat Sheet

My own notes. SQL Server (T-SQL) syntax.

## Command types
**DDL (Data Definition Language)** - changes structure
- `CREATE` a table in a DB
- `DROP` a table in a DB
- `ALTER` a table in a DB

**DML (Data Manipulation Language)** - changes data
- `INSERT` new data in a table
- `DELETE` data in a table
- `UPDATE` data in a table

## Operators
| Type | Operators |
|------|-----------|
| Comparison | `=`, `!=` / `<>`, `>`, `>=`, `<`, `<=` |
| Logical | `AND`, `OR`, `NOT` |
| Range | `BETWEEN` (limits included) |
| Membership | `IN`, `NOT IN` (multiple values in a list) |
| Search | `LIKE` (with `%` wildcard) |

## Execution order vs coding order
| Execution order | Clause |
|-----------------|--------|
| 1 | `FROM` |
| 2 | `WHERE` (filters rows) |
| 3 | `GROUP BY` |
| 4 | `HAVING` (filters groups) |
| 5 | `SELECT DISTINCT` |
| 6 | `ORDER BY` |
| 7 | `TOP` |

Coding order is different: `SELECT DISTINCT ... TOP` is written first, then `FROM`, `WHERE`, `GROUP BY`, `HAVING`, `ORDER BY`.

## Gotchas I hit
- Text values need single quotes: `LIKE 'MS%'`
- `%` is modulo in math, not "percent". Write 10% as `0.10` or `* 1.10`
- Every column in `SELECT` with `GROUP BY` must be grouped or aggregated
- `ADD ... NOT NULL` fails on a table that already has rows (no default)
- `VARCHAR` with no size means 1 character. Always give a size
- `DROP TABLE` has no WHERE and no undo. `DROP COLUMN` removes one column inside `ALTER TABLE`
- `UPDATE` / `DELETE` without `WHERE` hits every row
- `DECIMAL(10,2)` means up to 10 digits in total, 2 of them after the decimal point (8 before, 2 after)
- An alias (`AS c`) only exists inside the one `SELECT` where you create it

## Joins (combine columns from different tables)
| Join | Keeps |
|------|-------|
| `INNER JOIN` | only rows with a match on both sides |
| `LEFT JOIN` | every row from the left table, NULL where the right has no match |
| `FULL JOIN` | every row from both sides |
| `CROSS JOIN` | every combination of rows (no `ON`) |

- Each `JOIN` gets its own `ON`. Write `ON a.id = b.id`, not `AND` / `OR` between joins
- Alias tables (`FROM dbo.carriers AS c`) and prefix every column (`c.carrier_name`)
- **Anti-join** (rows with no match): `LEFT JOIN ... WHERE right_table.key IS NULL`
- **Self join**: the same table twice under two aliases, e.g. employee and manager (`l.manager_id = r.emp_id`). Use `LEFT JOIN` so the top person with no manager still appears
- Joining the same lookup table twice (origin and destination port) needs two different aliases

## Set operators (combine rows from different queries)
| Operator | Result |
|----------|--------|
| `UNION` | all rows, duplicates removed |
| `UNION ALL` | all rows, duplicates kept (faster) |
| `INTERSECT` | rows that appear in both |
| `EXCEPT` | rows in the first query but not the second (order matters) |

- Both queries need the same number of columns with compatible types
- Select only the column you care about, because duplicates are judged on the whole row
- `ORDER BY` goes once, at the very end, and uses the column names from the first query
- To join onto an `EXCEPT` result, wrap it: `FROM (SELECT ... EXCEPT SELECT ...) AS ex LEFT JOIN ...`
- To add a total or label row to a report, `UNION ALL` a second `SELECT 'ALL CARRIERS', SUM(...)`. Never `INSERT` fake rows into a real table

## NULL handling
- Test with `IS NULL` / `IS NOT NULL`, never `= NULL`
- `ISNULL(expr, 0)` replaces NULL with a value. `COALESCE(a, b, c)` returns the first non-NULL and works on other databases too
- Wrap the aggregate: `ISNULL(SUM(x), 0)`, not a separate column

## Beginner questions I had
**Joins vs set operators: what is the difference?** Joins add columns side by side. Set operators stack rows on top of each other.

**Why can't I use an alias from one query in another?** Each `SELECT` is separate, and an alias only lives inside its own `SELECT`. After `UNION ALL` or `EXCEPT`, the second query needs its own `FROM` and names.

**Why does my left join still show unwanted rows?** A join only attaches columns. To drop rows, add a `WHERE`. A left join to a table does not remove anything by itself.

**UNION or UNION ALL?** `UNION` when you need duplicates removed. `UNION ALL` when you only want to stack rows, and it is faster.

**How do I add a total row to a report?** `UNION ALL` a second query with a text label and a `SUM`. Don't `INSERT`: it changes the real table and goes stale.

**Which result grid belongs to which query?** Put a comment label above each query and run one at a time by selecting it and pressing Execute. Name your output columns with `AS`.

**Can I use an aggregate in `WHERE`?** No. `WHERE` runs before `GROUP BY`. Filter aggregates with `HAVING`.

**What is a scratch or throwaway table?** A temporary table you create to test something and then `DROP`, so it never touches real data.
