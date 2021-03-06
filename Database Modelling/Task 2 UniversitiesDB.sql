USE [master]
GO
/****** Object:  Database [TypicalUniversitiesDB]    Script Date: 9.10.2015 г. 00:52:50 ч. ******/
CREATE DATABASE [TypicalUniversitiesDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TypicalUniversitiesDB', FILENAME = N'D:\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\TypicalUniversitiesDB.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'TypicalUniversitiesDB_log', FILENAME = N'D:\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\TypicalUniversitiesDB_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [TypicalUniversitiesDB] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TypicalUniversitiesDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TypicalUniversitiesDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TypicalUniversitiesDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TypicalUniversitiesDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TypicalUniversitiesDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TypicalUniversitiesDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [TypicalUniversitiesDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TypicalUniversitiesDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TypicalUniversitiesDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TypicalUniversitiesDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TypicalUniversitiesDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TypicalUniversitiesDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TypicalUniversitiesDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TypicalUniversitiesDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TypicalUniversitiesDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TypicalUniversitiesDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TypicalUniversitiesDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TypicalUniversitiesDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TypicalUniversitiesDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TypicalUniversitiesDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TypicalUniversitiesDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TypicalUniversitiesDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TypicalUniversitiesDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TypicalUniversitiesDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TypicalUniversitiesDB] SET  MULTI_USER 
GO
ALTER DATABASE [TypicalUniversitiesDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TypicalUniversitiesDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TypicalUniversitiesDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TypicalUniversitiesDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [TypicalUniversitiesDB] SET DELAYED_DURABILITY = DISABLED 
GO
USE [TypicalUniversitiesDB]
GO
/****** Object:  Table [dbo].[Courses]    Script Date: 9.10.2015 г. 00:52:50 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Courses](
	[CourseId] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentId] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_CourseId] PRIMARY KEY CLUSTERED 
(
	[CourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Departments]    Script Date: 9.10.2015 г. 00:52:50 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departments](
	[DepartmentId] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[FacultyId] [int] NOT NULL,
 CONSTRAINT [PK_DepartmentId] PRIMARY KEY CLUSTERED 
(
	[DepartmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Faculties]    Script Date: 9.10.2015 г. 00:52:50 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Faculties](
	[FacultyId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[UniversityId] [int] NOT NULL,
 CONSTRAINT [PK_FacultyId] PRIMARY KEY CLUSTERED 
(
	[FacultyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Professors]    Script Date: 9.10.2015 г. 00:52:50 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Professors](
	[ProfessorId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[DepartmentId] [int] NOT NULL,
 CONSTRAINT [PK_ProfessorId] PRIMARY KEY CLUSTERED 
(
	[ProfessorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProfessorsCoursesChain]    Script Date: 9.10.2015 г. 00:52:50 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProfessorsCoursesChain](
	[ProfessorId] [int] NOT NULL,
	[CourseId] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProfessorsTitlesChain]    Script Date: 9.10.2015 г. 00:52:50 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProfessorsTitlesChain](
	[ProfessorId] [int] NOT NULL,
	[TitleId] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Students]    Script Date: 9.10.2015 г. 00:52:50 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[StudentId] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[FacultyId] [int] NOT NULL,
 CONSTRAINT [PK_StudentId] PRIMARY KEY CLUSTERED 
(
	[StudentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StudentsCoursesChain]    Script Date: 9.10.2015 г. 00:52:50 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentsCoursesChain](
	[StudentId] [int] NOT NULL,
	[CourseId] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Titles]    Script Date: 9.10.2015 г. 00:52:50 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Titles](
	[TitleId] [int] NOT NULL,
	[ConcreteTitle] [nvarchar](150) NOT NULL,
 CONSTRAINT [PK_TitleId] PRIMARY KEY CLUSTERED 
(
	[TitleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Universities]    Script Date: 9.10.2015 г. 00:52:50 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Universities](
	[UniversityId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_UniversityId] PRIMARY KEY CLUSTERED 
(
	[UniversityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Courses]  WITH CHECK ADD  CONSTRAINT [FK_Courses_Departments] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[Departments] ([DepartmentId])
GO
ALTER TABLE [dbo].[Courses] CHECK CONSTRAINT [FK_Courses_Departments]
GO
ALTER TABLE [dbo].[Departments]  WITH CHECK ADD  CONSTRAINT [FK_Departments_Faculties] FOREIGN KEY([FacultyId])
REFERENCES [dbo].[Faculties] ([FacultyId])
GO
ALTER TABLE [dbo].[Departments] CHECK CONSTRAINT [FK_Departments_Faculties]
GO
ALTER TABLE [dbo].[Faculties]  WITH CHECK ADD  CONSTRAINT [FK_Faculties_Universities] FOREIGN KEY([UniversityId])
REFERENCES [dbo].[Universities] ([UniversityId])
GO
ALTER TABLE [dbo].[Faculties] CHECK CONSTRAINT [FK_Faculties_Universities]
GO
ALTER TABLE [dbo].[Professors]  WITH CHECK ADD  CONSTRAINT [FK_Professors_Departments] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[Departments] ([DepartmentId])
GO
ALTER TABLE [dbo].[Professors] CHECK CONSTRAINT [FK_Professors_Departments]
GO
ALTER TABLE [dbo].[ProfessorsCoursesChain]  WITH CHECK ADD  CONSTRAINT [FK_ProfessorCoursesChain_Courses] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Courses] ([CourseId])
GO
ALTER TABLE [dbo].[ProfessorsCoursesChain] CHECK CONSTRAINT [FK_ProfessorCoursesChain_Courses]
GO
ALTER TABLE [dbo].[ProfessorsCoursesChain]  WITH CHECK ADD  CONSTRAINT [FK_ProfessorCoursesChain_Professors] FOREIGN KEY([ProfessorId])
REFERENCES [dbo].[Professors] ([ProfessorId])
GO
ALTER TABLE [dbo].[ProfessorsCoursesChain] CHECK CONSTRAINT [FK_ProfessorCoursesChain_Professors]
GO
ALTER TABLE [dbo].[ProfessorsTitlesChain]  WITH CHECK ADD  CONSTRAINT [FK_ProfessorsTitlesChain_Professors] FOREIGN KEY([ProfessorId])
REFERENCES [dbo].[Professors] ([ProfessorId])
GO
ALTER TABLE [dbo].[ProfessorsTitlesChain] CHECK CONSTRAINT [FK_ProfessorsTitlesChain_Professors]
GO
ALTER TABLE [dbo].[ProfessorsTitlesChain]  WITH CHECK ADD  CONSTRAINT [FK_ProfessorsTitlesChain_Titles] FOREIGN KEY([TitleId])
REFERENCES [dbo].[Titles] ([TitleId])
GO
ALTER TABLE [dbo].[ProfessorsTitlesChain] CHECK CONSTRAINT [FK_ProfessorsTitlesChain_Titles]
GO
ALTER TABLE [dbo].[Students]  WITH CHECK ADD  CONSTRAINT [FK_Students_Faculties] FOREIGN KEY([FacultyId])
REFERENCES [dbo].[Faculties] ([FacultyId])
GO
ALTER TABLE [dbo].[Students] CHECK CONSTRAINT [FK_Students_Faculties]
GO
ALTER TABLE [dbo].[StudentsCoursesChain]  WITH CHECK ADD  CONSTRAINT [FK_StudentCoursesChain_Courses] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Courses] ([CourseId])
GO
ALTER TABLE [dbo].[StudentsCoursesChain] CHECK CONSTRAINT [FK_StudentCoursesChain_Courses]
GO
ALTER TABLE [dbo].[StudentsCoursesChain]  WITH CHECK ADD  CONSTRAINT [FK_StudentCoursesChain_Students] FOREIGN KEY([StudentId])
REFERENCES [dbo].[Students] ([StudentId])
GO
ALTER TABLE [dbo].[StudentsCoursesChain] CHECK CONSTRAINT [FK_StudentCoursesChain_Students]
GO
USE [master]
GO
ALTER DATABASE [TypicalUniversitiesDB] SET  READ_WRITE 
GO
