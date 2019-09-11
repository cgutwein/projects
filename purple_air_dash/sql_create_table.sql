CREATE TABLE sensor_data (
 row_id serial PRIMARY KEY,
 entry_id INTEGER NOT NULL,
 sensor_id SMALLINT NOT NULL,
 created_on TIMESTAMP,
 B_pm1 FLOAT(2),
 B_pm2_5 FLOAT(2),
 B_pm10 FLOAT(2),
 B_PM2_5a FLOAT(2)
);

CREATE TABLE sensor_data (
 row_id serial PRIMARY KEY,
 entry_id INTEGER NOT NULL,
 sensor_id SMALLINT NOT NULL,
 created_on TIMESTAMP,
 A_PM1_ATM FLOAT(2),
 A_PM25_ATM FLOAT(2),
 A_PM10_ATM FLOAT(2),
 A_PM1_1 FLOAT(2),
 A_PM25_1 FLOAT(2),
 A_PM10_1 FLOAT(2),
 B_PM1_ATM FLOAT(2),
 B_PM25_ATM FLOAT(2),
 B_PM10_ATM FLOAT(2),
 B_PM1_1 FLOAT(2),
 B_PM25_1 FLOAT(2),
 B_PM10_1 FLOAT(2),
 temp SMALLINT,
 humidity SMALLINT
);

INSERT INTO sensor_data (entry_id, sensor_id, created_on, B_pm1, B_pm2_5, B_pm10, B_pm2_5a)
 VALUES (410204, 1492, '2018-11-27T20:48:53Z', 111.31, 112.36, 112.46, 82.72);

ALTER TABLE sensor_data ADD UNIQUE (entry_id);
ALTER TABLE foo ADD UNIQUE (thecolumn);

CREATE TABLE sensor_list(
  id serial PRIMARY KEY,
  sensor_id SMALLINT NOT NULL,
  label VARCHAR(200),
  thingspeak_ID_A1 INTEGER NOT NULL,
  thingspeak_KEY_A1 VARCHAR(16) NOT NULL,
  thingspeak_ID_A2 INTEGER NOT NULL,
  thingspeak_KEY_A2 VARCHAR(16) NOT NULL,
  thingspeak_ID_B1 INTEGER NOT NULL,
  thingspeak_KEY_B1 VARCHAR(16) NOT NULL,
  thingspeak_ID_B2 INTEGER NOT NULL,
  thingspeak_KEY_B2 VARCHAR(16) NOT NULL,
  lat FLOAT(6),
  lon FLOAT(6)
);

INSERT INTO sensor_list (sensor_id, label, thingspeak_ID_A1, thingspeak_KEY_A1, thingspeak_ID_A2, thingspeak_KEY_A2, thingspeak_ID_B1, thingspeak_KEY_B1, thingspeak_ID_B2, thingspeak_KEY_B2, lat, lon)
 VALUES (7956, 'Globeville', 436992, 'BCCY1FTDZRPGEZR3', 436993, '9D9V11VHM2G8WH4E', 436994, 'CJ5CEIFS10V8X3FK', 436995, '4D0II3V2DXPTDDWE', 39.785917, -104.988855);

INSERT INTO sensor_list (sensor_id, label, thingspeak_ID_A1, thingspeak_KEY_A1, thingspeak_ID_A2, thingspeak_KEY_A2, thingspeak_ID_B1, thingspeak_KEY_B1, thingspeak_ID_B2, thingspeak_KEY_B2, lat, lon)
VALUES (4838, 'Wheaton Highlands', 372220, '6ZX1399UFQ9R3ALG', 372221, 'L7GGDWRUO2X0S3XO', 372222, 'CIGI45QRYROBXRMN', 372223, '12075KOLRICJAD5H', 41.863506, -88.08802);

INSERT INTO sensor_list (sensor_id, label, thingspeak_ID_A1, thingspeak_KEY_A1, thingspeak_ID_A2, thingspeak_KEY_A2, thingspeak_ID_B1, thingspeak_KEY_B1, thingspeak_ID_B2, thingspeak_KEY_B2, lat, lon)
 VALUES (5588, '1138 PLYMOUTH', 392051, '9IQJ5SH47AXVZB1J', 392052, '1BHKPE2TWHLYLH41', 392053, 'BOG4IEYJLYF2AZYO', 392054, 'LH3HFMLA1ZZV9JMB', 41.868892, -87.629436);

INSERT INTO sensor_list (sensor_id, label, thingspeak_ID_A1, thingspeak_KEY_A1, thingspeak_ID_A2, thingspeak_KEY_A2, thingspeak_ID_B1, thingspeak_KEY_B1, thingspeak_ID_B2, thingspeak_KEY_B2, lat, lon)
VALUES (3088, 'Howe Neighborhood', 323935, 'LY343R9IG5GOGM1E', 323936, 'O0LC54RK57D15YWD', 323937, '67RPCHLV0WW761MG', 323938, 'K1Y2GIFGIDPA3EAW', 44.935817, -93.217521);

INSERT INTO sensor_list (sensor_id, label, thingspeak_ID_A1, thingspeak_KEY_A1, thingspeak_ID_A2, thingspeak_KEY_A2, thingspeak_ID_B1, thingspeak_KEY_B1, thingspeak_ID_B2, thingspeak_KEY_B2, lat, lon)
  VALUES (1491, 'Clean Air Carolina RCCC South Campus', 261890, 'FM6RR57XS7UG6Q05', 261891, '2YXYFSN80IP14D47', 261892, 'N9895O7HBXLPYUQ6', 261893, '1M7ED8RRW8MXMC4L', 35.437746, -80.659763);

SELECT * FROM sensor_data1
WHERE created_on <= 2018-12-07 AND created_on >= 2018-12-06 AND sensor_id = 7956;

query for getting 24 hr, 1 hr, and current AQI values
SELECT AVG(b_pm25_atm) as avg_25b, AVG(a_pm25_atm) as avg_25a,sensor_id FROM sensor_data1
WHERE created_on BETWEEN '2018-12-06' AND '2018-12-07'
GROUP BY sensor_id;
