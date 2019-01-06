## Information
To keep a record history for the ```TableName``` table
```sql
CREATE TABLE [dbo].[TableName] (
	[id] [int] IDENTITY(1,1) NOT NULL,
	[field_1] [varchar](10) NOT NULL,
	[field_2] [int] NULL,
	[field_3] [smalldatetime] NOT NULL,
	[field_4] [bit] NOT NULL,
 CONSTRAINT [PK_TableName_1] PRIMARY KEY CLUSTERED
( [id] ASC ) WITH (
  PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
```

1. an additional table `` `TableName_History``` is created with the same fields as in the table` `` TableName```,
as well as in it we add the following fields:
    ```SQL
    CREATE TABLE [dbo].[TableName_History] (
        [id] [int] NULL,
        [field_1] [varchar](10) NULL,
        [field_2] [int] NULL,
        [field_3] [smalldatetime] NULL,
        [field_4] [bit] NULL,
        [change] [varchar](15) NULL,
        [change_id] [int] NULL,
        [change_user] [varchar](50) NULL,
        [change_date] [datetime] NULL
    ) ON [PRIMARY]
    ``` 
    Additional fields:
    * [change] - operation (insert, update, delete);
    * [change_id] - record identifier;
    * [change_user] - user;
    * [datetime] - operation time.

2. Create triggers to add, modify and delete to the ```TableName``` table.
Examples of triggers are presented in the file [triggers.sql](https://github.com/itNasyrov/MS-SQL-Server-Samples/blob/history_table/history_table/triggers.sql)


## Информация
Для ведения истории по записям таблицы ```TableName```
```sql
CREATE TABLE [dbo].[TableName] (
	[id] [int] IDENTITY(1,1) NOT NULL,
	[field_1] [varchar](10) NOT NULL,
	[field_2] [int] NULL,
	[field_3] [smalldatetime] NOT NULL,
	[field_4] [bit] NOT NULL,
 CONSTRAINT [PK_TableName_1] PRIMARY KEY CLUSTERED
( [id] ASC ) WITH (
  PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
```

1. создается дополнительная таблица ```TableName_History``` с такими же полями как в таблице ```TableName```, 
а так же в ней добавляем следующие поля:
    ```SQL
    CREATE TABLE [dbo].[TableName_History] (
        [id] [int] NULL,
        [field_1] [varchar](10) NULL,
        [field_2] [int] NULL,
        [field_3] [smalldatetime] NULL,
        [field_4] [bit] NULL,
        [change] [varchar](15) NULL,
        [change_id] [int] NULL,
        [change_user] [varchar](50) NULL,
        [change_date] [datetime] NULL
    ) ON [PRIMARY]
    ``` 
    Дополниельные поля:
    * [change] - операция (insert, update, delete);
    * [change_id] - идентификатор записи;
    * [change_user] - пользователь;
    * [datetime] - время операции.

2. Создать триггеры на добавление, изменение и удаление к таблице ```TableName```.
Примеры триггеров представлены в файле [triggers.sql](https://github.com/itNasyrov/MS-SQL-Server-Samples/blob/history_table/history_table/triggers.sql)

