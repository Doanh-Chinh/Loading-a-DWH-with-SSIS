USE AdventureWorks2019
GO

select e.BusinessEntityID as EmployeeAK,
	p.Title,
	p.FirstName,
	p.LastName,
	p.MiddleName,
	p.Suffix,
	ea.EmailAddress,
	e.JobTitle,
	e.CurrentFlag
from HumanResources.Employee e
left join Person.Person p
	on e.BusinessEntityID = p.BusinessEntityID
left join Person.EmailAddress ea
	on e.BusinessEntityID = ea.BusinessEntityID

