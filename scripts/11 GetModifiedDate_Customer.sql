select isnull(LastSuccessfulModifiedDate,'1900-01-01') as
LastSuccessfulModifiedDate,
getdate() as CurrentDate
from Meta.DataFlow
where DataFlowName = 'DimCustomer'