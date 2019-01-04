## Information

The stored procedure is designed to separate data for paginated data output,
before MSSQL 2012, use the procedure from the file [paging.sql](https://github.com/itNasyrov/SQL-Server-Samples/blob/master/paging/paging.sql)
starting with MSSQL 2012 and higher, use the procedure from the file [offset2012.sql](https://github.com/itNasyrov/SQL-Server-Samples/blob/master/paging/offset2012)
  
**@pages** get the page you need
  
**@rows** number of entries in the village
  
**sys.objects** - it is necessary to replace the table needed for output
  
**row_count** - total number of records
  
**page_count** - number of country
  
## Using stored procedure
  
default 1 page 100 records
  
```sql 
exec getPaging 
```
  
get 5 page of 50 entries
  
```sql 
exec getPaging 5, 50 
```

## Performance

![performance](https://i.snag.gy/zDBZYW.jpg)
  

## Информация

Хранимая процедура предназначена для разделения данных для постраничного вывода данных,
до MSSQL 2012 использовать процедуру из файла [paging.sql](https://github.com/itNasyrov/SQL-Server-Samples/blob/master/paging/paging.sql)
начиная с MSSQL 2012 и выше использовать процедуру из файла [offset2012.sql](https://github.com/itNasyrov/SQL-Server-Samples/blob/master/paging/offset2012) 

**@pages** получить необходимую страницу

**@rows** количество записей в станице

**sys.objects** - необходимо заменить на необходимую для вывода таблицу

**row_count** - общее количество записей

**page_count** - количество страниц

## Использование хранимой процедуры

по умолчанию 1 станица 100 записей
```sql 
exec getPaging 
```

получить 5 страницу из 50 записей
```sql 
exec getPaging 5, 50 
```

## Производительность

![производительность](https://i.snag.gy/zDBZYW.jpg)
