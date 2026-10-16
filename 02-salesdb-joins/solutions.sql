-- Scenario 02: SalesDB joins (SQL Server)
USE SalesDB

/* Q1: all orders with customer, product and employee details */
SELECT
    so.OrderID,
    sc.FirstName AS Cx_FirstName,
    sc.LastName  AS Cx_LastName,
    sp.Product,
    so.Sales,
    sp.Price,
    se.FirstName AS Emp_FirstName,
    se.LastName  AS Emp_LastName
FROM sales.Orders AS so
    LEFT JOIN sales.Customers AS sc
        ON so.CustomerID = sc.CustomerID
    LEFT JOIN sales.Products AS sp
        ON so.ProductID = sp.ProductID
    LEFT JOIN sales.Employees AS se
        ON so.SalesPersonID = se.EmployeeID
