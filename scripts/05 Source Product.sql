select P.ProductID as 'ProductAK'
	  ,P.[ProductNumber]
	  ,P.[Name] as 'ProductName'
	  ,PSC.Name as 'ProductSubCategoryName'
	  ,PC.Name as 'ProductCategoryName'
      ,P.[FinishedGoodsFlag]
      ,P.[Color]
      ,P.[StandardCost]
      ,P.[ListPrice]
      ,P.[Size]
      ,P.[ProductLine]
      ,P.[Class]
      ,P.[Style]
      ,M.[Name] as 'ProductModelName'
      ,P.[SellStartDate]
      ,P.[SellEndDate]
from Production.Product P 
left join Production.ProductSubcategory PSC
	on P.ProductSubcategoryID = PSC.ProductSubcategoryID
left join Production.ProductCategory PC
	on PSC.ProductCategoryID = PC.ProductCategoryID
left join Production.ProductModel M
	on P.ProductModelID = M.ProductModelID