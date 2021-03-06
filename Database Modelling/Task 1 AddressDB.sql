USE [master]
GO
/****** Object:  Database [AddressDB]    Script Date: 8.10.2015 г. 23:17:13 ч. ******/
CREATE DATABASE [AddressDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AddressDB', FILENAME = N'D:\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\AddressDB.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'AddressDB_log', FILENAME = N'D:\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\AddressDB_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [AddressDB] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AddressDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AddressDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AddressDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AddressDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AddressDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AddressDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [AddressDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [AddressDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AddressDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AddressDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AddressDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AddressDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AddressDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AddressDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AddressDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AddressDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [AddressDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AddressDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AddressDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AddressDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AddressDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AddressDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AddressDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AddressDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [AddressDB] SET  MULTI_USER 
GO
ALTER DATABASE [AddressDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AddressDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AddressDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AddressDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [AddressDB] SET DELAYED_DURABILITY = DISABLED 
GO
USE [AddressDB]
GO
/****** Object:  Table [dbo].[Addresses]    Script Date: 8.10.2015 г. 23:17:14 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Addresses](
	[AddressId] [int] IDENTITY(1,1) NOT NULL,
	[AddressText] [ntext] NOT NULL,
	[TownId] [int] NOT NULL,
 CONSTRAINT [PK_AddressId] PRIMARY KEY CLUSTERED 
(
	[AddressId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Continents]    Script Date: 8.10.2015 г. 23:17:14 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Continents](
	[ContinentId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ContinentId] PRIMARY KEY CLUSTERED 
(
	[ContinentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Countries]    Script Date: 8.10.2015 г. 23:17:14 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Countries](
	[CountryId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[ContinentId] [int] NOT NULL,
 CONSTRAINT [PK_CountryId] PRIMARY KEY CLUSTERED 
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[People]    Script Date: 8.10.2015 г. 23:17:14 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[People](
	[PersonId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[AddressId] [int] NOT NULL,
 CONSTRAINT [PK_PersonId] PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Towns]    Script Date: 8.10.2015 г. 23:17:14 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Towns](
	[TownId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[CountryId] [int] NOT NULL,
 CONSTRAINT [PK_TownId] PRIMARY KEY CLUSTERED 
(
	[TownId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Addresses] ON 

INSERT [dbo].[Addresses] ([AddressId], [AddressText], [TownId]) VALUES (1, N'12th Avenue ', 5)
INSERT [dbo].[Addresses] ([AddressId], [AddressText], [TownId]) VALUES (2, N'Sunset Boulevard', 5)
INSERT [dbo].[Addresses] ([AddressId], [AddressText], [TownId]) VALUES (3, N'Beeston Rd', 13)
INSERT [dbo].[Addresses] ([AddressId], [AddressText], [TownId]) VALUES (4, N'Cross Green Way', 13)
INSERT [dbo].[Addresses] ([AddressId], [AddressText], [TownId]) VALUES (5, N'Brunton Park', 14)
INSERT [dbo].[Addresses] ([AddressId], [AddressText], [TownId]) VALUES (6, N'Green Line', 2)
INSERT [dbo].[Addresses] ([AddressId], [AddressText], [TownId]) VALUES (7, N'Bárugata', 1)
INSERT [dbo].[Addresses] ([AddressId], [AddressText], [TownId]) VALUES (8, N'Maple St', 6)
INSERT [dbo].[Addresses] ([AddressId], [AddressText], [TownId]) VALUES (9, N'Poison Spider Rd', 14)
INSERT [dbo].[Addresses] ([AddressId], [AddressText], [TownId]) VALUES (10, N'Parkway Boulevard', 5)
INSERT [dbo].[Addresses] ([AddressId], [AddressText], [TownId]) VALUES (11, N'Millcreek 71', 12)
SET IDENTITY_INSERT [dbo].[Addresses] OFF
SET IDENTITY_INSERT [dbo].[Continents] ON 

INSERT [dbo].[Continents] ([ContinentId], [Name]) VALUES (1, N'Aquaria')
INSERT [dbo].[Continents] ([ContinentId], [Name]) VALUES (2, N'Aerilon')
INSERT [dbo].[Continents] ([ContinentId], [Name]) VALUES (3, N'Canceron')
INSERT [dbo].[Continents] ([ContinentId], [Name]) VALUES (4, N'Caprica')
INSERT [dbo].[Continents] ([ContinentId], [Name]) VALUES (5, N'Gemenon')
INSERT [dbo].[Continents] ([ContinentId], [Name]) VALUES (6, N'Leonis')
INSERT [dbo].[Continents] ([ContinentId], [Name]) VALUES (7, N'Libran')
INSERT [dbo].[Continents] ([ContinentId], [Name]) VALUES (8, N'Picon')
INSERT [dbo].[Continents] ([ContinentId], [Name]) VALUES (9, N'Sagittaron')
INSERT [dbo].[Continents] ([ContinentId], [Name]) VALUES (10, N'Scoripa')
INSERT [dbo].[Continents] ([ContinentId], [Name]) VALUES (11, N'Tauron')
INSERT [dbo].[Continents] ([ContinentId], [Name]) VALUES (12, N'Virgon')
SET IDENTITY_INSERT [dbo].[Continents] OFF
SET IDENTITY_INSERT [dbo].[Countries] ON 

INSERT [dbo].[Countries] ([CountryId], [Name], [ContinentId]) VALUES (1, N'Hermes', 1)
INSERT [dbo].[Countries] ([CountryId], [Name], [ContinentId]) VALUES (2, N'Aerilon', 2)
INSERT [dbo].[Countries] ([CountryId], [Name], [ContinentId]) VALUES (3, N'Promethea', 2)
INSERT [dbo].[Countries] ([CountryId], [Name], [ContinentId]) VALUES (4, N'Mangala', 3)
INSERT [dbo].[Countries] ([CountryId], [Name], [ContinentId]) VALUES (5, N'New Caprica', 4)
INSERT [dbo].[Countries] ([CountryId], [Name], [ContinentId]) VALUES (6, N'Delphi', 4)
INSERT [dbo].[Countries] ([CountryId], [Name], [ContinentId]) VALUES (7, N'Illumini', 5)
INSERT [dbo].[Countries] ([CountryId], [Name], [ContinentId]) VALUES (8, N'Arthemis', 6)
INSERT [dbo].[Countries] ([CountryId], [Name], [ContinentId]) VALUES (9, N'Libris', 7)
INSERT [dbo].[Countries] ([CountryId], [Name], [ContinentId]) VALUES (10, N'Piscera', 8)
INSERT [dbo].[Countries] ([CountryId], [Name], [ContinentId]) VALUES (11, N'Sagitara', 9)
INSERT [dbo].[Countries] ([CountryId], [Name], [ContinentId]) VALUES (12, N'Dyonysus', 10)
INSERT [dbo].[Countries] ([CountryId], [Name], [ContinentId]) VALUES (13, N'Old Colony', 11)
INSERT [dbo].[Countries] ([CountryId], [Name], [ContinentId]) VALUES (14, N'Imperial', 12)
SET IDENTITY_INSERT [dbo].[Countries] OFF
SET IDENTITY_INSERT [dbo].[People] ON 

INSERT [dbo].[People] ([PersonId], [FirstName], [LastName], [AddressId]) VALUES (1, N'William', N'Adama', 1)
INSERT [dbo].[People] ([PersonId], [FirstName], [LastName], [AddressId]) VALUES (2, N'Leland', N'Adama', 2)
INSERT [dbo].[People] ([PersonId], [FirstName], [LastName], [AddressId]) VALUES (3, N'Kara', N'Thrace', 11)
INSERT [dbo].[People] ([PersonId], [FirstName], [LastName], [AddressId]) VALUES (4, N'Laura', N'Roslin', 1)
INSERT [dbo].[People] ([PersonId], [FirstName], [LastName], [AddressId]) VALUES (5, N'Gaius', N'Baltar', 6)
INSERT [dbo].[People] ([PersonId], [FirstName], [LastName], [AddressId]) VALUES (6, N'Saul', N'Tigh', 6)
INSERT [dbo].[People] ([PersonId], [FirstName], [LastName], [AddressId]) VALUES (7, N'Karl', N'Agathon', 2)
INSERT [dbo].[People] ([PersonId], [FirstName], [LastName], [AddressId]) VALUES (8, N'Thomas', N'Zarek', 3)
INSERT [dbo].[People] ([PersonId], [FirstName], [LastName], [AddressId]) VALUES (9, N'Anastasia ', N'Dualla', 4)
SET IDENTITY_INSERT [dbo].[People] OFF
SET IDENTITY_INSERT [dbo].[Towns] ON 

INSERT [dbo].[Towns] ([TownId], [Name], [CountryId]) VALUES (1, N'The Ice Colony', 1)
INSERT [dbo].[Towns] ([TownId], [Name], [CountryId]) VALUES (2, N'Gaoth', 2)
INSERT [dbo].[Towns] ([TownId], [Name], [CountryId]) VALUES (3, N'Demeter', 3)
INSERT [dbo].[Towns] ([TownId], [Name], [CountryId]) VALUES (4, N'Hades', 4)
INSERT [dbo].[Towns] ([TownId], [Name], [CountryId]) VALUES (5, N'Caprica City', 5)
INSERT [dbo].[Towns] ([TownId], [Name], [CountryId]) VALUES (6, N'Apollo', 5)
INSERT [dbo].[Towns] ([TownId], [Name], [CountryId]) VALUES (8, N'New Delphi', 6)
INSERT [dbo].[Towns] ([TownId], [Name], [CountryId]) VALUES (9, N'Oranu', 7)
INSERT [dbo].[Towns] ([TownId], [Name], [CountryId]) VALUES (10, N'Luminere', 8)
INSERT [dbo].[Towns] ([TownId], [Name], [CountryId]) VALUES (11, N'Themis', 9)
INSERT [dbo].[Towns] ([TownId], [Name], [CountryId]) VALUES (12, N'Queenstown', 10)
INSERT [dbo].[Towns] ([TownId], [Name], [CountryId]) VALUES (13, N'Tawa', 11)
INSERT [dbo].[Towns] ([TownId], [Name], [CountryId]) VALUES (14, N'Celeste', 12)
INSERT [dbo].[Towns] ([TownId], [Name], [CountryId]) VALUES (15, N'Hypatia', 13)
INSERT [dbo].[Towns] ([TownId], [Name], [CountryId]) VALUES (16, N'Boskirk', 14)
SET IDENTITY_INSERT [dbo].[Towns] OFF
/****** Object:  Index [UK_Continent_Name]    Script Date: 8.10.2015 г. 23:17:14 ч. ******/
ALTER TABLE [dbo].[Continents] ADD  CONSTRAINT [UK_Continent_Name] UNIQUE NONCLUSTERED 
(
	[ContinentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UK_Country_Name]    Script Date: 8.10.2015 г. 23:17:14 ч. ******/
ALTER TABLE [dbo].[Countries] ADD  CONSTRAINT [UK_Country_Name] UNIQUE NONCLUSTERED 
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Addresses]  WITH CHECK ADD  CONSTRAINT [FK_Addresses_Towns] FOREIGN KEY([TownId])
REFERENCES [dbo].[Towns] ([TownId])
GO
ALTER TABLE [dbo].[Addresses] CHECK CONSTRAINT [FK_Addresses_Towns]
GO
ALTER TABLE [dbo].[Countries]  WITH CHECK ADD  CONSTRAINT [FK_Countries_Continents] FOREIGN KEY([ContinentId])
REFERENCES [dbo].[Continents] ([ContinentId])
GO
ALTER TABLE [dbo].[Countries] CHECK CONSTRAINT [FK_Countries_Continents]
GO
ALTER TABLE [dbo].[People]  WITH CHECK ADD  CONSTRAINT [FK_People_Addresses] FOREIGN KEY([AddressId])
REFERENCES [dbo].[Addresses] ([AddressId])
GO
ALTER TABLE [dbo].[People] CHECK CONSTRAINT [FK_People_Addresses]
GO
ALTER TABLE [dbo].[Towns]  WITH CHECK ADD  CONSTRAINT [FK_Towns_Countries] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Countries] ([CountryId])
GO
ALTER TABLE [dbo].[Towns] CHECK CONSTRAINT [FK_Towns_Countries]
GO
USE [master]
GO
ALTER DATABASE [AddressDB] SET  READ_WRITE 
GO
