#!/bin/bash

randpw() {
    export LC_CTYPE=C
    < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-16};echo;
}

echo "Setup database..."

if [ -z ${DB_SETUP_USERNAME} ]; then
    DB_SETUP_USERNAME=root
fi
if [ -z ${DB_SETUP_PASSWORD} ]; then
    DB_SETUP_PASSWORD=root
fi

# Set the default password so we don't have to pass the pw command line
export MYSQL_PWD=$DB_SETUP_PASSWORD

# app: master database
echo "Create database..."
mysql -h $DB_HOST -u $DB_SETUP_USERNAME -e "CREATE DATABASE IF NOT EXISTS $DB_MASTER_DATABASE;"
# grant permissions for app database
echo "Grant permissions..."
mysql -h $DB_HOST -u $DB_SETUP_USERNAME -e "GRANT SELECT, INSERT, UPDATE, DELETE ON $DB_MASTER_DATABASE.* TO '$DB_APP_USERNAME'@'%' IDENTIFIED BY '$DB_APP_PASSWORD';"