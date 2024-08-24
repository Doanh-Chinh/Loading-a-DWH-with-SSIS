-- Truncate the fact table
TRUNCATE TABLE FactInternetSales;

-- Truncate the dimension tables
TRUNCATE TABLE DimPromotion;
TRUNCATE TABLE DimProduct;
TRUNCATE TABLE DimSalesTerritory;
TRUNCATE TABLE DimGeography;
TRUNCATE TABLE DimCustomer;
TRUNCATE TABLE DimEmployee;
TRUNCATE TABLE DimDate;

select * from FactInternetSales;