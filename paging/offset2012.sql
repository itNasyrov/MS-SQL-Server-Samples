create procedure getPaging
  @pages int = 1,   -- page displayed
  @rows int = 100	  -- records on the page
as
  -- verification
	if (@rows <= 0)
		set @rows = 100;
	if (@pages <= 0)
		set @pages = 1;

  declare @rows_count int
  select @rows_count = count(*) from sys.objects

  declare @page_count int
  set @page_count = @rows_count / @rows
				+ case when @rows_count % @rows > 0
						then 1
						else 0
				  end

  select *
		, @rows_count as row_count
		, @page_count as page_count
  from sys.objects
  ORDER BY object_id
  OFFSET (@pages-1)*@rows ROWS
  FETCH FIRST @rows ROWS ONLY

GO