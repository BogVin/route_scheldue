
CREATE TABLE IF NOT EXISTS Towns(
	town_id smallint PRIMARY KEY UNIQUE NOT NULL,
	town_name varchar(255) NOT NULL
) ENGINE InnoDB;


CREATE TABLE IF NOT EXISTS Stations(
	town smallint NOT NULL,
	station_id smallint UNIQUE NOT NULL,
	station_name varchar(255) NOT NULL,
	PRIMARY KEY (station_id)
)ENGINE InnoDB;
	


CREATE TABLE IF NOT EXISTS Routes(
	route_id smallint   NOT NULL UNIQUE,
	wheel_type varchar(255) NOT NULL ,
	seat_number smallint NOT NULL,
	PRIMARY KEY (route_id)
)ENGINE InnoDB;


CREATE TABLE IF NOT EXISTS Bus_route(
	route smallint NOT NULL ,
	start_time DATETIME NOT NULL,
	end_time DATETIME NOT NULL,
	distance float NULL,
	from_station smallint NOT NULL,
	to_station smallint NOT NULL
)ENGINE InnoDB;



LOAD DATA LOCAL INFILE 'Bus_routes.txt' INTO TABLE Bus_route;

LOAD DATA LOCAL INFILE 'Routes.txt' INTO TABLE Routes;

LOAD DATA LOCAL INFILE 'Stations.txt' INTO TABLE Stations;

LOAD DATA LOCAL INFILE 'Towns.txt' INTO TABLE Towns;


ALTER TABLE Stations
ADD FOREIGN KEY (town)
REFERENCES Towns(town_id) ON UPDATE CASCADE;
 
ALTER TABLE Bus_route
ADD FOREIGN KEY (route)
REFERENCES Routes(route_id) ON UPDATE CASCADE;

ALTER TABLE Bus_route
ADD FOREIGN KEY (from_station) REFERENCES Stations (station_id),
ADD FOREIGN KEY (to_station) REFERENCES Stations (station_id);


DROP TRIGGER IF EXISTS Delete_route;
DELIMITER $$
CREATE TRIGGER Delete_route BEFORE DELETE  ON Routes
FOR EACH ROW 
 BEGIN
   DELETE FROM Bus_route WHERE route = OLD.route_id;

 END $$
DELIMITER ;


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


CREATE OR REPLACE VIEW rt as 
select
    route,
    s1.town as s_first_town,
    s1.station_name as first_station,
	s1.station_id as s_first_id,
	start_time,
    s2.town as s_second_town,
    s2.station_name as second_station,
    s2.station_id as s_second_id,
    end_time, distance
from
    Bus_route b
    inner join Stations s1 on
        b.from_station = s1.station_id
    inner join Stations s2 on
        b.to_station = s2.station_id;









