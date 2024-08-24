USE [DWH_Demo_AdventureW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create or alter procedure [dbo].[InsertFromStage_Geography]
as
begin

set nocount on;

insert dbo.DimGeography(
	AddressAK,
	City,
	StateProvinceCode,
	StateProvinceName,
	PostalCode,
	CountryRegionCode,
	CountryRegionName
)
select 
	stg.AddressAK,	
	stg.City,
	stg.StateProvinceCode,
	stg.StateProvinceName,
	stg.PostalCode,
	stg.CountryRegionCode,
	stg.CountryRegionName
from DWH_Demo_AdventureW_Staging.dbo.Stg_Geography stg
where not exists(
	select *
	from dbo.DimGeography dest
	where dest.AddressAK = stg.AddressAK

)

end
GO