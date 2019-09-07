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

CREATE TABLE sensor_data1 (
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

SELECT * FROM sensor_data1
WHERE created_on <= 2018-12-07 AND created_on >= 2018-12-06 AND sensor_id = 7956;

query for getting 24 hr, 1 hr, and current AQI values
SELECT AVG(b_pm25_atm) as avg_25b, AVG(a_pm25_atm) as avg_25a,sensor_id FROM sensor_data1
WHERE created_on BETWEEN '2018-12-06' AND '2018-12-07'
GROUP BY sensor_id;
