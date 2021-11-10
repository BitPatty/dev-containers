CREATE USER 'devel'@'%' IDENTIFIED BY 'devel';
CREATE USER 'devel'@'localhost' IDENTIFIED BY 'devel';

GRANT ALL PRIVILEGES ON *.* TO 'devel'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'devel'@'localhost';

FLUSH PRIVILEGES;

CREATE SCHEMA development;
CREATE SCHEMA testing;