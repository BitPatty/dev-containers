CREATE USER 'devel'@'%' IDENTIFIED WITH mysql_native_password BY 'devel';
CREATE USER 'devel'@'localhost' IDENTIFIED WITH mysql_native_password BY 'devel';

GRANT ALL PRIVILEGES ON *.* TO 'devel'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'devel'@'localhost';

FLUSH PRIVILEGES;

CREATE SCHEMA development;
CREATE SCHEMA testing;