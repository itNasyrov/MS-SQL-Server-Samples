
create procedure getPaging
	@pages int = 1,   -- page displayed
	@rows int = 100	  -- records on the page
as
begin
  -- verification
	if (@rows <= 0)
		set @rows = 100;
	if (@pages <= 0)
		set @pages = 1;


	SELECT
		((ROW_NUMBER() over (ORDER BY object_id) -1) / @rows)+1 as pages,   -- page number
		ROW_NUMBER() over (ORDER BY object_id) as num,					              -- record number
		*
  into #temp
	FROM sys.objects

	declare @rows_count int
	select @rows_count = count(*) from #temp

  -- show data
	select *
			, @rows_count as row_count
			, @rows_count / @rows
				+ case when @rows_count % @rows > 0
						then 1
						else 0
				  end as page_count
	from #temp
	where pages = @pages
	order by num

  -- drop temp table
	drop table #temp
end

go