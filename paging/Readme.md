##information

the stored procedure is to separate data for paginated output
  
**@pages** get the page you need
  
**@rows** number of entries in the village
  
**sys.objects** - it is necessary to replace the table needed for output
  
**row_count** - total number of records
  
**page_count** - number of country
  
##using stored procedure
  
default 1 page 100 records
  
```sql 
exec getPaging 
```
  
get 5 page of 50 entries
  
```sql 
exec getPaging 5, 50 
```
  

##информация

хранимая процедура предназначена для разделения данных для постраничного вывода

**@pages** получить необходимую страницу

**@rows** количество записей в станице

**sys.objects** - необходимо заменить на необходимую для вывода таблицу

**row_count** - общее количество записей

**page_count** - количество страниц

##использование хранимой процедуры

по умолчанию 1 станица 100 записей
```sql 
exec getPaging 
```

получить 5 страницу из 50 записей
```sql 
exec getPaging 5, 50 
```
