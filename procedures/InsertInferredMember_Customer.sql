USE [DWH_Demo_AdventureW]
GO
/****** Object:  StoredProcedure [dbo].[InsertInferredMember_Customer]    Script Date: 08/22/2024 17:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER   PROCEDURE [dbo].[InsertInferredMember_Customer]
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the inferred member already exists
    IF NOT EXISTS (
        SELECT *
        FROM dbo.DimCustomer
        WHERE CustomerKey = -1
    )
    BEGIN
        -- Enable identity insert to allow setting CustomerKey manually
        SET IDENTITY_INSERT dbo.DimCustomer ON;

        -- Insert the inferred member into DimCustomer table
        INSERT INTO dbo.DimCustomer (
            CustomerKey, 
            CustomerAK,
			Title,
            FirstName, 
            MiddleName, 
            LastName, 
            Suffix, 
            EmailAddress
        ) 
        VALUES (
            -1,                    -- Inferred CustomerKey
            -1,                    -- Inferred CustomerAK
            'Unknown',             -- Inferred Title
            'Unknown',             -- Inferred FirstName
            'Unknown',             -- Inferred MiddleName
            'Unknown',             -- Inferred LastName
			'Unknown',			   -- Inferred LastName
			'Unknown'			   -- Inferred LastName
        );

        -- Disable identity insert
        SET IDENTITY_INSERT dbo.DimCustomer OFF;
    END
END;
