USE [KHSBUS]
GO
/****** Object:  StoredProcedure [dbo].[薪資明細表產製]    Script Date: 2017/4/5 下午 06:06:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		鐘靈
-- Create date: 2017/04/05
-- Description:	薪資明細表
--產製薪資明細表
--參數　@員編 
--範例　exec [薪資明細表] 10021
-- =============================================
CREATE PROCEDURE  [dbo].[薪資明細表產製] 
	@員編 nvarchar(50) = null
AS
　　--建立資料表
	DECLARE  @TMP　TABLE
	(
	    員編      nvarchar(50),
		是否有法扣　int
	)
	--執行　RouteToStop_sp1　把值塞入@TMP　
	INSERT INTO @TMP
	--取所有站牌環域值
	select 員編, 是否有法扣 from 薪資明細表 where 員編=@員編
	--移除資料表
	--DROP TABLE @TMP

　　
BEGIN
    DECLARE 
	@是否有法扣　int

     SET @是否有法扣 = (select 是否有法扣 from  @TMP);
	 
	 --要法扣
	 IF (@是否有法扣=1) 
	 select * from 法扣計算 where 員編=@員編
	 else
	 select @員編 as 員編  , 0 as 法扣


END

GO
