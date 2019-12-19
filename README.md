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
+------+------------+--------------+
| town | station_id | station_name |
+------+------------+--------------+
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
+------+------------+--------------+
