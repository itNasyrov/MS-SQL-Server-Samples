DECLARE	@pages int = 2   -- page displayed
DECLARE	@rows int = 30	  -- records on the page


select * 
from sys.objects
ORDER BY object_id
OFFSET (@pages-1)*@rows ROWS
FETCH FIRST @rows ROWS ONLY
