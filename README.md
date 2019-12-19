# route_scheldue
## Entity Relatioship(ER) diagram
![ER-diagram](./img/bddiagram.png)
## Tools
* UBUNTU v18.04
* Pgmodeler
* For creating ER-diagram https://www.lucidchart.com/
* MySQL
## Example of SQL queries
1. Select all stations
```sql
SELECT * FROM Stations;
```

| town | station_id | station_name |
|------|------------|--------------|
|    1 |         11 | Tetralna     |
|    1 |         12 | Petlury      |
|    1 |         13 | Vokzal       |
|    1 |         14 | Kolumba      |
|    2 |         21 | Chornovola   |
|    2 |         22 | Dovchenka    |
|    2 |         23 | Mazepy       |
|    2 |         24 | Sacharova    |
|    2 |         25 | Pochta       |
|    2 |         26 | Bandery      |
|    3 |         31 | Platona      |
|    3 |         32 | Dnipro       |
|    3 |         33 | Dambova      |
|    3 |         34 | Sadova       |

2. Select stations with town
 ```sql
SELECT town_name, station_name FROM Stations JOIN Towns ON Stations.town = Towns.town_id;
```

| town_name       | station_name |
|-----------------|--------------|
| Lviv            | Tetralna     |
| Lviv            | Petlury      |
| Lviv            | Vokzal       |
| Lviv            | Kolumba      |
| Ivano_Frankivsk | Chornovola   |
| Ivano_Frankivsk | Dovchenka    |
| Ivano_Frankivsk | Mazepy       |
| Ivano_Frankivsk | Sacharova    |
| Ivano_Frankivsk | Pochta       |
| Ivano_Frankivsk | Bandery      |
| Kyiv            | Platona      |
| Kyiv            | Dnipro       |
| Kyiv            | Dambova      |
| Kyiv            | Sadova       |

3. Select all stations that belong Ivano_Frankivsk
 ```sql
SELECT town_name, station_name FROM Stations JOIN Towns ON Stations.town = Towns.town_id WHERE town_name like 'Ivano%';
```

| town_name       | station_name |
|-----------------|--------------|
| Ivano_Frankivsk | Chornovola   |
| Ivano_Frankivsk | Dovchenka    |
| Ivano_Frankivsk | Mazepy       |
| Ivano_Frankivsk | Sacharova    |
| Ivano_Frankivsk | Pochta       |
| Ivano_Frankivsk | Bandery      |


4.Create delete trigger for Routes
 ```sql
DELIMITER $$
CREATE TRIGGER Delete_route BEFORE DELETE  ON Routes
FOR EACH ROW 
 BEGIN
   DELETE FROM Bus_route WHERE route = OLD.route_id;

 END $$
DELIMITER ;
SELECT * FROM Bus_route;
DELETE FROM Routes WHERE route_id = 45;
SELECT * FROM Bus_route;
```
| route | start_time          | end_time            | distance | from_station | to_station |
|-------|---------------------|---------------------|----------|--------------|------------|
|    68 | 2019-12-19 12:00:00 | 2019-12-19 12:30:00 |       12 |           11 |         12 |
|    68 | 2019-12-19 12:40:00 | 2019-12-19 13:00:00 |       10 |           12 |         14 |
|    68 | 2019-12-19 13:10:00 | 2019-12-19 13:30:00 |        9 |           14 |         13 |
|    68 | 2019-12-19 13:40:00 | 2019-12-19 14:00:00 |       10 |           13 |         11 |
|   234 | 2019-12-20 12:00:00 | 2019-12-20 13:00:00 |      132 |           13 |         26 |
|    38 | 2019-12-19 12:00:00 | 2019-12-19 12:10:00 |        3 |           21 |         22 |
|    38 | 2019-12-19 12:15:00 | 2019-12-19 12:25:00 |        4 |           22 |         25 |
|    38 | 2019-12-19 12:30:00 | 2019-12-19 12:40:00 |        5 |           25 |         26 |
|    38 | 2019-12-19 12:45:00 | 2019-12-19 13:00:00 |        7 |           26 |         21 |
|    45 | 2019-12-19 12:00:00 | 2019-12-19 12:10:00 |        3 |           22 |         23 |
|    45 | 2019-12-19 12:15:00 | 2019-12-19 12:25:00 |        4 |           23 |         24 |
|    45 | 2019-12-19 12:30:00 | 2019-12-19 12:40:00 |        5 |           24 |         25 |
|    45 | 2019-12-19 12:45:00 | 2019-12-19 13:00:00 |        7 |           25 |         22 |



| route | start_time          | end_time            | distance | from_station | to_station |
|-------|---------------------|---------------------|----------|--------------|------------|
|    68 | 2019-12-19 12:00:00 | 2019-12-19 12:30:00 |       12 |           11 |         12 |
|    68 | 2019-12-19 12:40:00 | 2019-12-19 13:00:00 |       10 |           12 |         14 |
|    68 | 2019-12-19 13:10:00 | 2019-12-19 13:30:00 |        9 |           14 |         13 |
|    68 | 2019-12-19 13:40:00 | 2019-12-19 14:00:00 |       10 |           13 |         11 |
|   234 | 2019-12-20 12:00:00 | 2019-12-20 13:00:00 |      132 |           13 |         26 |
|    38 | 2019-12-19 12:00:00 | 2019-12-19 12:10:00 |        3 |           21 |         22 |
|    38 | 2019-12-19 12:15:00 | 2019-12-19 12:25:00 |        4 |           22 |         25 |
|    38 | 2019-12-19 12:30:00 | 2019-12-19 12:40:00 |        5 |           25 |         26 |
|    38 | 2019-12-19 12:45:00 | 2019-12-19 13:00:00 |        7 |           26 |         21 |

