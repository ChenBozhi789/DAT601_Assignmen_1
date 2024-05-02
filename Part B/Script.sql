--1. 
SELECT * 
FROM dbo.Product
WHERE VendorID <> 'DLL01';

--2.
SELECT * 
FROM dbo.Product
WHERE ProductPrice BETWEEN $5.00 AND $10.00;

--3. 
SELECT *
FROM dbo.Product
WHERE VendorID IN ('DLL01', 'BRS01') AND ProductPrice > $10.00;

--4. 
SELECT AVG(ProductPrice) AS AveragePrice
FROM dbo.Product;

--5. 
SELECT COUNT(*) AS TotalCustNum
FROM dbo.Customer;

--6. 
SELECT COUNT(CustEmail) AS TotalCustEmailNum
FROM dbo.Customer;

--7.
SELECT COUNT(ProductID) AS Producttype 
	, MIN(ProductPrice) AS MinPrice
	, MAX(ProductPrice) AS MaxPrice
	, AVG(ProductPrice) AS AveragePrice
FROM dbo.Product;

--8.
SELECT dbo.Vendor.VendorName
	, dbo.Product.ProductPrice
	, dbo.Product.ProductName
FROM dbo.Product JOIN dbo.Vendor ON dbo.Product.VendorID = dbo.Vendor.VendorID;

--9.
SELECT dbo.Product.ProductName
	, dbo.Vendor.VendorName
	, dbo.Product.ProductPrice
	, dbo.OrderItem.Quantity
FROM dbo.Product 
	JOIN dbo.Vendor ON dbo.Product.VendorID = dbo.Vendor.VendorID
	JOIN dbo.OrderItem ON dbo.Product.ProductID = dbo.OrderItem.ProductID
WHERE dbo.OrderItem.OrderID = 20007;

--10.
SELECT OrderID FROM dbo.OrderItem WHERE ProductID = 'RGAN01';
(SELECT CustID FROM dbo.OrderEntry WHERE OrderID = 20007 OR OrderID = 20008);
(SELECT * FROM dbo.Customer WHERE CustID = 1000000004 OR CustID = 1000000005);

Nested sub queries
SELECT *
FROM dbo.Customer
WHERE CustID IN (
	SELECT CustID 
	FROM dbo.OrderEntry 
	WHERE OrderID IN (
		SELECT OrderID 
		FROM dbo.OrderItem 
		WHERE ProductID = 'RGAN01'
	) AND OrderID IN (20007, 20008)
);

--11.
SELECT CustName
	, CustCity
	, COUNT(dbo.OrderEntry.CustID) AS TotalNumOfOrder
FROM dbo.Customer
LEFT JOIN dbo.OrderEntry ON dbo.Customer.CustID = dbo.OrderEntry.CustID
GROUP BY CustName
	, CustCity
ORDER BY CustName;

--12.
SELECT CustName
	, CustContact
	, CustEmail
FROM dbo.Customer
WHERE CustCity = 'Nelson' OR CustCity = 'Wellington'
UNION
SELECT CustName
	, CustContact
	, CustEmail
FROM dbo.Customer
WHERE CustName = 'Fun4All'
ORDER BY dbo.Customer.CustName;

--13.
CREATE VIEW vProductCustomer AS
SELECT c.CustName
	, c.CustContact
	, o.OrderID
	, oi.ProductID
FROM dbo.Customer c
	JOIN dbo.OrderEntry o ON c.CustID = o.CustID
	JOIN dbo.OrderItem oi ON o.OrderID = oi.OrderID;

SELECT CustName
	, CustContact
FROM vProductCustomer
WHERE ProductID = 'RGAN01';

-- 14.
CREATE VIEW vCustomerMailingLabel AS 
SELECT CustName
	, CustID
	, CustAddress
FROM dbo.Customer

SELECT *
FROM vCustomerMailingLabel;