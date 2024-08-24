USE [DWH_Demo_AdventureW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Create or alter the procedure
CREATE OR ALTER PROCEDURE [dbo].[InsertInferredMember_Product]
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the inferred member already exists
    IF NOT EXISTS (
        SELECT *
        FROM dbo.DimProduct
        WHERE ProductKey = -1
    )
    BEGIN
        -- Enable identity insert to allow setting ProductKey manually
        SET IDENTITY_INSERT dbo.DimProduct ON;

        -- Insert the inferred member into Product table
        INSERT INTO dbo.DimProduct (
            ProductKey, 
            ProductAK, 
            ProductName, 
            ProductNumber, 
            ProductSubCategoryName, 
            ProductCategoryName, 
            FinishedGoodsFlag, 
            Color, 
            StandardCost, 
            ListPrice, 
            Size, 
            ProductLine, 
            Class, 
            Style, 
            ProductModelName, 
            SellStartDate, 
            SellEndDate
        ) 
        VALUES (
            -1,                    -- Inferred ProductKey
            -1,                    -- Inferred ProductAK
            'Unknown',             -- Inferred ProductName
            'Unknown',             -- Inferred ProductNumber
            'Unknown',             -- Inferred ProductSubCategoryName
            'Unknown',             -- Inferred ProductCategoryName
            0,                     -- Inferred FinishedGoodsFlag (0 for false)
            'Unknown',             -- Inferred Color
            0.00,                  -- Inferred StandardCost
            0.00,                  -- Inferred ListPrice
            'U',				   -- Inferred Size
            'U',                   -- Inferred ProductLine (Assuming 'U' stands for Unknown)
            'U',                   -- Inferred Class (Assuming 'U' stands for Unknown)
            'U',                   -- Inferred Style (Assuming 'U' stands for Unknown)
            'Unknown',             -- Inferred ProductModelName
            '2000-01-01',          -- Inferred SellStartDate
            '2025-01-01'           -- Inferred SellEndDate
        );

        -- Disable identity insert
        SET IDENTITY_INSERT dbo.DimProduct OFF;
    END
END;
