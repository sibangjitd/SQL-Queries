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
