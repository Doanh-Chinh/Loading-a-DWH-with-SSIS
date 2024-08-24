-- Create the DWH_Demo_AdventureW_Staging database
CREATE DATABASE DWH_Demo_AdventureW_Staging;
GO

-- Switch to the new database
USE DWH_Demo_AdventureW_Staging;
GO

-- Create the Stg_Geography table with the specified columns
CREATE TABLE Stg_Geography (
	AddressAK			INT,
    City                NVARCHAR(30),
    StateProvinceCode   NVARCHAR(50),
    StateProvinceName   NVARCHAR(50),
    PostalCode          NVARCHAR(30),
    CountryRegionCode   NVARCHAR(50),
    CountryRegionName   NVARCHAR(50)
);
GO


CREATE TABLE [Stg_Customer] (
    [CustomerAK]		int, 
    [Title]				nchar(10),
    [FirstName]			nvarchar(50),
    [MiddleName]		nvarchar(50),
    [LastName]			nvarchar(50),
    [Suffix]			nchar(10),
    [EmailAddress]		nvarchar(50),
	[ExpirationDate]	datetime,
	[LoadDate]			datetime

)
