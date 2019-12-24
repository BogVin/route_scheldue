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

5. Create trigger for checking time 
 ```sql
DROP TRIGGER IF EXISTS Insert_chek;
DELIMITER $$

CREATE TRIGGER Insert_chek BEFORE INSERT  ON Bus_route
FOR EACH ROW 
 BEGIN
	IF NEW.start_time = NEW.end_time THEN
	SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Same time!';
	END IF;
 END $$
DELIMITER;
```
6. Creating view 
 ```sql
CREATE OR REPLACE VIEW rt as 
select
    route,
    s1.town as s_first_town,
	t1.town_name as first_town,
    s1.station_name as first_station,
	s1.station_id as s_first_id,
	start_time,
    s2.town as s_second_town,
	t2.town_name as second_town,
    s2.station_name as second_station,
    s2.station_id as s_second_id,
    end_time, distance
	
from
    Bus_route b
    inner join Stations s1 on
        b.from_station = s1.station_id
    inner join Stations s2 on
        b.to_station = s2.station_id
    inner join  Towns t1 on
	t1.town_id = s1.town
    inner join Towns t2 on
	t2.town_id = s2.town;
```
| route | s_first_town | first_town      | first_station | s_first_id | start_time          | s_second_town | second_town     | second_station | s_second_id | end_time            | distance |
|-------|--------------|-----------------|---------------|------------|---------------------|---------------|-----------------|----------------|-------------|---------------------|----------|
|    68 |            1 | Lviv            | Tetralna      |         11 | 2019-12-19 12:00:00 |             1 | Lviv            | Petlury        |          12 | 2019-12-19 12:30:00 |       12 |
|    68 |            1 | Lviv            | Petlury       |         12 | 2019-12-19 12:40:00 |             1 | Lviv            | Kolumba        |          14 | 2019-12-19 13:00:00 |       10 |
|    68 |            1 | Lviv            | Kolumba       |         14 | 2019-12-19 13:10:00 |             1 | Lviv            | Vokzal         |          13 | 2019-12-19 13:30:00 |        9 |
|    68 |            1 | Lviv            | Vokzal        |         13 | 2019-12-19 13:40:00 |             1 | Lviv            | Tetralna       |          11 | 2019-12-19 14:00:00 |       10 |
|   234 |            1 | Lviv            | Vokzal        |         13 | 2019-12-20 12:00:00 |             2 | Ivano_Frankivsk | Bandery        |          26 | 2019-12-20 13:00:00 |      132 |
|    38 |            2 | Ivano_Frankivsk | Chornovola    |         21 | 2019-12-19 12:00:00 |             2 | Ivano_Frankivsk | Dovchenka      |          22 | 2019-12-19 12:10:00 |        3 |
|    38 |            2 | Ivano_Frankivsk | Dovchenka     |         22 | 2019-12-19 12:15:00 |             2 | Ivano_Frankivsk | Pochta         |          25 | 2019-12-19 12:25:00 |        4 |
|    38 |            2 | Ivano_Frankivsk | Pochta        |         25 | 2019-12-19 12:30:00 |             2 | Ivano_Frankivsk | Bandery        |          26 | 2019-12-19 12:40:00 |        5 |
|    38 |            2 | Ivano_Frankivsk | Bandery       |         26 | 2019-12-19 12:45:00 |             2 | Ivano_Frankivsk | Chornovola     |          21 | 2019-12-19 13:00:00 |        7 |

7. Getting needed route
 ```sql
SELECT first_station , start_time , second_station, end_time FROM rt WHERE route = 38 ORDER BY start_time;
```
| first_station | start_time          | second_station | end_time            |
|---------------|---------------------|----------------|---------------------|
| Chornovola    | 2019-12-19 12:00:00 | Dovchenka      | 2019-12-19 12:10:00 |
| Dovchenka     | 2019-12-19 12:15:00 | Pochta         | 2019-12-19 12:25:00 |
| Pochta        | 2019-12-19 12:30:00 | Bandery        | 2019-12-19 12:40:00 |
| Bandery       | 2019-12-19 12:45:00 | Chornovola     | 2019-12-19 13:00:00 |
