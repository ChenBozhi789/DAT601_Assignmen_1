-- Create FK for OrderEntry Table
ALTER TABLE dbo.OrderEntry
ADD CONSTRAINT FK_OrderEntry_CustID
FOREIGN KEY (CustID)
REFERENCES dbo.Customer(CustID);

-- Create FK for OrderItem Table
ALTER TABLE dbo.OrderItem
ADD CONSTRAINT FK_OrderItem_OrderID
FOREIGN KEY (OrderID)
REFERENCES dbo.OrderEntry(OrderID);

ALTER TABLE dbo.OrderItem
ADD CONSTRAINT FK_OrderItem_ProductID
FOREIGN KEY (ProductID)
REFERENCES dbo.Product(ProductID);

-- Create FK for Product Table
ALTER TABLE dbo.Product
ADD CONSTRAINT FK_Product_VendorID
FOREIGN KEY (VendorID)
REFERENCES dbo.Vendor(VendorID);