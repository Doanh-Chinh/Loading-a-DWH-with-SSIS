use [DWH_Demo_AdventureW]
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[InsertInferredMember_Promotion]
as
begin

set nocount on;
if not exists (
	select *
	from dbo.DimPromotion
	where PromotionKey = -1)

	begin
		set identity_insert dbo. DimPromotion on
		insert dbo.DimPromotion (
		PromotionKey, PromotionAK, PromotionName ,
		DiscountPercentage , PromotionType, PromotionCategory,
		PromotionStartDate , PromotionEndDate, MinQty , MaxQty
		) values (
		-1, -1, 'Unknown ' ,
		0, 'Unknown ' , 'Unknown' ,
		'2000-01-01' , '2025-01-01' ,0, null
		)
		set identity_insert DimPromotion Off
	end
end
GO