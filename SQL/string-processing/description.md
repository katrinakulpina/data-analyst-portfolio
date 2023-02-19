### Задание 1
Источниками данных являются таблицы DE_LOG и DE_IP. Тестовые варианты таблиц можно найти в файлах [create_de_log](https://github.com/katrinakulpina/data-analyst-portfolio/blob/main/SQL/string-processing/create_de_log.sql) и [create_de_ip](https://github.com/katrinakulpina/data-analyst-portfolio/blob/main/SQL/string-processing/create_de_ip.sql).

Данные в исходных таблицах повреждены. Необходимо разделить их и построить структурированную таблицу посещений:
```sql
CREATE TABLE LOG ( 
  DT DATE, 
  LINK VARCHAR(50), 
  USER_AGENT VARCHAR(200), 
  REGION VARCHAR(30) 
)
```

### Задание 2
Построить отчет, содержащий информацию о том, какой браузер в каких областях является наиболее используемым:
```sql
CREATE TABLE LOG_REPORT (
  REGION VARCHAR(30), 
  BROWSER VARCHAR(10) 
)
```
