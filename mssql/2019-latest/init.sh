#!/bin/sh

set -ex

# Start up the SQL server in the background
/opt/mssql/bin/sqlservr &

# Wait for the port to listen
sh ./wait-for.sh -t 60 localhost:1433

# Wait another 5 seconds until the server
# is ready to accept client connections
sleep 5

# Create the devel user / development database
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -i init.sql
