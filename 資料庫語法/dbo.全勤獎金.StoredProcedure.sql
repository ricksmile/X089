USE [KHSBUS]
GO
/****** Object:  StoredProcedure [dbo].[全勤獎金]    Script Date: 2017/4/5 下午 06:06:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		鐘靈
-- Create date: 2017/04/05
-- Description:	全勤獎金判斷
--如果事假天數＋病假天數＞0則為0 或　上班天數＜30天也為0,不然核發1000元獎金
--參數　@員編 
--範例　exec [全勤獎金] 10021
-- =============================================
CREATE PROCEDURE  [dbo].[全勤獎金] 
	@員編 nvarchar(50) = null
AS
　　--建立資料表
	DECLARE  @TMP　TABLE
	(
	    員編      nvarchar(50),
		事假天數　int,
		病假天數  int,
		上班天數  int
	)
	--執行　RouteToStop_sp1　把值塞入@TMP　
	INSERT INTO @TMP
	--取所有站牌環域值
	select 員編, 事假天數,病假天數,上班天數 from 薪資明細表 where 員編=@員編
	--移除資料表
	--DROP TABLE @TMP

　　
BEGIN
    DECLARE 
	@事假天數　int,
    @病假天數  int,
	@上班天數  int

     SET @事假天數 = (select 事假天數 from  @TMP);
	 SET @病假天數 = (select 病假天數 from  @TMP);
	 SET @上班天數 = (select 上班天數 from  @TMP);

	 IF ((@事假天數+@病假天數)>0 or (@上班天數<30))
	 select @員編 as 員編, 0 as 全勤獎金
	 else
	 select @員編 as 員編,  1000 as 全勤獎金


END

GO
