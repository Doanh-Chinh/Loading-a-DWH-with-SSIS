select 
	a.AddressID as AddressAK,
	a.City,
	sp.StateProvinceCode,
	sp.Name as StateProvinceName,
	a.PostalCode,
	sp.CountryRegionCode,
	cr.Name as CountryRegionName
from Person.Address a
join Person.StateProvince sp
	on a.StateProvinceID = sp.StateProvinceID
join Person.CountryRegion cr
	on sp.CountryRegionCode = cr.CountryRegionCode

