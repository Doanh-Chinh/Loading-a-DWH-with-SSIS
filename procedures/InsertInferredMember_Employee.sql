USE [DWH_Demo_AdventureW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[InsertInferredMember_Employee]
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the inferred member already exists
    IF NOT EXISTS (
        SELECT *
        FROM dbo.DimEmployee
        WHERE EmployeeKey = -1
    )
    BEGIN
        -- Enable identity insert to allow setting EmployeeSK manually
        SET IDENTITY_INSERT dbo.DimEmployee ON;

        -- Insert the inferred member into DimEmployee table
        INSERT INTO dbo.DimEmployee (
            EmployeeKey, 
            EmployeeAK, 
            Title, 
            FirstName, 
            LastName, 
            MiddleName, 
            Suffix, 
            EmailAddress, 
            JobTitle, 
            CurrentFlag
        ) 
        VALUES (
            -1,                    -- Inferred EmployeeSK
            -1,					   -- Inferred EmployeeAK
            'Unknown',             -- Inferred Title
            'Unknown',             -- Inferred FirstName
            'Unknown',             -- Inferred LastName
            'Unknown',             -- Inferred MiddleName
            'Unknown',             -- Inferred Suffix
            'Unknown',             -- Inferred EmailAddress
            'Unknown',             -- Inferred JobTitle
            0                      -- Inferred CurrentFlag (0 for false)
        );

        -- Disable identity insert
        SET IDENTITY_INSERT dbo.DimEmployee OFF;
    END
END;
