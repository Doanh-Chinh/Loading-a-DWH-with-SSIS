## AdventureWorks_DWH Project
This project aims to build an Internet Sales Data Mart by extracting, transforming, and loading data from the AdventureWorks 2019 database. The data mart is designed using a star schema, comprising the following dimensions: `DimPromotion`, `DimProduct`, `DimSalesTerritory`, `DimGeography`, `DimCustomer`, `DimEmployee`, `DimDate`, and a fact table: `FactInternetSales`. The ETL process is implemented using SQL Server Integration Services (SSIS) within Visual Studio.

## Data Source
Data source can be downloaded from here! [AdventureWorks2019.bak](https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2019.bak)

## Internet Sales Diagram
![Screenshot](data-mapping/InternetSales_Diagram.png)

## Data Mapping 
![Screenshot](data-mapping/CustomerMapping.png)

<p align="center"> Mapping Customer Source and Customer Destination (DimCustomer) </p>