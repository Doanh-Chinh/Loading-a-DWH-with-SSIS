USE DWH_Demo_AdventureW
GO

CREATE SCHEMA Meta

CREATE TABLE Meta.DataFlow (
    DataFlowName NVARCHAR(255) NOT NULL, 
    LastSuccessfulModifiedDate DATETIME NULL, 
    
    PRIMARY KEY (DataFlowName) 
);
