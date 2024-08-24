select SpecialOfferID as PromotionAK,
	Description as PromotionName,
	DiscountPct as DiscountPercentage,
	Type as PromotionType,
	Category,
	StartDate,
	EndDate,
	MinQty,
	MaxQty

from Sales.SpecialOffer