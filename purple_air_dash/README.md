## Demo Dashboard for Purple Air Sensors - Mostardi Platt


#### Sensor List
Mulford Manor (Evanston, Illinois)

#### Installing new R packages
1. SSH to GCP compute *shiny* instance
2. enter the `sudo -i R` command to run R with admin priveleges
3. enter `install.packages(<package name>)`



-------

Notes for set up:

* Install PostgreSQL
* Install libpq-dev `sudo apt-get install libpq-dev`
* install python module *psycopg2* for connection to PostgreSQL `pip3 install psycopg2`
* install tmux `sudo apt-get install tmux`
Good blog post with basic tmux commands: https://www.hamvocke.com/blog/a-quick-and-easy-guide-to-tmux/

To allow remote access to PostgreSQL:

* locate postgresql.conf file and change `listen_addresses = '*'`
* locate `pg_hba.conf` and add `host all all 0.0.0.0/0 md5` to the end of the file
* restart PostgreSQL by entering `/etc/init.d/postgresql restart`
