select st.TerritoryID as SalesTerritoryAK,
	st.Name as SalesTerritoryName,
	st.CountryRegionCode,
	cr.Name as CountryRegionName
from Sales.SalesTerritory st
join Person.CountryRegion cr
	on st.CountryRegionCode = cr.CountryRegionCode