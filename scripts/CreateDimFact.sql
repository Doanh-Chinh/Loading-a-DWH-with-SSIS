-- Create a database
CREATE DATABASE DWH_Demo_AdventureW
GO
-- Switch to the new database
USE DWH_Demo_AdventureW
Go


-- DimCustomer
-- drop table DimCustomer
CREATE TABLE [DimCustomer] (
	[CustomerKey] [int] IDENTITY(1,1) NOT NULL,
    [CustomerAK] int NOT NULL,  -- CustomerID
    [Title] nchar(10),
    [FirstName] nvarchar(50),
    [MiddleName] nvarchar(50),
    [LastName] nvarchar(50),
    [Suffix] nchar(10),
    [EmailAddress] nvarchar(50),
	[ExpirationDate] datetime,
	[LoadDate] datetime

)
-- DimProduct
CREATE TABLE [DimProduct] (
	[ProductKey] [int] identity(1,1) not null,
	ProductAK int not null, --ProductID
    [ProductName] nvarchar(50),
	[ProductNumber] nvarchar(25),
	ProductSubCategoryName nvarchar(50),
	ProductCategoryName nvarchar(50),
    [FinishedGoodsFlag] bit,
    [Color] nvarchar(15),
    [StandardCost] money,
    [ListPrice] money,
    [Size] nvarchar(5),
    [ProductLine] nvarchar(2),
    [Class] nvarchar(2),
    [Style] nvarchar(2),
    [ProductModelName] nvarchar(50),
    [SellStartDate] datetime,
    [SellEndDate] datetime
)

-- DimPromotion
CREATE TABLE [DimPromotion] (
	PromotionKey int identity(1,1) not null,
    [PromotionAK] int,  -- SpecialOfferID
    [PromotionName] nvarchar(255), -- Description
    [DiscountPercentage] money, -- DiscountPct
    [PromotionType] nvarchar(50), -- Type
	[PromotionCategory] nvarchar(50),
    [PromotionStartDate] datetime,
    [PromotionEndDate] datetime,
    [MinQty] int,
    [MaxQty] int
)

--DimSalesTerritory
CREATE TABLE [DimSalesTerritory] (
	[SalesTerritoryKey] int identity(1,1) not null,
    [SalesTerritoryAK] int,  -- TerritoryID
    [SalesTerritoryName] nvarchar(50),
    [SalesCoutryRegionCode] nvarchar(50),
	[SalesCountryRegionName] nvarchar(50),
)

-- DímGeography
CREATE TABLE [DimGeography] (
	[GeographyKey] int identity(1,1) not null,
	[AddressAK] int not null,
    [City] nvarchar(30),  
    [StateProvinceCode] nvarchar(50),
    [StateProvinceName] nvarchar(50),
	[PostalCode] nvarchar(30),  
	[CountryRegionCode] nvarchar(50),
	[CountryRegionName] nvarchar(50)
)

-- DimEmployee
-- Drop the table if it exists (CREATE OR ALTER is not available for tables)
IF OBJECT_ID('DimEmployee', 'U') IS NOT NULL
    DROP TABLE DimEmployee;
GO

-- Create the DimEmployee table
CREATE TABLE DimEmployee (
    EmployeeKey      INT IDENTITY(1,1) not null,
    EmployeeAK       NVARCHAR(50),
    Title            NVARCHAR(50),
    FirstName        NVARCHAR(50),
    LastName         NVARCHAR(50),
    MiddleName       NVARCHAR(50),
    Suffix           NVARCHAR(10),
    EmailAddress     NVARCHAR(100),
    JobTitle         NVARCHAR(100),
    CurrentFlag      BIT,
	ExpirationDate   datetime,
	LoadDate		 datetime
);
GO

-- FactInternetSales
CREATE TABLE [dbo].[FactInternetSales](
	[SalesOrderNumber] [nvarchar](25) NOT NULL,
	[SalesOrderLineNumber] [tinyint] NOT NULL,
	[RevisionNumber] [int] NOT NULL,
	[ProductKey] [int] NOT NULL,
	[SalesPersonKey] [int] NOT NULL,
	[CustomerKey] [int] NOT NULL,
	[BillingToAddressKey] [int] NOT NULL,
	[ShippingToAddressKey] [int] NOT NULL,
	[PromotionKey] [int] NOT NULL,
	[SalesTerritoryKey] [int] NOT NULL,
	[OrderDateKey] [int] NOT NULL,
	[DueDateKey] [int] NOT NULL,
	[ShipDateKey] [int] NOT NULL,
	[OrderQuantity] [smallint] NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[DiscountAmount] [float] NOT NULL,
	[ProductStandardCost] [money] NOT NULL,
	[TotalProductCost] [money] NOT NULL,
	[SalesAmount] [money] NOT NULL,
	[TaxAmount] [money] NOT NULL,
	[FreightAmount] [money] NOT NULL
)

-- DimDate
BEGIN TRY
DROP TABLE [DimDate]
END TRY
BEGIN CATCH
--DO NOTHING
END CATCH
CREATE TABLE [dbo].[DimDate](
--[DateSK] [int] IDENTITY(1,1) NOT NULL--Use this line if you just want an autoincrementing counter AND COMMENT BELOW LINE
[DateKey] [int] NOT NULL,  --TO MAKE THE DateSK THE YYYYMMDD FORMAT USE THIS LINE AND COMMENT ABOVE LINE.
[FullDateAK] [date] NOT NULL,
[DayNumberOfWeek] [tinyint] NOT NULL,
[DayNameOfWeek] [nvarchar](10) NOT NULL,
[DayNumberOfMonth] [tinyint] NOT NULL,
[MonthName] [nvarchar](10) NOT NULL,
[MonthNumberOfYear] [tinyint] NOT NULL,
[CalendarQuarter] [tinyint] NOT NULL,
[CalendarYear] [smallint] NOT NULL,
CONSTRAINT [PK_DimDate] PRIMARY KEY CLUSTERED
(
[DateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

--Populate Date dimension

--TRUNCATE TABLE DimDate

--IF YOU ARE USING THE YYYYMMDD format for the primary key then you need to comment out this line.
--DBCC CHECKIDENT (DimDate, RESEED, 60000) --In case you need to add earlier dates later.

DECLARE @tmpDOW TABLE (DOW INT, Cntr INT)--Table for counting DOW occurance in a month
INSERT INTO @tmpDOW(DOW, Cntr) VALUES(1,0)--Used in the loop below
INSERT INTO @tmpDOW(DOW, Cntr) VALUES(2,0)
INSERT INTO @tmpDOW(DOW, Cntr) VALUES(3,0)
INSERT INTO @tmpDOW(DOW, Cntr) VALUES(4,0)
INSERT INTO @tmpDOW(DOW, Cntr) VALUES(5,0)
INSERT INTO @tmpDOW(DOW, Cntr) VALUES(6,0)
INSERT INTO @tmpDOW(DOW, Cntr) VALUES(7,0)

DECLARE @StartDate datetime
, @EndDate datetime
, @Date datetime
, @WDofMonth INT
, @CurrentMonth INT
, @CurrentDate date = getdate()

SELECT @StartDate = '1/1/2000'  -- -- Set The start and end date 2006-06-30
, @EndDate = '1/1/2025'--Non inclusive. Stops on the day before this.
, @CurrentMonth = 1 --Counter used in loop below.

SELECT @Date = @StartDate

WHILE @Date < @EndDate
BEGIN

IF DATEPART(MONTH,@Date) <> @CurrentMonth
BEGIN
SELECT @CurrentMonth = DATEPART(MONTH,@Date)
UPDATE @tmpDOW SET Cntr = 0
END

UPDATE @tmpDOW
SET Cntr = Cntr + 1
WHERE DOW = DATEPART(DW,@DATE)

SELECT @WDofMonth = Cntr
FROM @tmpDOW
WHERE DOW = DATEPART(DW,@DATE)

INSERT INTO DimDate
(
-- --TO MAKE THE DateSK THE YYYYMMDD FORMAT UNCOMMENT THIS LINE… Comment for autoincrementing.
[DateKey],       
[FullDateAK],
[DayNumberOfWeek],
[DayNameOfWeek],
[DayNumberOfMonth],
[MonthName],
[MonthNumberOfYear],
[CalendarQuarter],
[CalendarYear]
)

SELECT

CONVERT(VARCHAR,@Date,112), --TO MAKE THE DateSK THE YYYYMMDD FORMAT UNCOMMENT THIS LINE COMMENT FOR AUTOINCREMENT
@Date [FullDateAlternateKey]
,DATEPART(DW, @DATE) AS [DayNumberOfWeek]
, CASE DATEPART(DW, @DATE)
WHEN 1 THEN 'Sunday'
WHEN 2 THEN 'Monday'
WHEN 3 THEN 'Tuesday'
WHEN 4 THEN 'Wednesday'
WHEN 5 THEN 'Thursday'
WHEN 6 THEN 'Friday'
WHEN 7 THEN 'Saturday'
END AS [DayNameOfWeek]
, DATEPART(DAY,@DATE) [DayNumberOfMonth]
, DATENAME(MONTH,@DATE) as [MonthName]
, DATEPART(MONTH,@DATE) as [MonthNumberOfYear] --To be converted with leading zero later.
, DATEPART(qq,@DATE) as [CalendarQuarter] --Calendar quarter
, DATEPART(YEAR,@Date) as [CalendarYear]


SELECT @Date = DATEADD(dd,1,@Date)
END


