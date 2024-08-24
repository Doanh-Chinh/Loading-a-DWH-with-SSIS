-- Set primary key for DimPromotion
ALTER TABLE DimPromotion
ADD CONSTRAINT PK_DimPromotion PRIMARY KEY (PromotionKey);

-- Set primary key for DimProduct
ALTER TABLE DimProduct
ADD CONSTRAINT PK_DimProduct PRIMARY KEY (ProductKey);

-- Set primary key for DimSalesTerritory
ALTER TABLE DimSalesTerritory
ADD CONSTRAINT PK_DimSalesTerritory PRIMARY KEY (SalesTerritoryKey);

-- Set primary key for DimGeography
ALTER TABLE DimGeography
ADD CONSTRAINT PK_DimGeography PRIMARY KEY (GeographyKey);

-- Set primary key for DimCustomer
ALTER TABLE DimCustomer
ADD CONSTRAINT PK_DimCustomer PRIMARY KEY (CustomerKey);

-- Set primary key for DimEmployee
ALTER TABLE DimEmployee
ADD CONSTRAINT PK_DimEmployee PRIMARY KEY (EmployeeKey);

-- Set primary key for DimDate
ALTER TABLE DimDate
ADD CONSTRAINT PK_DimDate PRIMARY KEY (DateKey);

-- Set composite primary key for FactInternetSales
ALTER TABLE FactInternetSales
ADD CONSTRAINT PK_FactInternetSales PRIMARY KEY (SalesOrderNumber, SalesOrderLineNumber);
