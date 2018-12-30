
-- =============================================
-- Description:	table of dates
-- =============================================
CREATE TABLE [dbo].[stage](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tabn] [varchar](10) NULL,
	[begin_date] [date] NOT NULL,
	[end_date] [date] NOT NULL,
	[dd]  AS (datediff(day,[begin_date],isnull([end_date],getdate()))+(2))
 CONSTRAINT [PK_Stage] PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


-- =============================================
-- Description:	number of months between dates
-- =============================================
CREATE FUNCTION [dbo].[get_stage_month_count]
(
	@begin_date date,
	@end_date date
)
RETURNS int
AS
BEGIN
	DECLARE @Result int

	SELECT @Result = CASE
    WHEN (MONTH(@end_date)-
        CASE
          WHEN DAY(@end_date) < DAY(@begin_date)
          THEN 1
          ELSE 0
        END
        ) >= MONTH(@begin_date)
      THEN MONTH(@end_date)-
              CASE
                WHEN DAY(@end_date) < DAY(@begin_date) THEN 1
                  ELSE 0
                END - MONTH(@begin_date)
      ELSE (MONTH(@end_date)-
              CASE
                WHEN DAY(@end_date) < DAY(@begin_date) THEN 1
                ELSE 0
              END + 12) - MONTH(@begin_date)

    END

	RETURN @Result
END

GO


CREATE PROCEDURE dbo.get_stage
AS
BEGIN
	DECLARE @diff_day TINYINT;

	SET @diff_day = 0;

	CREATE TABLE #table (
		id INT IDENTITY(1, 1) NOT NULL
		,start_date DATE NULL
		,end_date DATE NULL
		,dd INT NULL
		,day INT NULL
		,month INT NULL
		,year INT NULL
		)

	INSERT #table (
		start_date
		,end_date
		,dd
		,day
		,month
		,year
		)
	SELECT begin_date
		,end_date
		,dd
		,CASE
			WHEN DAY(end_date) >= DAY(begin_date)
				THEN DAY(end_date) - DAY(begin_date) + 1
			ELSE (DAY(end_date) + 30) - DAY(begin_date) + 1
			END AS kolday
		,dbo.get_stage_month_count(begin_date, end_date) AS kolmonth
		,YEAR(end_date) - CASE
			WHEN MONTH(end_date) < MONTH(begin_date)
				THEN 1
			WHEN YEAR(end_date) - YEAR(begin_date) > 0
				AND dbo.get_stage_month_count(begin_date, end_date) > 10
				AND DATEDIFF(MONTH, begin_date, end_date) % 12 = 0
				THEN 1
			ELSE 0
			END - YEAR(begin_date) AS kolyear
	FROM Stage

	CREATE TABLE #tablesum (
		dd INT
		,mm INT
		,yy INT
		,type INT
		)

	INSERT #tablesum (
		dd
		,mm
		,yy
		)
	SELECT SUM(day)
		,SUM(month)
		,SUM(year)
	FROM #table

	IF (( SELECT count(*)
				FROM #table ) <> 1)
	BEGIN
		UPDATE #tablesum
		SET dd = dd % 30 - 1
			, mm = (mm + dd / 30) % 12
			, yy = yy + (mm + dd / 30) / 12
	END
	ELSE
	BEGIN
		UPDATE #tablesum
		SET dd = dd - 1
	END

	SELECT *
	FROM #tablesum
	ORDER BY type

	DROP TABLE #table
	DROP TABLE #tablesum
END