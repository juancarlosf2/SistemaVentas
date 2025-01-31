USE [master]
GO
/****** Object:  Database [DBVenta]    Script Date: 7/24/2019 9:50:01 AM ******/
CREATE DATABASE [DBVenta]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DBVenta', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\DBVenta.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DBVenta_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\DBVenta_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [DBVenta] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DBVenta].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DBVenta] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DBVenta] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DBVenta] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DBVenta] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DBVenta] SET ARITHABORT OFF 
GO
ALTER DATABASE [DBVenta] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DBVenta] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DBVenta] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DBVenta] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DBVenta] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DBVenta] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DBVenta] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DBVenta] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DBVenta] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DBVenta] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DBVenta] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DBVenta] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DBVenta] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DBVenta] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DBVenta] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DBVenta] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DBVenta] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DBVenta] SET RECOVERY FULL 
GO
ALTER DATABASE [DBVenta] SET  MULTI_USER 
GO
ALTER DATABASE [DBVenta] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DBVenta] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DBVenta] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DBVenta] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DBVenta] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'DBVenta', N'ON'
GO
ALTER DATABASE [DBVenta] SET QUERY_STORE = OFF
GO
USE [DBVenta]
GO
/****** Object:  Table [dbo].[tblVenta]    Script Date: 7/24/2019 9:50:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblVenta](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClienteId] [int] NOT NULL,
	[FechaVenta] [date] NOT NULL,
	[NumeroDocumento] [varchar](50) NULL,
	[TipoDocumento] [varchar](100) NULL,
 CONSTRAINT [PK_tblVenta] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblDetalleVenta]    Script Date: 7/24/2019 9:50:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDetalleVenta](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[VentaId] [int] NOT NULL,
	[ProductoId] [int] NOT NULL,
	[Cantidad] [decimal](18, 2) NOT NULL,
	[PrecioUnitario] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_tblDetalleVenta] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblProducto]    Script Date: 7/24/2019 9:50:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProducto](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoriaId] [int] NOT NULL,
	[Nombre] [varchar](200) NOT NULL,
	[Descripcion] [varchar](500) NOT NULL,
	[Stock] [decimal](18, 2) NOT NULL,
	[PrecioCompra] [decimal](18, 2) NOT NULL,
	[PrecioVenta] [decimal](18, 2) NOT NULL,
	[FechaVencimiento] [date] NOT NULL,
	[FechaCreado] [datetime] NOT NULL,
	[Imagen] [image] NULL,
 CONSTRAINT [PK_tblProducto] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_3]    Script Date: 7/24/2019 9:50:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_3]
AS
SELECT        dbo.tblDetalleVenta.Id, dbo.tblDetalleVenta.VentaId, dbo.tblDetalleVenta.ProductoId, dbo.tblProducto.Nombre, dbo.tblVenta.TipoDocumento, dbo.tblVenta.NumeroDocumento, dbo.tblVenta.FechaVenta
FROM            dbo.tblDetalleVenta INNER JOIN
                         dbo.tblProducto ON dbo.tblDetalleVenta.VentaId = dbo.tblProducto.Id INNER JOIN
                         dbo.tblVenta ON dbo.tblDetalleVenta.VentaId = dbo.tblVenta.Id
GO
/****** Object:  Table [dbo].[tblCliente]    Script Date: 7/24/2019 9:50:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCliente](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Apellido] [varchar](50) NOT NULL,
	[Dni] [int] NULL,
	[Direccion] [varchar](50) NULL,
	[Telefono] [varchar](50) NULL,
 CONSTRAINT [PK_tblCliente] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_2]    Script Date: 7/24/2019 9:50:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_2]
AS
SELECT        dbo.tblCliente.Nombre, dbo.tblCliente.Apellido, dbo.tblVenta.Id, dbo.tblVenta.ClienteId, dbo.tblVenta.FechaVenta, dbo.tblVenta.NumeroDocumento, dbo.tblVenta.TipoDocumento
FROM            dbo.tblCliente INNER JOIN
                         dbo.tblVenta ON dbo.tblCliente.Id = dbo.tblVenta.ClienteId
GO
/****** Object:  View [dbo].[View_4]    Script Date: 7/24/2019 9:50:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_4]
AS
SELECT        dbo.tblDetalleVenta.VentaId, dbo.tblDetalleVenta.ProductoId, dbo.tblDetalleVenta.Cantidad, dbo.tblDetalleVenta.PrecioUnitario, dbo.tblProducto.Nombre, dbo.tblProducto.PrecioVenta, dbo.tblDetalleVenta.Id
FROM            dbo.tblDetalleVenta INNER JOIN
                         dbo.tblProducto ON dbo.tblDetalleVenta.VentaId = dbo.tblProducto.Id
GO
/****** Object:  View [dbo].[VistaReporteVenta]    Script Date: 7/24/2019 9:50:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VistaReporteVenta]
AS
SELECT        dbo.tblDetalleVenta.VentaId, dbo.tblDetalleVenta.Cantidad, dbo.tblDetalleVenta.PrecioUnitario, dbo.tblVenta.FechaVenta, dbo.tblVenta.NumeroDocumento, dbo.tblVenta.TipoDocumento, dbo.tblCliente.Nombre, 
                         dbo.tblCliente.Apellido, dbo.tblCliente.Dni, dbo.tblProducto.Nombre AS ProductoDescripcion, dbo.tblDetalleVenta.Cantidad * dbo.tblDetalleVenta.PrecioUnitario AS TotalParcial
FROM            dbo.tblDetalleVenta INNER JOIN
                         dbo.tblVenta ON dbo.tblDetalleVenta.VentaId = dbo.tblVenta.Id INNER JOIN
                         dbo.tblCliente ON dbo.tblVenta.ClienteId = dbo.tblCliente.Id INNER JOIN
                         dbo.tblProducto ON dbo.tblDetalleVenta.ProductoId = dbo.tblProducto.Id
GO
/****** Object:  Table [dbo].[tblCategoria]    Script Date: 7/24/2019 9:50:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCategoria](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](500) NOT NULL,
 CONSTRAINT [PK_tblCategoria] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUsuario]    Script Date: 7/24/2019 9:50:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUsuario](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Apellido] [varchar](50) NOT NULL,
	[Dni] [int] NULL,
	[Direccion] [varchar](500) NULL,
	[Telefono] [varchar](50) NULL,
	[Usuario] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[Tipo] [varchar](100) NULL,
 CONSTRAINT [PK_tblUsuario] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vista ventas]    Script Date: 7/24/2019 9:50:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vista ventas]
AS
SELECT dbo.tblDetalleVenta.ProductoId, dbo.tblProducto.Id, dbo.tblProducto.CategoriaId, dbo.tblCategoria.Id AS Expr1, dbo.tblVenta.CienteId, dbo.tblCliente.Id AS Expr2, dbo.tblDetalleVenta.VentaId
FROM     dbo.tblCategoria INNER JOIN
                  dbo.tblCliente ON dbo.tblCategoria.Id = dbo.tblCliente.Id INNER JOIN
                  dbo.tblDetalleVenta ON dbo.tblCategoria.Id = dbo.tblDetalleVenta.Id INNER JOIN
                  dbo.tblProducto ON dbo.tblCategoria.Id = dbo.tblProducto.Id AND dbo.tblDetalleVenta.ProductoId = dbo.tblProducto.Id AND dbo.tblCategoria.Id = dbo.tblProducto.CategoriaId INNER JOIN
                  dbo.tblUsuario ON dbo.tblCategoria.Id = dbo.tblUsuario.Id INNER JOIN
                  dbo.tblVenta ON dbo.tblCategoria.Id = dbo.tblVenta.Id AND dbo.tblCliente.Id = dbo.tblVenta.CienteId AND dbo.tblDetalleVenta.VentaId = dbo.tblVenta.Id
GO
/****** Object:  View [dbo].[View_1]    Script Date: 7/24/2019 9:50:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_1]
AS
SELECT        dbo.tblCategoria.Descripcion, dbo.tblProducto.Id, dbo.tblProducto.CategoriaId, dbo.tblProducto.Nombre, dbo.tblProducto.Descripcion AS Expr1, dbo.tblProducto.Stock, dbo.tblProducto.PrecioCompra, dbo.tblProducto.PrecioVenta, 
                         dbo.tblProducto.FechaVencimiento, dbo.tblProducto.Imagen
FROM            dbo.tblCategoria INNER JOIN
                         dbo.tblProducto ON dbo.tblCategoria.Id = dbo.tblProducto.CategoriaId
GO
ALTER TABLE [dbo].[tblDetalleVenta]  WITH CHECK ADD  CONSTRAINT [FK_tblDetalleVenta_tblProducto] FOREIGN KEY([ProductoId])
REFERENCES [dbo].[tblProducto] ([Id])
GO
ALTER TABLE [dbo].[tblDetalleVenta] CHECK CONSTRAINT [FK_tblDetalleVenta_tblProducto]
GO
ALTER TABLE [dbo].[tblDetalleVenta]  WITH CHECK ADD  CONSTRAINT [FK_tblDetalleVenta_tblVenta] FOREIGN KEY([VentaId])
REFERENCES [dbo].[tblVenta] ([Id])
GO
ALTER TABLE [dbo].[tblDetalleVenta] CHECK CONSTRAINT [FK_tblDetalleVenta_tblVenta]
GO
ALTER TABLE [dbo].[tblProducto]  WITH CHECK ADD  CONSTRAINT [FK_tblProducto_tblCategoria] FOREIGN KEY([CategoriaId])
REFERENCES [dbo].[tblCategoria] ([Id])
GO
ALTER TABLE [dbo].[tblProducto] CHECK CONSTRAINT [FK_tblProducto_tblCategoria]
GO
ALTER TABLE [dbo].[tblVenta]  WITH CHECK ADD  CONSTRAINT [FK_tblVenta_tblCliente] FOREIGN KEY([ClienteId])
REFERENCES [dbo].[tblCliente] ([Id])
GO
ALTER TABLE [dbo].[tblVenta] CHECK CONSTRAINT [FK_tblVenta_tblCliente]
GO
/****** Object:  StoredProcedure [dbo].[usp_Data_FCategoria_Actualizar]    Script Date: 7/24/2019 9:50:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[usp_Data_FCategoria_Actualizar] 

(
@Id int,
@Descripcion varchar(300)
)
	
AS

Update tblCategoria set Descripcion=@Descripcion where Id=@Id

Select @@ROWCOUNT as cantidad
GO
/****** Object:  StoredProcedure [dbo].[usp_Data_FCategoria_Eliminar]    Script Date: 7/24/2019 9:50:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_Data_FCategoria_Eliminar] 
	@Id int
AS
BEGIN
	delete from tblCategoria where Id=@Id

	select @@ROWCOUNT as CantidadAfectada
END
GO
/****** Object:  StoredProcedure [dbo].[usp_Data_FCategoria_GetAll]    Script Date: 7/24/2019 9:50:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_Data_FCategoria_GetAll] 
	
AS
BEGIN
	select Id,Descripcion from tblCategoria
END
GO
/****** Object:  StoredProcedure [dbo].[usp_Data_FCategoria_Insertar]    Script Date: 7/24/2019 9:50:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[usp_Data_FCategoria_Insertar] 

(
@Descripcion varchar (300) 
)
	
AS

insert into tblCategoria (Descripcion)
values (@Descripcion)

Select @@IDENTITY
GO
/****** Object:  StoredProcedure [dbo].[usp_Data_FCliente_Actualizar]    Script Date: 7/24/2019 9:50:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_Data_FCliente_Actualizar] 

(
@Id int,
@Nombre varchar (50) ,
@Apellido varchar (50),
@Dni int,
@Domicilio varchar (500) ,
@Telefono varchar (50)
)
	
AS

Update tblCliente set Nombre=@Nombre,Direccion=@Domicilio,Apellido=@Apellido,Dni=@Dni,Telefono=@Telefono where Id=@Id

Select @@ROWCOUNT as cantidad
GO
/****** Object:  StoredProcedure [dbo].[usp_Data_FCliente_Eliminar]    Script Date: 7/24/2019 9:50:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_Data_FCliente_Eliminar] 
	-- Add the parameters for the stored procedure here
	@Id int
AS
BEGIN
	delete from tblCliente where Id=@Id

	select @@ROWCOUNT as CantidadAfectada
END
GO
/****** Object:  StoredProcedure [dbo].[usp_Data_FCliente_GetAll]    Script Date: 7/24/2019 9:50:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_Data_FCliente_GetAll] 
	
AS
BEGIN
	select Id,Nombre,Apellido,Telefono,Dni,Direccion as Domicilio from tblCliente
END
GO
/****** Object:  StoredProcedure [dbo].[usp_Data_FCliente_Insertar]    Script Date: 7/24/2019 9:50:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_Data_FCliente_Insertar] 

(
@Nombre varchar (50) ,
@Apellido varchar (50),
@Dni int,
@Domicilio varchar (500) ,
@Telefono varchar (50)
)
	
AS

insert into tblCliente (Nombre,Apellido,Dni,Telefono,Direccion)
values (@Nombre,@Apellido,@Dni,@Telefono,@Domicilio)

Select @@IDENTITY
GO
/****** Object:  StoredProcedure [dbo].[usp_Data_FDetalleVenta_Actualizar]    Script Date: 7/24/2019 9:50:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Data_FDetalleVenta_Actualizar]
	@Id int,
	@VentaId int, 
	@ProductoId int, 
	@Cantidad decimal(18,2), 
	@PrecioUnitario decimal (18,2)
AS
BEGIN
	update tblDetalleVenta set 
	VentaId=@VentaId, ProductoId=@ProductoId, Cantidad=@Cantidad, PrecioUnitario=@PrecioUnitario
	where Id=@Id
	

	select @@RowCount as CantidadAfectada
END
GO
/****** Object:  StoredProcedure [dbo].[usp_Data_FDetalleVenta_AumentarStock]    Script Date: 7/24/2019 9:50:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Data_FDetalleVenta_AumentarStock]
	@ProductoId int,
	@Cantidad decimal(18,2)
AS
BEGIN
	update tblProducto set Stock = Stock+@Cantidad where Id=@ProductoId
	select @@ROWCOUNT as CantidadAfectada
END
GO
/****** Object:  StoredProcedure [dbo].[usp_Data_FDetalleVenta_DisminuirStock]    Script Date: 7/24/2019 9:50:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Data_FDetalleVenta_DisminuirStock]
	@ProductoId int,
	@Cantidad decimal(18,2)
AS
BEGIN
	update tblProducto set Stock = Stock-@Cantidad where Id=@ProductoId
	select @@ROWCOUNT as CantidadAfectada
END
GO
/****** Object:  StoredProcedure [dbo].[usp_Data_FDetalleVenta_Eliminar]    Script Date: 7/24/2019 9:50:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Data_FDetalleVenta_Eliminar]
	@Id int
AS
BEGIN
	delete from tblDetalleVenta	where Id=@Id
	select @@ROWCOUNT as CantidadAfectada
END
GO
/****** Object:  StoredProcedure [dbo].[usp_Data_FDetalleVenta_GetAll]    Script Date: 7/24/2019 9:50:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Data_FDetalleVenta_GetAll]
	@VentaId int
AS
BEGIN
	SELECT        dbo.tblDetalleVenta.ProductoId,  dbo.tblDetalleVenta.Id, dbo.tblDetalleVenta.VentaId,
					 dbo.tblProducto.Nombre, dbo.tblDetalleVenta.Cantidad, dbo.tblProducto.PrecioVenta, dbo.tblDetalleVenta.PrecioUnitario
	FROM            dbo.tblDetalleVenta INNER JOIN
                         dbo.tblProducto ON dbo.tblDetalleVenta.ProductoId = dbo.tblProducto.Id

				where tblDetalleVenta.VentaId=@VentaId
END
GO
/****** Object:  StoredProcedure [dbo].[usp_Data_FDetalleVenta_Insertar]    Script Date: 7/24/2019 9:50:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Data_FDetalleVenta_Insertar]

	@VentaId int, 
	@ProductoId int, 
	@Cantidad decimal(18,2), 
	@PrecioUnitario decimal (18,2)
AS
BEGIN
	insert into tblDetalleVenta 
	(VentaId, ProductoId, Cantidad, PrecioUnitario)
	values
	(@VentaId, @ProductoId, @Cantidad, @PrecioUnitario)

	select @@IDENTITY as VentaDetalleId
END
GO
/****** Object:  StoredProcedure [dbo].[usp_Data_FLogin_ValidarLogin]    Script Date: 7/24/2019 9:50:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_Data_FLogin_ValidarLogin]
	@Usuario varchar(100),
	@Password varchar(100)
AS
BEGIN
	SELECT [Id], [Nombre], [Apellido], [Dni], [Direccion], [Telefono], [Usuario], [Password], [Tipo] FROM tblUsuario WHERE Usuario=@Usuario and Password=@Password
END
GO
/****** Object:  StoredProcedure [dbo].[usp_Data_FProducto_Actualizar]    Script Date: 7/24/2019 9:50:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_Data_FProducto_Actualizar]

@Id int,
@CategoriaId int,
@Nombre varchar(200),
@Descripcion varchar (1000),
@Stock decimal (10,2),
@PrecioCompra decimal (10,2),
@PrecioVenta decimal (10,2),
@FechaVencimiento DateTime,
@Imagen image
AS
BEGIN
	update tblProducto set CategoriaId=@CategoriaId, Nombre=@Nombre, Descripcion=@Descripcion, Stock=@Stock,
	 PrecioCompra=@PrecioCompra, PrecioVenta=@PrecioVenta, FechaVencimiento=@FechaVencimiento, Imagen=@Imagen 
	 where Id=@Id

	 select @@ROWCOUNT as CantidadAfectada
END
GO
/****** Object:  StoredProcedure [dbo].[usp_Data_FProducto_Eliminar]    Script Date: 7/24/2019 9:50:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[usp_Data_FProducto_Eliminar]

@Id int

AS
BEGIN
	delete from tblProducto where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[usp_Data_FProducto_GetAll]    Script Date: 7/24/2019 9:50:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_Data_FProducto_GetAll] 

AS
BEGIN
	SELECT        dbo.tblCategoria.Descripcion, dbo.tblProducto.Id, dbo.tblProducto.CategoriaId, dbo.tblProducto.Nombre, dbo.tblProducto.Descripcion AS CategoriaDescripcion, dbo.tblProducto.Stock, dbo.tblProducto.PrecioCompra, dbo.tblProducto.PrecioVenta, 
                         dbo.tblProducto.FechaVencimiento, dbo.tblProducto.Imagen
FROM            dbo.tblCategoria INNER JOIN
                         dbo.tblProducto ON dbo.tblCategoria.Id = dbo.tblProducto.CategoriaId
			
END
GO
/****** Object:  StoredProcedure [dbo].[usp_Data_FProducto_Insertar]    Script Date: 7/24/2019 9:50:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_Data_FProducto_Insertar] 

@CategoriaId int,
@Nombre varchar(200),
@Descripcion varchar (1000),
@Stock decimal (10,2),
@PrecioCompra decimal (10,2),
@PrecioVenta decimal (10,2),
@FechaVencimiento DateTime,
@Imagen image
AS
BEGIN
	insert into tblProducto (CategoriaId, Nombre, Descripcion, Stock, PrecioCompra, PrecioVenta, FechaVencimiento, FechaCreado, Imagen)
	values (@CategoriaId, @Nombre, @Descripcion, @Stock, @PrecioCompra, @PrecioVenta, @FechaVencimiento, GETDATE(), @Imagen)

	SELECT @@IDENTITY as ProductoId
END
GO
/****** Object:  StoredProcedure [dbo].[usp_Data_FVenta_Actualizar]    Script Date: 7/24/2019 9:50:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Data_FVenta_Actualizar]
	@Id int, 
	@ClienteId int,
	@FechaVenta DateTime,
	@NumeroDocumento varchar(50),
	@TipoDocumento varchar(100)
AS
BEGIN
	Update tblVenta set	ClienteId=@ClienteId, FechaVenta=@FechaVenta,
	 NumeroDocumento=@NumeroDocumento, TipoDocumento=@TipoDocumento
	Where id=@Id

	select @@ROWCOUNT as CantidadAfectada
END
GO
/****** Object:  StoredProcedure [dbo].[usp_Data_FVenta_eliminar]    Script Date: 7/24/2019 9:50:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Data_FVenta_eliminar]
	@Id int
AS
BEGIN
	Delete from tblVenta where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[usp_Data_FVenta_GetAll]    Script Date: 7/24/2019 9:50:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Data_FVenta_GetAll] 
	
AS
BEGIN

	SELECT        dbo.tblCliente.Nombre, dbo.tblCliente.Apellido, dbo.tblVenta.Id, dbo.tblVenta.ClienteId, dbo.tblVenta.FechaVenta, dbo.tblVenta.NumeroDocumento, dbo.tblVenta.TipoDocumento
FROM            dbo.tblCliente INNER JOIN
                         dbo.tblVenta ON dbo.tblCliente.Id = dbo.tblVenta.ClienteId
END
GO
/****** Object:  StoredProcedure [dbo].[usp_Data_FVenta_Insertar]    Script Date: 7/24/2019 9:50:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Data_FVenta_Insertar] 
	@ClienteId int,
	@FechaVenta DateTime,
	@NumeroDocumento varchar(50),
	@TipoDocumento varchar(100)
AS
BEGIN
	insert into tblVenta
	(ClienteId, FechaVenta, NumeroDocumento, TipoDocumento)
	values
	(@ClienteId, @FechaVenta, @NumeroDocumento, @TipoDocumento)

	select @@IDENTITY as VentaId
END
GO
/****** Object:  StoredProcedure [dbo].[usp_Reportes_GenerarReporteVenta]    Script Date: 7/24/2019 9:50:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Reportes_GenerarReporteVenta] 
	@VentaId int
AS
BEGIN
	SELECT        dbo.tblDetalleVenta.VentaId, dbo.tblDetalleVenta.Cantidad, dbo.tblDetalleVenta.PrecioUnitario, dbo.tblVenta.FechaVenta, dbo.tblVenta.NumeroDocumento, dbo.tblVenta.TipoDocumento, dbo.tblCliente.Nombre, 
                         dbo.tblCliente.Apellido, dbo.tblCliente.Dni, dbo.tblProducto.Nombre AS ProductoDescripcion, dbo.tblDetalleVenta.Cantidad * dbo.tblDetalleVenta.PrecioUnitario AS TotalParcial
FROM            dbo.tblDetalleVenta INNER JOIN
                         dbo.tblVenta ON dbo.tblDetalleVenta.VentaId = dbo.tblVenta.Id INNER JOIN
                         dbo.tblCliente ON dbo.tblVenta.ClienteId = dbo.tblCliente.Id INNER JOIN
                         dbo.tblProducto ON dbo.tblDetalleVenta.ProductoId = dbo.tblProducto.Id where tblVenta.Id= @VentaId
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tblCategoria"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 102
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblProducto"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 433
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tblCliente"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblVenta"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 442
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tblDetalleVenta"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "tblProducto"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 241
               Right = 433
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblVenta"
            Begin Extent = 
               Top = 6
               Left = 471
               Bottom = 136
               Right = 667
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tblProducto"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 243
               Right = 537
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblDetalleVenta"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 155
               Right = 209
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_4'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_4'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[48] 4[13] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tblCategoria"
            Begin Extent = 
               Top = 125
               Left = 1274
               Bottom = 244
               Right = 1468
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblCliente"
            Begin Extent = 
               Top = 334
               Left = 590
               Bottom = 497
               Right = 784
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblDetalleVenta"
            Begin Extent = 
               Top = 24
               Left = 181
               Bottom = 187
               Right = 375
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblProducto"
            Begin Extent = 
               Top = 36
               Left = 618
               Bottom = 199
               Right = 834
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblUsuario"
            Begin Extent = 
               Top = 358
               Left = 182
               Bottom = 521
               Right = 376
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblVenta"
            Begin Extent = 
               Top = 194
               Left = 208
               Bottom = 357
               Right = 435
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
        ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vista ventas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vista ventas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vista ventas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tblDetalleVenta"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 153
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblVenta"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 157
               Right = 442
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblCliente"
            Begin Extent = 
               Top = 6
               Left = 482
               Bottom = 171
               Right = 650
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblProducto"
            Begin Extent = 
               Top = 6
               Left = 692
               Bottom = 240
               Right = 875
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 11
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or =' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VistaReporteVenta'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VistaReporteVenta'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VistaReporteVenta'
GO
USE [master]
GO
ALTER DATABASE [DBVenta] SET  READ_WRITE 
GO
