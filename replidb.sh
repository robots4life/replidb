#! /usr/bin/env bash

# run this inside the Devilbox container
# ./shell.sh

# run this script
# chmod +x replidb.sh


echo ""
echo ""
echo "Name of the database?"
echo ""
echo ""
read -r dbname
clear


echo ""
echo ""
echo "User of the database?"
echo ""
echo ""
read -r dbuser
clear

echo ""
echo ""
echo "Password of the database?"
echo ""
echo ""
read -r dbpassword
clear

echo ""
echo ""
echo "Creating Database, Database User and Database Password"
echo ""
echo ""
# Create db_name, db_user and db_pass with mysql.
# Login to mysql with default devilbox root and no password.
# Then create a new db, user and pass for the new WordPress install.
# https://stackoverflow.com/questions/1659848/mysql-create-user-with-rights-only-for-specific-db
# https://stackoverflow.com/a/33471072/1010918
mysql -u root -h 127.0.0.1 -e "CREATE DATABASE ${dbname,,} CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci";

mysql -u root -h 127.0.0.1 -e "CREATE USER '${dbuser,,}'@'%' IDENTIFIED BY '$dbpassword'";

mysql -u root -h 127.0.0.1 -e "GRANT PROCESS ON *.* TO '${dbuser,,}'@'%'"

mysql -u root -h 127.0.0.1 -e "ALTER USER '${dbuser,,}'@'%' REQUIRE NONE WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0";

mysql -u root -h 127.0.0.1 -e "GRANT ALL PRIVILEGES ON ${dbname,,}.* TO '${dbuser,,}'@'%'";

mysql -u root -h 127.0.0.1 -e "ALTER USER '${dbuser,,}'@'%'";

exit 1