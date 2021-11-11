USE master
CREATE LOGIN [devel] WITH PASSWORD = 'devel', CHECK_EXPIRATION = OFF, CHECK_POLICY = OFF;
EXEC sp_addsrvrolemember [devel]
GO

CREATE DATABASE [development];
GO

USE [development];
CREATE USER [devel] FOR LOGIN [devel];
EXEC sp_addrolemember N'db_owner', N'devel';
GO
