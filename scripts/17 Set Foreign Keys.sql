-- Add foreign key for PromotionKey referencing DimPromotion
ALTER TABLE FactInternetSales
ADD CONSTRAINT FK_FactInternetSales_PromotionKey FOREIGN KEY (PromotionKey)
REFERENCES DimPromotion(PromotionKey);

-- Add foreign key for ProductKey referencing DimProduct
ALTER TABLE FactInternetSales
ADD CONSTRAINT FK_FactInternetSales_ProductKey FOREIGN KEY (ProductKey)
REFERENCES DimProduct(ProductKey);

-- Add foreign key for CustomerKey referencing DimCustomer
ALTER TABLE FactInternetSales
ADD CONSTRAINT FK_FactInternetSales_CustomerKey FOREIGN KEY (CustomerKey)
REFERENCES DimCustomer(CustomerKey);

-- Add foreign key for SalesPersonKey referencing DimEmployee
ALTER TABLE FactInternetSales
ADD CONSTRAINT FK_FactInternetSales_SalesPersonKey FOREIGN KEY (SalesPersonKey)
REFERENCES DimEmployee(EmployeeKey);

-- Add foreign key for BillingToAddressKey referencing DimGeography (through GeographyKey)
ALTER TABLE FactInternetSales
ADD CONSTRAINT FK_FactInternetSales_BillingToAddressKey FOREIGN KEY (BillingToAddressKey)
REFERENCES DimGeography(GeographyKey);

-- Add foreign key for ShippingToAddressKey referencing DimGeography (through GeographyKey)
ALTER TABLE FactInternetSales
ADD CONSTRAINT FK_FactInternetSales_ShippingToAddressKey FOREIGN KEY (ShippingToAddressKey)
REFERENCES DimGeography(GeographyKey);

-- Add foreign key for SalesTerritoryKey referencing DimSalesTerritory
ALTER TABLE FactInternetSales
ADD CONSTRAINT FK_FactInternetSales_SalesTerritoryKey FOREIGN KEY (SalesTerritoryKey)
REFERENCES DimSalesTerritory(SalesTerritoryKey);

-- Add foreign key for OrderDateKey referencing DimDate (through DateKey)
ALTER TABLE FactInternetSales
ADD CONSTRAINT FK_FactInternetSales_OrderDateKey FOREIGN KEY (OrderDateKey)
REFERENCES DimDate(DateKey);

-- Add foreign key for ShipDateKey referencing DimDate (through DateKey)
ALTER TABLE FactInternetSales
ADD CONSTRAINT FK_FactInternetSales_ShipDateKey FOREIGN KEY (ShipDateKey)
REFERENCES DimDate(DateKey);

-- Add foreign key for DueDateKey referencing DimDate (through DateKey)
ALTER TABLE FactInternetSales
ADD CONSTRAINT FK_FactInternetSales_DueDateKey FOREIGN KEY (DueDateKey)
REFERENCES DimDate(DateKey);
