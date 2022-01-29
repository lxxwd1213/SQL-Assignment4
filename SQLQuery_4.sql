--10.
CREATE VIEW view_product_order_LI AS
    SELECT ProductName, Sum(Quantity) as TotalOrderedQuantity
    FROM Products p JOIN [Order Details] od On p.ProductID = od.ProductID
    GROUP BY ProductName
--11.
CREATE PROCEDURE sp_product_order_quantity_LI 
@ProductID int
AS
BEGIN
    SELECT Sum(Quantity) as TotalQuantities
    FROM [Order Details] od
    WHERE od.ProductID = @ProductID
END

EXEC dbo.sp_product_order_quantity_LI 1
--12.
CREATE PROCEDURE sp_product_order_city_LI
@ProductName VARCHAR
AS
BEGIN
    SELECT Top 5 sum(od.Quantity) as TotalQuantity, c.City
    FROM Products p JOIN [Order Details] od ON p.ProductID = od.ProductID JOIN Orders o ON od.OrderID = o.OrderID JOIN Customers c ON o.CustomerID = c.CustomerID
    WHERE p.ProductName = @ProductName
    GROUP BY c.City
    ORDER BY TotalQuantity DESC
END
EXEC dbo.sp_product_order_city_LI 'Chai'
--13.
CREATE TABLE people_LI(
    ID int PRIMARY KEY,
    NAMES VARCHAR(30) NOT NULL,
    CityID int REFERENCES city_LI(ID)
)
INSERT into people_LI VALUES ('1', 'Aaron Rodgers', '2')
INSERT into people_LI VALUES ('2', 'Russell Wilson', '1')
INSERT into people_LI VALUES ('3', 'Jody Nelson', '2')

SELECT *
FROM people_LI

CREATE TABLE city_LI(
    ID int PRIMARY KEY,
    City VARCHAR(20) NOT NULL,
)
INSERT INTO city_LI VALUES('1', 'Seattle')
INSERT INTO city_LI VALUES('2', 'Green Bay')

SELECT *
FROM city_LI

Update city_LI 
set City = 'Madison'
WHERE City = 'Seattle'

CREATE VIEW packers_XiaoxuLi AS
    SELECT [NAMES]
    FROM people_LI p JOIN city_LI c ON p.CityID = c.ID
    WHERE c.City = 'Green Bay'

Select *
FROM packers_XiaoxuLi

DROP table people_LI
DROP table city_LI
DROP view packers_XiaoxuLi
--14.
CREATE PROCEDURE sp_birthday_employees_LI AS
BEGIN
    CREATE TABLE birthday_employees_LI (EmployeeName VARCHAR(30))
    INSERT INTO birthday_employees_LI
        SELECT e.FirstName + ' ' + e.LastName AS EmployeeName
        FROM Employees e
        WHERE MONTH(e.BirthDate) = 2        
END

select *
FROM birthday_employees_LI

DROP table birthday_employees_LI

EXEC sp_birthday_employees_LI

select *
FROM Employees

select *
FROM birthday_employees_LI
--15.
CREATE TABLE od (OrderID int, ProductID int, UnitPrice Money, Quantity SMALLINT, Discount REAL)
INSERT into od VALUES ('10248', '1','14.00', '12', '0')

SELECT *
FROM [Order Details]
UNION
SELECT *
FROM od

