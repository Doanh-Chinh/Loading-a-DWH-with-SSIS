USE [DWH_Demo_AdventureW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[Merge_Customer]
AS
BEGIN
    SET NOCOUNT ON;

    -- Part 1: Expire old records by updating the ExpirationDate
    UPDATE c
    SET c.ExpirationDate = GETDATE()
    FROM dbo.DimCustomer c
    INNER JOIN DWH_Demo_AdventureW_Staging.dbo.Stg_Customer stg
        ON c.CustomerAK = stg.CustomerAK
    WHERE c.ExpirationDate IS NULL
      AND c.EmailAddress <> stg.EmailAddress;

    -- Part 2: Insert new records from the staging table
    INSERT INTO dbo.DimCustomer (
        CustomerAK, Title, FirstName, MiddleName, LastName, Suffix,
        EmailAddress, ExpirationDate, LoadDate
    )
    SELECT 
        stg.CustomerAK, stg.Title, stg.FirstName, stg.MiddleName, 
        stg.LastName, stg.Suffix, stg.EmailAddress, 
        stg.ExpirationDate, stg.LoadDate
    FROM DWH_Demo_AdventureW_Staging.dbo.Stg_Customer stg
    LEFT JOIN dbo.DimCustomer c
        ON c.CustomerAK = stg.CustomerAK
    WHERE c.CustomerAK IS NULL;

END
GO
