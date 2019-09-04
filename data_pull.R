## Simple script to pull data from PostgreSQL db using R
#  Use the RPostgreSQL library
#  https://code.google.com/archive/p/rpostgresql/ 


library("RPostgreSQL")
drv <- dbDriver("PostgreSQL")

# Settings from GCP database instance
con <- dbConnect(drv, user="postgres", host="35.232.198.24", dbname="postgres", password="9eEBOdleImHrPDaq")

## query entire table and send to R dataframe!
pg_data <- dbGetQuery(con, "SELECT * FROM sensor_data1 WHERE created_on BETWEEN '2018-12-06' AND '2018-12-07' AND sensor_id = 7956")

q <- paste("SELECT AVG(b_pm25_atm) as avg_25b, AVG(a_pm25_atm) as avg_25a,sensor_id FROM sensor_data1 WHERE created_on BETWEEN '", Sys.time() - 86400, "' AND '", Sys.time(), "' GROUP BY sensor_id;", sep="")

drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, user="postgres", host="35.232.198.24", dbname="postgres", password="9eEBOdleImHrPDaq")
temp_df <- dbGetQuery(con, q)
dbDisconnect(con)
dbUnloadDriver(drv)