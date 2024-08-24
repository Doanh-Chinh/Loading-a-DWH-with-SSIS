USE [DWH_Demo_AdventureW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[InsertInferredMember_Geography]
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the inferred member already exists
    IF NOT EXISTS (
        SELECT *
        FROM dbo.DimGeography
        WHERE GeographyKey = -1
    )
    BEGIN
        -- Enable identity insert to allow setting GeogrphyKey manually
        SET IDENTITY_INSERT dbo.DimGeography ON;

        -- Insert the inferred member into Geography table
        INSERT INTO dbo.DimGeography (
            GeographyKey, 
			AddressAK,
            City, 
            StateProvinceCode, 
            StateProvinceName, 
            PostalCode, 
            CountryRegionCode, 
            CountryRegionName
        ) 
        VALUES (
            -1,                    -- Inferred GeogrphyKey
            -1,                    -- Inferred AddressAK
            'Unknown',             -- Inferred City
            'Unknown',             -- Inferred StateProvinceCode
            'Unknown',             -- Inferred StateProvinceName
            'Unknown',             -- Inferred PostalCode
            'Unknown',             -- Inferred CountryRegionCode
            'Unknown'              -- Inferred CountryRegionName
        );

        -- Disable identity insert
        SET IDENTITY_INSERT dbo.DimGeography OFF;
    END
END;
