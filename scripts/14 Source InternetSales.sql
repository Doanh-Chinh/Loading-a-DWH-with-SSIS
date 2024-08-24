select soh.SalesOrderNumber,
	ROW_NUMBER() over(partition by sod.SalesOrderID order by sod.SalesOrderDetailID) as SalesOrderLineNumber,
		soh.RevisionNumber,
		sod.ProductID as ProductAK,
		soh.CustomerID as CustomerAK,
		soh.SalesPersonID as EmployeeAK,
		sod.SpecialOfferID as PromotionAK,
		soh.TerritoryID as SalesTerritoryAK,
		soh.BillToAddressID as BillToAddressAK,
		soh.ShipToAddressID as ShipToAddressAK,
		year(soh.OrderDate)*10000 + month(soh.OrderDate)*100 + day(soh.OrderDate) as OrderDateKey,
		year(soh.ShipDate)*10000 + month(soh.ShipDate)*100 + day(soh.ShipDate) as ShipDateKey,
		year(soh.DueDate)*10000 + month(soh.DueDate)*100 + day(soh.DueDate) as DueDateKey,
		sod.OrderQty as OrderQuantity,
		sod.UnitPrice,
		sod.UnitPriceDiscount as DiscountAmount,
		p.StandardCost as ProductStandardCost,
		p.StandardCost * sod.OrderQty as TotalProductCost,
		sod.LineTotal as SalesAmount,
		soh.TaxAmt/soh.SubTotal * sod.LineTotal as TaxAmount,
		soh.Freight/soh.SubTotal * sod.LineTotal as FreightAmount
from Sales.SalesOrderHeader soh
join Sales.SalesOrderDetail sod
	on soh.SalesOrderID = sod.SalesOrderID

join Production.Product p
	on sod.ProductID = p.ProductID