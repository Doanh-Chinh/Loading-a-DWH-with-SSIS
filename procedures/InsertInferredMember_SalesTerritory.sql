USE [DWH_Demo_AdventureW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[InsertInferredMember_SalesTerritory]
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the inferred member already exists
    IF NOT EXISTS (
        SELECT *
        FROM dbo.DimSalesTerritory
        WHERE SalesTerritoryKey = -1
    )
    BEGIN
        -- Enable identity insert to allow setting SalesTerritoryKey manually
        SET IDENTITY_INSERT dbo.SalesTerritory ON;

        -- Insert the inferred member into SalesTerritory table
        INSERT INTO dbo.DimSalesTerritory (
            SalesTerritoryKey, 
            SalesTerritoryAK, 
            SalesTerritoryName, 
            SalesCoutryRegionCode, 
            SalesCountryRegionName
        ) 
        VALUES (
            -1,                -- Inferred SalesTerritoryKey
            -1,                -- Inferred SalesTerritoryAK
            'Unknown',         -- Inferred SalesTerritoryName
            'Unknown',         -- Inferred SalesCountryRegionCode
            'Unknown'          -- Inferred SalesCountryRegionName
        );

        -- Disable identity insert
        SET IDENTITY_INSERT dbo.DimSalesTerritory OFF;
    END
END;
