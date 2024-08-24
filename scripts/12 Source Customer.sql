USE AdventureWorks2019
GO

select c.CustomerID as CustomerAK,
	p.Title,
	p.FirstName,
	p.MiddleName,
	p.LastName,
	p.Suffix,
	ea.EmailAddress
from Sales.Customer c
join Person.Person p
	on c.PersonID = p.BusinessEntityID
left join Person.EmailAddress ea
	on p.BusinessEntityID = ea.BusinessEntityID
where (ea.ModifiedDate > ?
		or p.ModifiedDate > ?)
		and (
			ea.ModifiedDate <= ?
			or p.ModifiedDate <= ?
		)