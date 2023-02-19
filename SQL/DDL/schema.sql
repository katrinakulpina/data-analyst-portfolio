CREATE TABLE passengers (
	passenger_id INTEGER CONSTRAINT pk_passengers_passengerid PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	passport VARCHAR(20) NOT NULL CONSTRAINT uq_passengers_passport UNIQUE,
	birth_date DATE NOT NULL,
	email VARCHAR(50) NOT NULL,
	phone VARCHAR(20) NOT NULL
);

CREATE TABLE stations (
	station_code VARCHAR(3) CONSTRAINT pk_stations_stationcode PRIMARY KEY,
	station_name VARCHAR(50) NOT NULL,
	town VARCHAR(50) NOT NULL
);

CREATE TABLE routes (
	route_num INTEGER CONSTRAINT pk_routes_routenum PRIMARY KEY,
	station_from VARCHAR(3) NOT NULL,
	station_to VARCHAR(3) NOT NULL,
	distance NUMERIC(8,2) NOT NULL CHECK (distance > 0),
	dep_time TIME NOT NULL,
	duration TIME NOT NULL
);

CREATE TABLE booking (
	booking_id INTEGER CONSTRAINT pk_booking_bookingid PRIMARY KEY,
	passenger_id INTEGER,
	route_num INTEGER,
	departure_date DATE NOT NULL,
	carriage_num INTEGER,
	seat_num INTEGER NOT NULL
);

CREATE TABLE carriages(
	carriage_num INTEGER CONSTRAINT pk_carrriages_carriagenum PRIMARY KEY,
	class_id INTEGER
);

CREATE TABLE classes (
	class_id INTEGER CONSTRAINT pk_classes_classid PRIMARY KEY,
	class_name VARCHAR(50) NOT NULL,
	seat_price NUMERIC(8,2) NOT NULL CHECK (seat_price > 0),
	num_of_seats INTEGER NOT NULL CHECK (num_of_seats > 0)
);

ALTER TABLE booking
	ADD CONSTRAINT fk_booking_passengers FOREIGN KEY (passenger_id)
		REFERENCES passengers(passenger_id);
ALTER TABLE booking
	ADD CONSTRAINT fk_booking_routes FOREIGN KEY (route_num)
		REFERENCES routes(route_num);
ALTER TABLE booking
	ADD CONSTRAINT fk_booking_carriages FOREIGN KEY (carriage_num)
		REFERENCES carriages(carriage_num);
	
ALTER TABLE routes
	ADD CONSTRAINT fk_routes_stationfrom FOREIGN KEY (station_from)
		REFERENCES stations(station_code);
ALTER TABLE routes
	ADD CONSTRAINT fk_routes_stationto FOREIGN KEY (station_to)
		REFERENCES stations(station_code);
	
ALTER TABLE carriages
	ADD CONSTRAINT fk_carriages_classes FOREIGN KEY (class_id)
		REFERENCES classes(class_id);
	
INSERT INTO passengers (passenger_id, first_name, last_name, passport, birth_date, email, phone)
VALUES (100, 'Jack', 'Sparrow', '1234 567890', TO_DATE('1956-04-01', 'YYYY-MM-DD'), 'JSPARROW', '874-19-278');
INSERT INTO passengers (passenger_id, first_name, last_name, passport, birth_date, email, phone)
VALUES (101, 'Steve', 'Jobs', '7890 123456', TO_DATE('1955-02-24', 'YYYY-MM-DD'), 'SJOBS', '999-01-178');

INSERT INTO stations (station_code, station_name, town)
VALUES ('MSK', 'Moskovskiy', 'Saint Petersburg');
INSERT INTO stations (station_code, station_name, town)
VALUES ('LDZ', 'Ladozhskiy', 'Saint Petersburg');
INSERT INTO stations (station_code, station_name, town)
VALUES ('PVL', 'Paveletskiy', 'Moscow');

INSERT INTO routes (route_num, station_from, station_to, distance, dep_time, duration)
VALUES (110, 'MSK', 'PVL', 703.5, '09:30:00', '12:14:00');
INSERT INTO routes (route_num, station_from, station_to, distance, dep_time, duration)
VALUES (120, 'PVL', 'LDZ', 710.2, '14:28:00', '10:02:00');

INSERT INTO classes (class_id, class_name, seat_price, num_of_seats)
VALUES (1, 'economy', 1000.00, 54);
INSERT INTO classes (class_id, class_name, seat_price, num_of_seats)
VALUES (2, 'comfort', 2500.00, 36);
INSERT INTO classes (class_id, class_name, seat_price, num_of_seats)
VALUES (3, 'luxury', 4000.00, 18);

INSERT INTO carriages (carriage_num, class_id)
VALUES (1, 3);
INSERT INTO carriages (carriage_num, class_id)
VALUES (2, 2);
INSERT INTO carriages (carriage_num, class_id)
VALUES (3, 1);
INSERT INTO carriages (carriage_num, class_id)
VALUES (4, 1);

INSERT INTO booking (booking_id, passenger_id, route_num, departure_date, carriage_num, seat_num)
VALUES (500, 100, 120, TO_DATE('2022-10-13', 'YYYY-MM-DD'), 4, 28);
INSERT INTO booking (booking_id, passenger_id, route_num, departure_date, carriage_num, seat_num)
VALUES (501, 101, 110, TO_DATE('2022-10-18', 'YYYY-MM-DD'), 1, 6);
INSERT INTO booking (booking_id, passenger_id, route_num, departure_date, carriage_num, seat_num)
VALUES (502, 101, 120, TO_DATE('2022-10-26', 'YYYY-MM-DD'), 3, 30);
	







