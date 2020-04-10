CREATE USER 'devel'@'%' IDENTIFIED WITH mysql_native_password BY 'devel';
GRANT ALL PRIVILEGES ON *.* TO 'devel'@'%';
FLUSH PRIVILEGES;
CREATE SCHEMA development;
CREATE SCHEMA testing;