USE [namnt_baotinsoftware.com.vn]
GO
/****** Object:  UserDefinedFunction [dbo].[f_GetGROUP_NEWS_InParent]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[f_GetGROUP_NEWS_InParent]
(
	@ID int
)
RETURNS @Items TABLE
(
	ID int
)
AS
BEGIN
	WITH RecursionCTE (ID)
	AS
	(
	   SELECT ID
	   FROM GROUP_NEWS
	   WHERE ID = @ID
	   
	   UNION ALL

	   SELECT R1.ID
	   FROM GROUP_NEWS as R1
	   JOIN RecursionCTE as R2 on R1.ParentID = R2.ID	   
	)
	INSERT INTO @Items SELECT ID FROM RecursionCTE
RETURN;
END

GO
/****** Object:  UserDefinedFunction [dbo].[f_GetGROUP_PRODUCTS_InParent]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[f_GetGROUP_PRODUCTS_InParent]
(
	@ID int
)
RETURNS @Items TABLE
(
	ID int
)
AS
BEGIN
	WITH RecursionCTE (ID)
	AS
	(
	   SELECT ID
	   FROM GROUP_PRODUCTS
	   WHERE ID = @ID
	   
	   UNION ALL

	   SELECT R1.ID
	   FROM GROUP_PRODUCTS as R1
	   JOIN RecursionCTE as R2 on R1.ParentID = R2.ID	   
	)
	INSERT INTO @Items SELECT ID FROM RecursionCTE
RETURN;
END

GO
/****** Object:  UserDefinedFunction [dbo].[f_GetGROUP_SERVICES_InParent]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[f_GetGROUP_SERVICES_InParent]
(
	@ID int
)
RETURNS @Items TABLE
(
	ID int
)
AS
BEGIN
	WITH RecursionCTE (ID)
	AS
	(
	   SELECT ID
	   FROM GROUP_SERVICES
	   WHERE ID = @ID
	   
	   UNION ALL

	   SELECT R1.ID
	   FROM GROUP_SERVICES as R1
	   JOIN RecursionCTE as R2 on R1.ParentID = R2.ID	   
	)
	INSERT INTO @Items SELECT ID FROM RecursionCTE
RETURN;
END

GO
/****** Object:  UserDefinedFunction [dbo].[fc_ConvertStringVietnamese]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fc_ConvertStringVietnamese]
(
	@strInput NVARCHAR(MAX) 
)
RETURNS NVARCHAR(MAX)
AS
BEGIN    
    IF (@strInput IS NULL OR @strInput = '')  RETURN ''
   
    DECLARE @RT NVARCHAR(MAX)
    DECLARE @SIGN_CHARS NCHAR(256)
    DECLARE @UNSIGN_CHARS NCHAR (256)
 
    SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệếìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵýĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' + NCHAR(272) + NCHAR(208)
    SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeeeiiiiiooooooooooooooouuuuuuuuuuyyyyyAADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIIIOOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD'
 
    DECLARE @COUNTER int
    DECLARE @COUNTER1 int
   
    SET @COUNTER = 1
    WHILE (@COUNTER <= LEN(@strInput))
    BEGIN  
        SET @COUNTER1 = 1
        WHILE (@COUNTER1 <= LEN(@SIGN_CHARS) + 1)
        BEGIN
            IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1))
            BEGIN          
                IF @COUNTER = 1
                    SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1)      
                ELSE
                    SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER)
                BREAK
            END
            SET @COUNTER1 = @COUNTER1 +1
        END
        SET @COUNTER = @COUNTER +1
    END
    -- Return ra kiểu URL
    -- SET @strInput = LOWER(replace(@strInput,' ','-'))    
    RETURN LOWER(@strInput)
END

GO
/****** Object:  Table [dbo].[BANNERS]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BANNERS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](250) NULL,
	[Content] [nvarchar](450) NULL,
	[Image] [nvarchar](max) NULL,
	[Href] [nvarchar](max) NULL,
	[Position] [int] NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_BANNERS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[COLORS]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COLORS](
	[ColorId] [int] IDENTITY(1,1) NOT NULL,
	[Hex] [nvarchar](50) NULL,
	[Note] [nvarchar](250) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_COLORS] PRIMARY KEY CLUSTERED 
(
	[ColorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Comment]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[CommentId] [int] IDENTITY(1,1) NOT NULL,
	[LinkId] [int] NULL,
	[Avatar] [nvarchar](250) NULL,
	[Content] [nvarchar](550) NULL,
	[Name] [nvarchar](150) NULL,
	[Email] [nvarchar](150) NULL,
	[AttachFile] [nvarchar](max) NULL,
	[ProvinceId] [int] NULL,
	[DateCreated] [datetime] NULL,
	[ParentId] [int] NULL,
	[Position] [int] NULL,
	[IsActive] [bit] NULL,
	[IsDisable] [bit] NULL,
	[TypeId] [int] NULL,
 CONSTRAINT [PK_Comment] PRIMARY KEY CLUSTERED 
(
	[CommentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CONTACTS]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CONTACTS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NULL,
	[Title] [nvarchar](150) NULL,
	[Email] [nvarchar](150) NULL,
	[Phone] [nvarchar](50) NULL,
	[Content] [nvarchar](550) NULL,
	[Status] [int] NULL,
	[Date] [datetime] NULL,
 CONSTRAINT [PK_CONTACT] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DOWNLOAD]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DOWNLOAD](
	[DownloadId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[Path] [nvarchar](550) NULL,
	[Description] [nvarchar](550) NULL,
	[Size] [nvarchar](50) NULL,
	[Date] [datetime] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_DOWNLOAD] PRIMARY KEY CLUSTERED 
(
	[DownloadId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GALLERY]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GALLERY](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](250) NULL,
	[Href] [nvarchar](450) NULL,
	[Content] [nvarchar](max) NULL,
	[Date] [datetime] NULL,
	[ID_GroupGallery] [int] NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_GALLERY] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GROUP_GALLERY]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GROUP_GALLERY](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[Tag] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[Active] [bit] NULL,
	[Position] [int] NULL,
	[Parent_ID] [int] NULL,
 CONSTRAINT [PK_GROUP_GALLERY] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GROUP_NEWS]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GROUP_NEWS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[Tag] [nvarchar](250) NULL,
	[Position] [int] NULL,
	[Description] [nvarchar](250) NULL,
	[Active] [bit] NULL,
	[ParentID] [int] NULL,
 CONSTRAINT [PK_GROUP_NEWS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GROUP_PRODUCTS]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GROUP_PRODUCTS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[Tag] [nvarchar](450) NULL,
	[Position] [int] NULL,
	[Description] [nvarchar](max) NULL,
	[ParentID] [int] NULL,
	[Image] [nvarchar](450) NULL,
	[Active] [bit] NULL,
	[IsHot] [bit] NULL,
 CONSTRAINT [PK_GROUP_PRODUCTS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GROUP_SERVICES]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GROUP_SERVICES](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](550) NULL,
	[Tag] [nvarchar](550) NULL,
	[Position] [int] NULL,
	[Description] [nvarchar](max) NULL,
	[Active] [bit] NULL,
	[ParentID] [int] NULL,
	[Image] [nvarchar](550) NULL,
 CONSTRAINT [PK_GROUP_SERVICES] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HashTag]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[HashTag](
	[HashTagId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NULL,
	[Alias] [varchar](250) NULL,
	[IsHot] [bit] NULL,
	[IsActive] [bit] NULL,
	[IsEnable] [bit] NULL,
 CONSTRAINT [PK_HashTag] PRIMARY KEY CLUSTERED 
(
	[HashTagId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[HashTagLink]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HashTagLink](
	[HashTagLinkId] [int] IDENTITY(1,1) NOT NULL,
	[HashTagId] [int] NOT NULL,
	[LinkId] [int] NOT NULL,
	[TypeId] [int] NOT NULL,
 CONSTRAINT [PK_HashTagLink] PRIMARY KEY CLUSTERED 
(
	[HashTagLinkId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LINKS]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LINKS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[Href] [nvarchar](max) NULL,
	[Image] [nvarchar](max) NULL,
 CONSTRAINT [PK_LINKS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NEWS]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NEWS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](250) NULL,
	[Tag] [nvarchar](350) NULL,
	[News_Sapo] [nvarchar](max) NULL,
	[Image] [nvarchar](450) NULL,
	[Content] [nvarchar](max) NULL,
	[IsHot] [bit] NULL,
	[TotalView] [int] NULL,
	[Date] [datetime] NULL,
	[ID_UserPost] [int] NULL,
	[Active] [bit] NULL,
	[ID_GroupNews] [int] NULL,
 CONSTRAINT [PK_NEWS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ORDER_DETAILS]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ORDER_DETAILS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NULL,
	[ProductID] [int] NULL,
	[Quantity] [int] NULL,
	[Price] [decimal](18, 0) NULL,
 CONSTRAINT [PK_ORDER_DETAILS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ORDER_PRODUCTS]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ORDER_PRODUCTS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerName] [nvarchar](250) NULL,
	[Mobile] [nvarchar](50) NULL,
	[Email] [nvarchar](250) NULL,
	[Address] [nvarchar](450) NULL,
	[Date] [datetime] NULL,
	[CustomerNote] [nvarchar](max) NULL,
	[StatusID] [int] NULL,
	[TypePayment] [nvarchar](250) NULL,
	[TypeShipping] [nvarchar](250) NULL,
 CONSTRAINT [PK_ORDERS_PRODUCTS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ORDER_STATUSES]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ORDER_STATUSES](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
 CONSTRAINT [PK_ORDER_STATUSES] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PAGES]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PAGES](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](250) NULL,
	[Content] [nvarchar](max) NULL,
	[Logo] [nvarchar](250) NULL,
	[Slogan] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[Keyword] [nvarchar](max) NULL,
	[Image] [nvarchar](250) NULL,
	[Favicon] [nvarchar](250) NULL,
	[GoogleAnalytics] [nvarchar](max) NULL,
	[MapCode] [nvarchar](550) NULL,
	[Fanpage] [nvarchar](max) NULL,
	[Copyright] [nvarchar](max) NULL,
	[Contact] [nvarchar](max) NULL,
 CONSTRAINT [PK_PAGE] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PRODUCT_COLORS]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCT_COLORS](
	[ProductColorId] [int] IDENTITY(1,1) NOT NULL,
	[ColorId] [int] NULL,
	[ProductId] [int] NULL,
	[Price] [decimal](18, 0) NULL,
 CONSTRAINT [PK_PRODUCT_COLORS] PRIMARY KEY CLUSTERED 
(
	[ProductColorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PRODUCT_IMAGES]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCT_IMAGES](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Path] [nvarchar](550) NULL,
	[Note] [nvarchar](550) NULL,
	[ID_Products] [int] NULL,
 CONSTRAINT [PK_PRODUCT_IMAGES] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PRODUCT_NEWS]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCT_NEWS](
	[ProductNewsId] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NULL,
	[NewsId] [int] NULL,
	[DisplayOrder] [int] NULL,
 CONSTRAINT [PK_PRODUCT_NEWS] PRIMARY KEY CLUSTERED 
(
	[ProductNewsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PRODUCT_SIZES]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCT_SIZES](
	[ProductSizeId] [int] IDENTITY(1,1) NOT NULL,
	[SizeId] [int] NULL,
	[ProductId] [int] NULL,
	[Price] [decimal](18, 0) NULL,
 CONSTRAINT [PK_PRODUCT_SIZES] PRIMARY KEY CLUSTERED 
(
	[ProductSizeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PRODUCT_STATUS]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCT_STATUS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[Tag] [nvarchar](500) NULL,
 CONSTRAINT [PK_PRODUCT_STATUS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PRODUCT_TYPES]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCT_TYPES](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ID_Product] [int] NULL,
	[ID_Type] [int] NULL,
 CONSTRAINT [PK_PRODUCT_TYPES] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PRODUCTS]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCTS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Name] [nvarchar](450) NULL,
	[Tag] [nvarchar](450) NULL,
	[Image] [nvarchar](450) NULL,
	[Sapo] [nvarchar](max) NULL,
	[Content] [ntext] NULL,
	[Price] [decimal](18, 0) NULL,
	[PriceOld] [decimal](18, 0) NULL,
	[ID_GroupProduct] [int] NULL,
	[DatePublish] [datetime] NULL,
	[CountView] [int] NULL,
	[CountBuy] [int] NULL,
	[StatusID] [int] NULL,
	[IsActive] [bit] NULL,
	[IsHot] [bit] NULL,
	[LinkY] [nvarchar](450) NULL,
 CONSTRAINT [PK_PRODUCTS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SERVICES]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SERVICES](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](550) NULL,
	[Tag] [nvarchar](550) NULL,
	[Sub] [nvarchar](max) NULL,
	[Image] [nvarchar](550) NULL,
	[Content] [nvarchar](max) NULL,
	[IsHot] [bit] NULL,
	[TotalView] [int] NULL,
	[Date] [datetime] NULL,
	[ID_UserPost] [int] NULL,
	[Active] [bit] NULL,
	[ID_GroupServices] [int] NULL,
 CONSTRAINT [PK_SERVICES] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SIZES]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SIZES](
	[SizeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[Note] [nvarchar](250) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_SIZES] PRIMARY KEY CLUSTERED 
(
	[SizeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SOCIAL_NETWORK]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SOCIAL_NETWORK](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NULL,
	[Href] [nvarchar](max) NULL,
	[Description] [nvarchar](250) NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_SOCIAL_NETWORK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TYPES]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TYPES](
	[ID_Type] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[Tag] [nvarchar](500) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_TYPES] PRIMARY KEY CLUSTERED 
(
	[ID_Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[USERS]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USERS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](250) NULL,
	[Password] [nvarchar](max) NULL,
	[Fullname] [nvarchar](150) NULL,
	[Image] [nvarchar](550) NULL,
	[Date] [datetime] NULL,
	[Note] [nvarchar](550) NULL,
	[Active] [bit] NULL,
	[Email] [nvarchar](250) NULL,
 CONSTRAINT [PK_USER] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[BANNERS] ON 

INSERT [dbo].[BANNERS] ([ID], [Title], [Content], [Image], [Href], [Position], [Active]) VALUES (1, N'Planning the growth of tomorrow', N'', N'/Upload/images/Banners/baotin-slide-1.jpg', N'#', 1, 1)
INSERT [dbo].[BANNERS] ([ID], [Title], [Content], [Image], [Href], [Position], [Active]) VALUES (3, N'Ensuring the highest level of customers satisfaction', N'', N'/Upload/images/Banners/baotin-slide-2.jpg', N'#', 2, 0)
INSERT [dbo].[BANNERS] ([ID], [Title], [Content], [Image], [Href], [Position], [Active]) VALUES (4, N'Producing measurable results for the customers', N'', N'/Upload/images/Banners/baotin-slide-3.jpg', N'#', 3, 1)
INSERT [dbo].[BANNERS] ([ID], [Title], [Content], [Image], [Href], [Position], [Active]) VALUES (5, N'Developing your opportunities within your business sector', N'', N'/Upload/images/Banners/baotin-slide-4.jpg', N'#', 0, 1)
INSERT [dbo].[BANNERS] ([ID], [Title], [Content], [Image], [Href], [Position], [Active]) VALUES (7, N'Software Technology For Industry', N'', N'/Upload/images/SoftwareTechnology(1).jpg', N'#', 5, 1)
SET IDENTITY_INSERT [dbo].[BANNERS] OFF
SET IDENTITY_INSERT [dbo].[COLORS] ON 

INSERT [dbo].[COLORS] ([ColorId], [Hex], [Note], [IsActive]) VALUES (1, N'#FFF', N'White', 1)
INSERT [dbo].[COLORS] ([ColorId], [Hex], [Note], [IsActive]) VALUES (2, N'#FF0000', N'Red', 1)
INSERT [dbo].[COLORS] ([ColorId], [Hex], [Note], [IsActive]) VALUES (3, N'#000', N'Black', 1)
INSERT [dbo].[COLORS] ([ColorId], [Hex], [Note], [IsActive]) VALUES (4, N'#FFEB3B', N'Yellow', 1)
INSERT [dbo].[COLORS] ([ColorId], [Hex], [Note], [IsActive]) VALUES (5, N'#0000FF', N'Blue', 1)
SET IDENTITY_INSERT [dbo].[COLORS] OFF
SET IDENTITY_INSERT [dbo].[Comment] ON 

INSERT [dbo].[Comment] ([CommentId], [LinkId], [Avatar], [Content], [Name], [Email], [AttachFile], [ProvinceId], [DateCreated], [ParentId], [Position], [IsActive], [IsDisable], [TypeId]) VALUES (5, 4, N'/Theme/photo/avatar-anonymous.png', N'alakakamana test', N'Nam Thành', N'Abc@gmail.com', N'', NULL, CAST(N'2017-12-02 12:04:59.287' AS DateTime), 0, 1, 1, 0, 0)
INSERT [dbo].[Comment] ([CommentId], [LinkId], [Avatar], [Content], [Name], [Email], [AttachFile], [ProvinceId], [DateCreated], [ParentId], [Position], [IsActive], [IsDisable], [TypeId]) VALUES (6, 4, N'/Theme/photo/avatar-anonymous.png', N'hggggththtkkjjkyh', N'Abc!21211', N'namnt@gmail.com', N'', NULL, CAST(N'2017-12-02 12:04:59.287' AS DateTime), 0, 1, 1, 0, 0)
INSERT [dbo].[Comment] ([CommentId], [LinkId], [Avatar], [Content], [Name], [Email], [AttachFile], [ProvinceId], [DateCreated], [ParentId], [Position], [IsActive], [IsDisable], [TypeId]) VALUES (7, 4, N'/Theme/photo/avatar-anonymous.png', N'hggggththtkkjjkyh', N'Abc!21211', N'namnt@gmail.com', N'', NULL, CAST(N'2017-12-02 12:04:59.287' AS DateTime), 0, 1, 1, 0, 0)
INSERT [dbo].[Comment] ([CommentId], [LinkId], [Avatar], [Content], [Name], [Email], [AttachFile], [ProvinceId], [DateCreated], [ParentId], [Position], [IsActive], [IsDisable], [TypeId]) VALUES (8, 4, N'/Upload/images/Comment/namnt_180348.jpg', N'Đời Là Thế @@@ ', N'Abc@xyz', N'Abc@xyz.com', N'/Upload/images/Comment/namnt_180235.jpg,/Upload/images/Comment/namnt_180238.jpg', NULL, CAST(N'2017-12-02 12:04:59.287' AS DateTime), 5, 1, 1, 0, 0)
INSERT [dbo].[Comment] ([CommentId], [LinkId], [Avatar], [Content], [Name], [Email], [AttachFile], [ProvinceId], [DateCreated], [ParentId], [Position], [IsActive], [IsDisable], [TypeId]) VALUES (9, 4, N'/Theme/photo/avatar-anonymous.png', N'The styles and considerations in this technique are pretty much the same as the previous ones, except that instead of styling and positioning an empty element with a class .overlay, we’ll be styling the :before or :after pseudo-element on the body.', N'Nguyễn Thành Nam', N'nam.nt@gmail.com', N'/Upload/images/Comment/namnt_222821.jpg,/Upload/images/Comment/namnt_222824.jpg,/Upload/images/Comment/namnt_222828.jpg', NULL, CAST(N'2017-12-03 22:28:42.637' AS DateTime), 0, 1, 1, 0, 0)
INSERT [dbo].[Comment] ([CommentId], [LinkId], [Avatar], [Content], [Name], [Email], [AttachFile], [ProvinceId], [DateCreated], [ParentId], [Position], [IsActive], [IsDisable], [TypeId]) VALUES (10, 4, N'/Upload/images/Comment/namnt_223324.jpg', N'An important thing to note here is that transitions on pseudo-elements still don’t work on Safari and Mobile Safari, so this is a huge drawback if you’re going to use a pseudo-element to create the overlay, because you won’t be providing your users with entirely smooth overlay effects. This is an im', N'Hoài Thanh', N'hoai.thanh@gmail.com', N'/Upload/images/Comment/namnt_223150.jpg,/Upload/images/Comment/namnt_223154.jpg', NULL, CAST(N'2017-12-03 22:33:24.433' AS DateTime), 9, 1, 1, 0, 0)
INSERT [dbo].[Comment] ([CommentId], [LinkId], [Avatar], [Content], [Name], [Email], [AttachFile], [ProvinceId], [DateCreated], [ParentId], [Position], [IsActive], [IsDisable], [TypeId]) VALUES (11, 4, N'/Upload/images/Comment/namnt_225835.jpg', N'Đối với ngành nhuộm vải, công đoạn nhuộm quyết định 70% chất lượng sản phẩm. Những bất cập đối với các chủ doanh nghiệp như: thời gian vô màu có đúng theo qui trình, nhiệt độ có chạy đúng thời gian theo từng loại mặt hàng hay không, công nhân có thực hiện đúng theo yêu cầu về qui trình đưa ra hay ko', N'Thanh Tùng', N'tung.thanh@gmail.com', N'/Upload/images/Comment/namnt_225803.jpg,/Upload/images/Comment/namnt_225817.jpg,/Upload/images/Comment/namnt_225824.jpg', NULL, CAST(N'2017-12-03 22:58:35.560' AS DateTime), 0, 1, 1, 0, 0)
INSERT [dbo].[Comment] ([CommentId], [LinkId], [Avatar], [Content], [Name], [Email], [AttachFile], [ProvinceId], [DateCreated], [ParentId], [Position], [IsActive], [IsDisable], [TypeId]) VALUES (12, 4, N'/Upload/images/Comment/namnt_231359.jpg', N'Đối với ngành nhuộm vải, công đoạn nhuộm quyết định 70% chất lượng sản phẩm. Những bất cập đối với các chủ doanh nghiệp như: alert(1+2)', N'Đời Là Thế', N'doilathe@gmail.com', N'/Upload/images/Comment/namnt_231205.jpg,/Upload/images/Comment/namnt_231332.jpg,/Upload/images/Comment/namnt_231337.jpg', NULL, CAST(N'2017-12-03 23:13:59.673' AS DateTime), 0, 1, 1, 0, 0)
INSERT [dbo].[Comment] ([CommentId], [LinkId], [Avatar], [Content], [Name], [Email], [AttachFile], [ProvinceId], [DateCreated], [ParentId], [Position], [IsActive], [IsDisable], [TypeId]) VALUES (13, 4, N'/Upload/images/Comment/namnt_232247.jpg', N'jQuery .scrollTo() Method

jQuery .scrollTo(): View - Demo, API, Source

I wrote this lightweight plugin to make page/element scrolling much easier. It''s flexible where you could pass in a target element or specified value. Perhaps this could be part of jQuery''s next official release, what do you', N'Nam Đẹp Trai', N'nam.deptrai@gmail.com', N'/Upload/images/Comment/namnt_232220.jpg,/Upload/images/Comment/namnt_232223.jpg,/Upload/images/Comment/namnt_232240.jpg', NULL, CAST(N'2017-12-03 23:22:47.367' AS DateTime), 0, 1, 1, 0, 0)
INSERT [dbo].[Comment] ([CommentId], [LinkId], [Avatar], [Content], [Name], [Email], [AttachFile], [ProvinceId], [DateCreated], [ParentId], [Position], [IsActive], [IsDisable], [TypeId]) VALUES (14, 7, N'/Upload/images/Comment/namnt_221229.jpg', N'Đối với tên miền quốc tế đăng ký mới khách hàng cần chủ động check email đăng ký dịch vụ để xác nhận thông tin sở hữu với hệ thống trong vòng 15 ngày. Trường hợp tên miền không được xác nhận trong thời gian quy định hệ thống sẽ tự động suspend tên miền.', N'Nam Đẹp Choai', N'nam.nt@harveynash.com', N'/Upload/images/Comment/namnt_221203.jpg,/Upload/images/Comment/namnt_221206.jpg,/Upload/images/Comment/namnt_221220.jpg', NULL, CAST(N'2017-12-04 22:12:29.393' AS DateTime), 0, 1, 1, 0, 0)
INSERT [dbo].[Comment] ([CommentId], [LinkId], [Avatar], [Content], [Name], [Email], [AttachFile], [ProvinceId], [DateCreated], [ParentId], [Position], [IsActive], [IsDisable], [TypeId]) VALUES (15, 15, N'/Upload/images/Comment/namnt_222348.jpg', N'While :first matches only a single element, the :first-child selector can match more than one: one for each parent. This is equivalent to :nth-child(1).', N'Hoài Thanh', N'hoai.thanh@gmail.com', N'/Upload/images/Comment/namnt_222342.jpg,/Upload/images/Comment/namnt_222345.jpg', NULL, CAST(N'2017-12-04 22:23:48.510' AS DateTime), 0, 1, 1, 0, 0)
INSERT [dbo].[Comment] ([CommentId], [LinkId], [Avatar], [Content], [Name], [Email], [AttachFile], [ProvinceId], [DateCreated], [ParentId], [Position], [IsActive], [IsDisable], [TypeId]) VALUES (16, 15, N'/Upload/images/Comment/namnt_222603.jpg', N'jQuery is a fast, small, and feature-rich JavaScript library. It makes things like HTML document traversal and manipulation, event handling, animation, and Ajax much simpler with an easy-to-use API that works across a multitude of browsers. With a combination of versatility and extensibility, jQuery', N'Hà Vân', N'ha.van@gmail.com', N'/Upload/images/Comment/namnt_222553.jpg,/Upload/images/Comment/namnt_222601.png', NULL, CAST(N'2017-12-04 22:26:03.407' AS DateTime), 0, 1, 1, 0, 0)
INSERT [dbo].[Comment] ([CommentId], [LinkId], [Avatar], [Content], [Name], [Email], [AttachFile], [ProvinceId], [DateCreated], [ParentId], [Position], [IsActive], [IsDisable], [TypeId]) VALUES (1009, 15, N'/Upload/images/Icons/user-big.jpg', N'Isco (Real Madrid) và Edinson Cavani (PSG) là 2 ngôi sao đứng thứ 12 và 11. Ngay sau đây sẽ là top 10 cầu thủ xuất sắc nhất thế giới trong năm vừa qua.', N'Systems', N'baotinsoftware@gmail.com', N'"/Upload/images/News_Events/man-three.jpg","/Upload/images/News_Events/man-one.jpg"', 0, CAST(N'2017-12-08 01:18:06.300' AS DateTime), 16, 0, 1, 0, 0)
INSERT [dbo].[Comment] ([CommentId], [LinkId], [Avatar], [Content], [Name], [Email], [AttachFile], [ProvinceId], [DateCreated], [ParentId], [Position], [IsActive], [IsDisable], [TypeId]) VALUES (1010, 7, N'/Upload/images/Comment/namnt_210558.jpg', N'NGUY HIỂM!!! Hazard di chuyển linh hoạt phối hợp với các đồng đội. Một quả tạt được Azpilicueta hướng đến Morata nhưng thủ môn Adrian phán đoán bắt bóng.', N'Nguyễn Tùng Dương', N'duong.nguyentung@gmail.com', N'/Upload/images/Comment/namnt_210540.jpg,/Upload/images/Comment/namnt_210544.jpg,/Upload/images/Comment/namnt_210546.jpg', NULL, CAST(N'2017-12-09 21:05:58.403' AS DateTime), 0, 1, 1, 0, 0)
INSERT [dbo].[Comment] ([CommentId], [LinkId], [Avatar], [Content], [Name], [Email], [AttachFile], [ProvinceId], [DateCreated], [ParentId], [Position], [IsActive], [IsDisable], [TypeId]) VALUES (1011, 7, N'/Upload/images/Comment/namnt_211332.jpg', N'Quang Hải lập cú đúp giúp U23 Việt Nam thắng U23 Myanmar 4-0, tuy nhiên tiền đạo Nguyễn Công Phượng mới được ban tổ chức bầu là người chơi hay nhất trận.', N'Nam Thành Nguyễn', N'nam.nt@gmail.com', N'/Upload/images/Comment/namnt_211012.jpg,/Upload/images/Comment/namnt_211021.jpg,/Upload/images/Comment/namnt_211023.jpg', NULL, CAST(N'2017-12-09 21:13:32.500' AS DateTime), 0, 1, 1, 0, 0)
INSERT [dbo].[Comment] ([CommentId], [LinkId], [Avatar], [Content], [Name], [Email], [AttachFile], [ProvinceId], [DateCreated], [ParentId], [Position], [IsActive], [IsDisable], [TypeId]) VALUES (1012, 7, N'/Upload/images/Comment/namnt_211710.jpg', N'We have been supporting many of the world’s leading organizations to deliver the right technology solutions to support their business needs since 2000.', N'Tào Lao Mía Lao', N'taolao@gmail.com', N'/Upload/images/Comment/namnt_211659.jpg,/Upload/images/Comment/namnt_211707.jpg', NULL, CAST(N'2017-12-09 21:17:10.367' AS DateTime), 0, 1, 1, 0, 0)
INSERT [dbo].[Comment] ([CommentId], [LinkId], [Avatar], [Content], [Name], [Email], [AttachFile], [ProvinceId], [DateCreated], [ParentId], [Position], [IsActive], [IsDisable], [TypeId]) VALUES (1013, 7, N'/Upload/images/Comment/namnt_212228.jpg', N'The Bridge SE is responsible for bridging between Japanese customers and offshore project teams in Vietnam, being able to work for a short term or long term in Japan. Reporting directly to Line Manager and for specific project related items to the project manager or delivery manager and has authorit', N'Real Madrid Fc', N'realmadrid@gmail.com', N'/Upload/images/Comment/namnt_212220.jpg,/Upload/images/Comment/namnt_212223.jpg', NULL, CAST(N'2017-12-09 21:22:28.867' AS DateTime), 0, 1, 1, 0, 0)
INSERT [dbo].[Comment] ([CommentId], [LinkId], [Avatar], [Content], [Name], [Email], [AttachFile], [ProvinceId], [DateCreated], [ParentId], [Position], [IsActive], [IsDisable], [TypeId]) VALUES (1014, 7, N'/Upload/images/Icons/user-big.jpg', N'Cuộc sống như thước phim. Khi bạn khó khăn hoạn nạn, được bao nhiêu người thân, bạn bè giúp đỡ, hay chỉ biết đứng nhìn mình vùng vẫy qua khó khăn.
Đôi khi những sự giúp đỡ lại đến từ những người xa lạ, không quen biết.', N'Systems', N'baotinsoftware@gmail.com', N'/Upload/images/Comment/namnt_210540.jpg', 0, CAST(N'2017-12-10 00:44:11.277' AS DateTime), 1013, 0, 1, 0, 0)
INSERT [dbo].[Comment] ([CommentId], [LinkId], [Avatar], [Content], [Name], [Email], [AttachFile], [ProvinceId], [DateCreated], [ParentId], [Position], [IsActive], [IsDisable], [TypeId]) VALUES (1015, 7, N'/Upload/images/Icons/user-big.jpg', N'Cuộc sống như thước phim. Khi bạn khó khăn hoạn nạn, được bao nhiêu người thân, bạn bè giúp đỡ, hay chỉ biết đứng nhìn mình vùng vẫy qua khó khăn.
Đôi khi những sự giúp đỡ lại đến từ những người xa lạ, không quen biết.', N'Systems', N'baotinsoftware@gmail.com', N'/Upload/images/Comment/namnt_210544.jpg', 0, CAST(N'2017-12-10 00:45:43.793' AS DateTime), 1013, 0, 1, 0, 0)
INSERT [dbo].[Comment] ([CommentId], [LinkId], [Avatar], [Content], [Name], [Email], [AttachFile], [ProvinceId], [DateCreated], [ParentId], [Position], [IsActive], [IsDisable], [TypeId]) VALUES (1016, 4, N'/Upload/images/Comment/namnt_010008.jpg', N'Đối với ngành nhuộm vải, công đoạn nhuộm quyết định 70% chất lượng sản phẩm. Những bất cập đối với các chủ doanh nghiệp như: thời gian vô màu có đúng theo qui trình, nhiệt độ có chạy đúng thời gian theo từng loại mặt hàng hay không, công nhân có thực hiện đúng theo yêu cầu về qui trình đưa ra hay kh', N'Tùng Dương Dương', N'namnguyen1251@gmail.com', N'/Upload/images/Comment/namnt_005940.png,/Upload/images/Comment/namnt_005947.jpg', NULL, CAST(N'2017-12-14 01:00:08.433' AS DateTime), 0, 1, 1, 0, 0)
INSERT [dbo].[Comment] ([CommentId], [LinkId], [Avatar], [Content], [Name], [Email], [AttachFile], [ProvinceId], [DateCreated], [ParentId], [Position], [IsActive], [IsDisable], [TypeId]) VALUES (1017, 4, N'/Upload/images/Comment/namnt_011641.jpg', N'Đối với ngành nhuộm vải, công đoạn nhuộm quyết định 70% chất lượng sản phẩm. Những bất cập đối với các chủ doanh nghiệp như: thời gian vô màu có đúng theo qui trình, nhiệt độ có chạy đúng thời gian theo từng loại mặt hàng hay không, công nhân có thực hiện đúng theo yêu cầu', N'Nguyễn Tùng Dương', N'namnguyen1251@gmail.com', N'/Upload/images/Comment/namnt_011636.jpg', NULL, CAST(N'2017-12-14 01:16:41.313' AS DateTime), 0, 1, 1, 0, 0)
INSERT [dbo].[Comment] ([CommentId], [LinkId], [Avatar], [Content], [Name], [Email], [AttachFile], [ProvinceId], [DateCreated], [ParentId], [Position], [IsActive], [IsDisable], [TypeId]) VALUES (1018, 4, N'/Upload/images/Icons/user-big.jpg', N'Đến hẹn lại lên, năm nay với thể thức mới - tất cả các bạn - các Troller đều có thể bỏ phiếu bình chọn.

Cả nhà đọc kĩ thể lệ và bỏ phiếu tại đây nha:', N'Systems', N'baotinsoftware@gmail.com', N'/Upload/images/Products/bach-tuoc-nhoi-mau-xanh.jpg', 0, CAST(N'2017-12-14 23:18:37.257' AS DateTime), 1017, 0, 1, 0, 0)
SET IDENTITY_INSERT [dbo].[Comment] OFF
SET IDENTITY_INSERT [dbo].[CONTACTS] ON 

INSERT [dbo].[CONTACTS] ([ID], [Name], [Title], [Email], [Phone], [Content], [Status], [Date]) VALUES (27, N'Nguyen Cuong', N'Phần mềm quản lý cân hóa chất - Nhà máy nhuộm', N'xuancuongnguyen1992@yahoo.com', N'0931104527', N'Gia va cach su dung', 0, CAST(N'2017-08-04 18:19:30.367' AS DateTime))
SET IDENTITY_INSERT [dbo].[CONTACTS] OFF
SET IDENTITY_INSERT [dbo].[DOWNLOAD] ON 

INSERT [dbo].[DOWNLOAD] ([DownloadId], [Name], [Path], [Description], [Size], [Date], [IsActive]) VALUES (9, N'Hệ thống cân chất lỏng tự động - AutoPump', N'/Upload/images/Documents/CWAuto-Pump.pdf', N'Hệ thống cân chất lỏng tự động - AutoPump', N'2.123 Kb', CAST(N'2016-08-21 10:32:02.647' AS DateTime), 1)
INSERT [dbo].[DOWNLOAD] ([DownloadId], [Name], [Path], [Description], [Size], [Date], [IsActive]) VALUES (10, N'Hệ thống cân hóa chất - Chemical Station V.1.3', N'/Upload/images/Documents/ChemicalStation.pdf', N'Hệ thống cân hóa chất - Chemical Station V.1.3', N'1.949 Kb', CAST(N'2016-08-21 10:50:53.257' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[DOWNLOAD] OFF
SET IDENTITY_INSERT [dbo].[GALLERY] ON 

INSERT [dbo].[GALLERY] ([ID], [Title], [Href], [Content], [Date], [ID_GroupGallery], [Active]) VALUES (6, N'CÔNG TY TNHH SX TM SƠN TIÊN', N'/Upload/images/Parner/ST-LOGO2.jpg', N'#', CAST(N'2015-10-10 00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[GALLERY] ([ID], [Title], [Href], [Content], [Date], [ID_GroupGallery], [Active]) VALUES (8, N'CÔNG TY TNHH DỆT NHUỘM HƯNG PHÁT ĐẠT', N'/Upload/images/Parner/HPD-LOGO.jpg', N'#', CAST(N'2015-10-10 00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[GALLERY] ([ID], [Title], [Href], [Content], [Date], [ID_GroupGallery], [Active]) VALUES (25, N'CÔNG TY TNHH SX TM THIÊN PHÚ THỊNH', N'/Upload/images/Parner/TPT1-LOGO.jpg', N'#', CAST(N'2016-10-14 14:15:20.343' AS DateTime), 1, 1)
INSERT [dbo].[GALLERY] ([ID], [Title], [Href], [Content], [Date], [ID_GroupGallery], [Active]) VALUES (26, N'CÔNG TY CỔ PHẦN DỆT PHƯỚC THỊNH', N'/Upload/images/Parner/PT-LOGO.jpg', N'#', CAST(N'2016-10-14 14:16:26.767' AS DateTime), 1, 1)
INSERT [dbo].[GALLERY] ([ID], [Title], [Href], [Content], [Date], [ID_GroupGallery], [Active]) VALUES (27, N'CÔNG TY TNHH SX TM TRANG KIỂM', N'/Upload/images/Parner/TK-LOGO.jpg', N'#', CAST(N'2016-10-14 14:58:56.133' AS DateTime), 1, 1)
INSERT [dbo].[GALLERY] ([ID], [Title], [Href], [Content], [Date], [ID_GroupGallery], [Active]) VALUES (28, N'CÔNG TY TNHH SX TM XNK SONG THỦY H.K', N'/Upload/images/Parner/STHK-SOLO.jpg', N'#', CAST(N'2016-10-14 15:01:29.607' AS DateTime), 1, 1)
INSERT [dbo].[GALLERY] ([ID], [Title], [Href], [Content], [Date], [ID_GroupGallery], [Active]) VALUES (29, N'CÔNG TY TNHH DT SX TM GIA ANH', N'/Upload/images/Parner/GIAANH.jpg', N'#', CAST(N'2016-12-05 09:21:47.797' AS DateTime), 1, 1)
INSERT [dbo].[GALLERY] ([ID], [Title], [Href], [Content], [Date], [ID_GroupGallery], [Active]) VALUES (31, N'CÔNG TY TNHH PHÚ THUẬN HƯNG', N'/Upload/images/Parner/PTH-LOGO1.jpg', N'#', CAST(N'2017-04-17 08:16:14.023' AS DateTime), 1, 1)
SET IDENTITY_INSERT [dbo].[GALLERY] OFF
SET IDENTITY_INSERT [dbo].[GROUP_GALLERY] ON 

INSERT [dbo].[GROUP_GALLERY] ([ID], [Name], [Tag], [Description], [Active], [Position], [Parent_ID]) VALUES (1, N'Strategic Partners', N'strategic-partners', N'Logo Our Strategic Partners', 1, 0, NULL)
INSERT [dbo].[GROUP_GALLERY] ([ID], [Name], [Tag], [Description], [Active], [Position], [Parent_ID]) VALUES (25, N'OUR PARTNERS PROVIDING PRIVILEGES', N'our-partners-providing-privileges', N'Logo Our Partners Providing Privileges', 1, 1, NULL)
SET IDENTITY_INSERT [dbo].[GROUP_GALLERY] OFF
SET IDENTITY_INSERT [dbo].[GROUP_NEWS] ON 

INSERT [dbo].[GROUP_NEWS] ([ID], [Name], [Tag], [Position], [Description], [Active], [ParentID]) VALUES (1, N'Giới thiệu', N'gioi-thieu', 0, N'Giới thiệu', 1, 0)
INSERT [dbo].[GROUP_NEWS] ([ID], [Name], [Tag], [Position], [Description], [Active], [ParentID]) VALUES (2, N'Tin tức', N'tin-tuc', 1, N'News & Events', 1, 0)
INSERT [dbo].[GROUP_NEWS] ([ID], [Name], [Tag], [Position], [Description], [Active], [ParentID]) VALUES (7, N'Dịch vụ', N'dich-vu', 2, N'Dịch vụ chúng tôi', 1, 0)
INSERT [dbo].[GROUP_NEWS] ([ID], [Name], [Tag], [Position], [Description], [Active], [ParentID]) VALUES (12, N'Hỗ trợ khách hàng', N'ho-tro-khach-hang', 3, N'Hỗ trợ khách hàng', 1, 0)
SET IDENTITY_INSERT [dbo].[GROUP_NEWS] OFF
SET IDENTITY_INSERT [dbo].[GROUP_PRODUCTS] ON 

INSERT [dbo].[GROUP_PRODUCTS] ([ID], [Name], [Tag], [Position], [Description], [ParentID], [Image], [Active], [IsHot]) VALUES (2, N'Phần mềm chuyên dụng', N'phan-mem-chuyen-dung', 0, N'Phần mềm chuyên dụng', 0, N'', 1, 1)
INSERT [dbo].[GROUP_PRODUCTS] ([ID], [Name], [Tag], [Position], [Description], [ParentID], [Image], [Active], [IsHot]) VALUES (5, N'Chuyên dụng cho nhà máy nhuộm', N'chuyen-dung-cho-nha-may-nhuom', 1, N'Chuyên dụng cho nhà máy nhuộm', 2, N'', 1, 0)
INSERT [dbo].[GROUP_PRODUCTS] ([ID], [Name], [Tag], [Position], [Description], [ParentID], [Image], [Active], [IsHot]) VALUES (7, N'Chuyên dụng cho nhà máy Dệt', N'chuyen-dung-cho-nha-may-det', 2, N'Chuyên dụng cho nhà máy Dệt', 2, N'', 1, 0)
INSERT [dbo].[GROUP_PRODUCTS] ([ID], [Name], [Tag], [Position], [Description], [ParentID], [Image], [Active], [IsHot]) VALUES (8, N'Hệ thống tự động', N'he-thong-tu-dong', 1, N'Hệ thống tự động & bán tự động', 0, N'', 1, 1)
INSERT [dbo].[GROUP_PRODUCTS] ([ID], [Name], [Tag], [Position], [Description], [ParentID], [Image], [Active], [IsHot]) VALUES (9, N'Hệ thống bán tự động', N'he-thong-ban-tu-dong', 2, N'Hệ thống bán tự động', 0, N'', 1, 1)
INSERT [dbo].[GROUP_PRODUCTS] ([ID], [Name], [Tag], [Position], [Description], [ParentID], [Image], [Active], [IsHot]) VALUES (10, N'Hệ thống cân chất lỏng tự động', N'he-thong-can-chat-long-tu-dong', 1, N'Hệ thống cân chất lỏng tự động', 8, N'', 1, 0)
INSERT [dbo].[GROUP_PRODUCTS] ([ID], [Name], [Tag], [Position], [Description], [ParentID], [Image], [Active], [IsHot]) VALUES (11, N'Hệ thống cân thuốc nhuộm', N'he-thong-can-thuoc-nhuom', 1, N'Hệ thống cân thuốc nhuộm', 9, N'', 1, 0)
INSERT [dbo].[GROUP_PRODUCTS] ([ID], [Name], [Tag], [Position], [Description], [ParentID], [Image], [Active], [IsHot]) VALUES (13, N'Phần mềm quản lý máy dệt', N'phan-mem-quan-ly-may-det', 3, N'Phần mềm quản lý máy dệt', 2, N'', 0, 1)
INSERT [dbo].[GROUP_PRODUCTS] ([ID], [Name], [Tag], [Position], [Description], [ParentID], [Image], [Active], [IsHot]) VALUES (15, N'Cân điện tử', N'can-dien-tu', 2, N'Cân điện tử', 20, N'', 1, 0)
INSERT [dbo].[GROUP_PRODUCTS] ([ID], [Name], [Tag], [Position], [Description], [ParentID], [Image], [Active], [IsHot]) VALUES (16, N'Hệ thống ghi nhận nhiệt độ máy nhuộm', N'he-thong-ghi-nhan-nhiet-do-may-nhuom', 2, N'Hệ thống ghi nhận nhiệt độ máy nhuộm', 8, N'', 1, 0)
INSERT [dbo].[GROUP_PRODUCTS] ([ID], [Name], [Tag], [Position], [Description], [ParentID], [Image], [Active], [IsHot]) VALUES (17, N'Danh mục sản phẩm BBB', N'danh-muc-san-pham-bbb', 2, N'Danh mục sản phẩm BBB', 9, N'', 0, NULL)
INSERT [dbo].[GROUP_PRODUCTS] ([ID], [Name], [Tag], [Position], [Description], [ParentID], [Image], [Active], [IsHot]) VALUES (18, N'Danh mục sản phẩm CCC', N'danh-muc-san-pham-ccc', 3, N'Danh mục sản phẩm CCC', 9, N'', 0, NULL)
INSERT [dbo].[GROUP_PRODUCTS] ([ID], [Name], [Tag], [Position], [Description], [ParentID], [Image], [Active], [IsHot]) VALUES (19, N'Hệ thống cân chất lỏng tự động - MultiLine Auto', N'he-thong-can-chat-long-tu-dong-multiline-auto', 3, N'Hệ thống cân chất lỏng tự động - MultiLine Auto', 8, N'', 0, 1)
INSERT [dbo].[GROUP_PRODUCTS] ([ID], [Name], [Tag], [Position], [Description], [ParentID], [Image], [Active], [IsHot]) VALUES (20, N'Thiết bị', N'thiet-bi', 4, N'Thiết bị', 0, N'', 1, 0)
INSERT [dbo].[GROUP_PRODUCTS] ([ID], [Name], [Tag], [Position], [Description], [ParentID], [Image], [Active], [IsHot]) VALUES (21, N'Giấy Decal & Ribbon', N'giay-decal-ribbon', 5, N'Giấy Decal & Ribbon', 0, N'', 1, 0)
INSERT [dbo].[GROUP_PRODUCTS] ([ID], [Name], [Tag], [Position], [Description], [ParentID], [Image], [Active], [IsHot]) VALUES (22, N'Team - Mực in chính hãng', N'team-muc-in-chinh-hang', 7, N'Team - Mực in chính hãng', 21, N'', 1, 0)
INSERT [dbo].[GROUP_PRODUCTS] ([ID], [Name], [Tag], [Position], [Description], [ParentID], [Image], [Active], [IsHot]) VALUES (23, N'Phần mềm quản lý bán hàng - Mộc', N'phan-mem-quan-ly-ban-hang-moc', 1, N'Phần mềm quản lý bán hàng - Mộc', 25, N'', 0, NULL)
INSERT [dbo].[GROUP_PRODUCTS] ([ID], [Name], [Tag], [Position], [Description], [ParentID], [Image], [Active], [IsHot]) VALUES (24, N'Thiết bị công nghiệp', N'thiet-bi-cong-nghiep', 1, N'Thiết bị công nghiệp', 20, N'', 1, NULL)
INSERT [dbo].[GROUP_PRODUCTS] ([ID], [Name], [Tag], [Position], [Description], [ParentID], [Image], [Active], [IsHot]) VALUES (25, N'Phần mềm quản lý bán hàng', N'phan-mem-quan-ly-ban-hang', 3, N'Phần mềm quản lý bán hàng', 0, N'', 1, 0)
INSERT [dbo].[GROUP_PRODUCTS] ([ID], [Name], [Tag], [Position], [Description], [ParentID], [Image], [Active], [IsHot]) VALUES (26, N'Phần mềm quản lý bán vải V1.3', N'phan-mem-quan-ly-ban-vai-v13', 1, N'Phần mềm quản lý cửa hàng bán vải mộc', 25, N'', 1, 0)
SET IDENTITY_INSERT [dbo].[GROUP_PRODUCTS] OFF
SET IDENTITY_INSERT [dbo].[GROUP_SERVICES] ON 

INSERT [dbo].[GROUP_SERVICES] ([ID], [Name], [Tag], [Position], [Description], [Active], [ParentID], [Image]) VALUES (1, N'Our Services', N'our-services', 0, N'<h4>FAST &amp; TAP <span>are the two pillars of our business in helping your business</span></h4>', 1, 0, NULL)
INSERT [dbo].[GROUP_SERVICES] ([ID], [Name], [Tag], [Position], [Description], [Active], [ParentID], [Image]) VALUES (2, N'Fast', N'fast', 0, N'<h4>FACILITIES, ADMINISTRATIVE, SITE MANAGEMENT & TRAVEL-RELATED</h4><p>
							FAST services cover the full range of company-related activities that make up day-to-day operations, 
							so that your operational costs go down and your business efficiency goes up.  
							FAST services are designed to make your company cost-efficient, so that your customers benefit from 
							your efficiency and cost-competitiveness in serving them.
						</p>', 1, 1, N'<i class="fa fa-fw fa-fax fa-2x"></i>')
INSERT [dbo].[GROUP_SERVICES] ([ID], [Name], [Tag], [Position], [Description], [Active], [ParentID], [Image]) VALUES (3, N'Tap', N'tap', 1, N'<h4>TECHNOLOGY AND PRODUCTIVITY (TAP) SERVICES</h4><p>
							TAP services are designed for you to tap into the latest technologies and processes, productivity tools, management tools, human resource (HR) upgrading and improvement tools and sources of relevant knowledge and training that will keep your company continuously ahead of your competitors, and be at the forefront of new opportunities for steady expansion and growth of the business.
						</p>', 1, 1, N'<i class="fa fa-fw fa-gears fa-2x"></i>')
INSERT [dbo].[GROUP_SERVICES] ([ID], [Name], [Tag], [Position], [Description], [Active], [ParentID], [Image]) VALUES (4, N'Office Supplies', N'office-supplies', 2, N'', 1, 1, N'<i class="fa fa-fw fa-desktop fa-2x"></i>')
SET IDENTITY_INSERT [dbo].[GROUP_SERVICES] OFF
SET IDENTITY_INSERT [dbo].[HashTag] ON 

INSERT [dbo].[HashTag] ([HashTagId], [Name], [Alias], [IsHot], [IsActive], [IsEnable]) VALUES (25, N'hashtag', N'hashtag', 0, 1, NULL)
INSERT [dbo].[HashTag] ([HashTagId], [Name], [Alias], [IsHot], [IsActive], [IsEnable]) VALUES (26, N'thành nam', N'thanh-nam', 1, 1, NULL)
INSERT [dbo].[HashTag] ([HashTagId], [Name], [Alias], [IsHot], [IsActive], [IsEnable]) VALUES (27, N'phan mem', N'phan-mem', 0, 1, NULL)
INSERT [dbo].[HashTag] ([HashTagId], [Name], [Alias], [IsHot], [IsActive], [IsEnable]) VALUES (28, N'software', N'software', 1, 1, NULL)
INSERT [dbo].[HashTag] ([HashTagId], [Name], [Alias], [IsHot], [IsActive], [IsEnable]) VALUES (29, N'bảo tín', N'bao-tin', 1, 1, NULL)
INSERT [dbo].[HashTag] ([HashTagId], [Name], [Alias], [IsHot], [IsActive], [IsEnable]) VALUES (30, N'visoft', N'visoft', 0, 1, NULL)
INSERT [dbo].[HashTag] ([HashTagId], [Name], [Alias], [IsHot], [IsActive], [IsEnable]) VALUES (31, N'nashtech', N'nashtech', 1, 1, NULL)
INSERT [dbo].[HashTag] ([HashTagId], [Name], [Alias], [IsHot], [IsActive], [IsEnable]) VALUES (32, N'visoftware', N'visoftware', 1, 1, NULL)
SET IDENTITY_INSERT [dbo].[HashTag] OFF
SET IDENTITY_INSERT [dbo].[HashTagLink] ON 

INSERT [dbo].[HashTagLink] ([HashTagLinkId], [HashTagId], [LinkId], [TypeId]) VALUES (12, 27, 21, 0)
INSERT [dbo].[HashTagLink] ([HashTagLinkId], [HashTagId], [LinkId], [TypeId]) VALUES (16, 29, 7, 0)
INSERT [dbo].[HashTagLink] ([HashTagLinkId], [HashTagId], [LinkId], [TypeId]) VALUES (17, 28, 7, 0)
INSERT [dbo].[HashTagLink] ([HashTagLinkId], [HashTagId], [LinkId], [TypeId]) VALUES (18, 27, 7, 0)
INSERT [dbo].[HashTagLink] ([HashTagLinkId], [HashTagId], [LinkId], [TypeId]) VALUES (19, 31, 9, 0)
INSERT [dbo].[HashTagLink] ([HashTagLinkId], [HashTagId], [LinkId], [TypeId]) VALUES (20, 30, 9, 0)
INSERT [dbo].[HashTagLink] ([HashTagLinkId], [HashTagId], [LinkId], [TypeId]) VALUES (21, 29, 9, 0)
INSERT [dbo].[HashTagLink] ([HashTagLinkId], [HashTagId], [LinkId], [TypeId]) VALUES (22, 31, 20, 0)
INSERT [dbo].[HashTagLink] ([HashTagLinkId], [HashTagId], [LinkId], [TypeId]) VALUES (23, 30, 20, 0)
INSERT [dbo].[HashTagLink] ([HashTagLinkId], [HashTagId], [LinkId], [TypeId]) VALUES (24, 29, 20, 0)
INSERT [dbo].[HashTagLink] ([HashTagLinkId], [HashTagId], [LinkId], [TypeId]) VALUES (25, 32, 15, 0)
INSERT [dbo].[HashTagLink] ([HashTagLinkId], [HashTagId], [LinkId], [TypeId]) VALUES (26, 30, 15, 0)
INSERT [dbo].[HashTagLink] ([HashTagLinkId], [HashTagId], [LinkId], [TypeId]) VALUES (27, 28, 15, 0)
INSERT [dbo].[HashTagLink] ([HashTagLinkId], [HashTagId], [LinkId], [TypeId]) VALUES (1034, 31, 4, 0)
INSERT [dbo].[HashTagLink] ([HashTagLinkId], [HashTagId], [LinkId], [TypeId]) VALUES (1035, 30, 4, 0)
INSERT [dbo].[HashTagLink] ([HashTagLinkId], [HashTagId], [LinkId], [TypeId]) VALUES (1036, 29, 4, 0)
SET IDENTITY_INSERT [dbo].[HashTagLink] OFF
SET IDENTITY_INSERT [dbo].[LINKS] ON 

INSERT [dbo].[LINKS] ([ID], [Name], [Href], [Image]) VALUES (2, N'Báo 24h', N'http://www.24h.com.vn/', N'')
INSERT [dbo].[LINKS] ([ID], [Name], [Href], [Image]) VALUES (3, N'VnExpress', N'http://vnexpress.net/', N'')
INSERT [dbo].[LINKS] ([ID], [Name], [Href], [Image]) VALUES (4, N'BullGuard', N'http://bullguard.btis.vn', N'')
INSERT [dbo].[LINKS] ([ID], [Name], [Href], [Image]) VALUES (5, N'Bao Tin Security', N'http://www.btis.vn/', N'')
INSERT [dbo].[LINKS] ([ID], [Name], [Href], [Image]) VALUES (6, N'Google', N'http://google.com', N'')
SET IDENTITY_INSERT [dbo].[LINKS] OFF
SET IDENTITY_INSERT [dbo].[NEWS] ON 

INSERT [dbo].[NEWS] ([ID], [Title], [Tag], [News_Sapo], [Image], [Content], [IsHot], [TotalView], [Date], [ID_UserPost], [Active], [ID_GroupNews]) VALUES (3, N'Viết Phần Mềm Theo Yêu Cầu Khách Hàng', N'viet-phan-mem-theo-yeu-cau-khach-hang', N'<p><span style="font-family:arial,sans-serif; font-size:11.5pt">Khi c&aacute;c phần mềm hiện sẵn c&oacute; tr&ecirc;n thị trường kh&ocirc;ng thể đ&aacute;p ứng được c&aacute;c y&ecirc;u cầu c&ocirc;ng việc đặc th&ugrave; của c&ocirc;ng việc, qu&yacute; vị c&oacute; thể nghĩ ngay đến việc đặt viết một phần mềm theo y&ecirc;u cầu ri&ecirc;ng. Với Bảo T&iacute;n việc thiết kế v&agrave; x&acirc;y dựng một phần mềm ho&agrave;n to&agrave;n theo y&ecirc;u cầu đặc th&ugrave; c&ocirc;ng việc của bạn kh&ocirc;ng c&ograve;n qu&aacute; kh&oacute; khăn hay tốn k&eacute;m nữa......</span></p>
', N'/Upload/images/728-consulting.jpg', N'<p><span style="font-family:arial,sans-serif; font-size:11.5pt">Khi c&aacute;c phần mềm hiện sẵn c&oacute; tr&ecirc;n thị trường kh&ocirc;ng thể đ&aacute;p ứng được c&aacute;c y&ecirc;u cầu c&ocirc;ng việc đặc th&ugrave; của c&ocirc;ng việc, qu&yacute; vị c&oacute; thể nghĩ ngay đến việc đặt viết một phần mềm theo y&ecirc;u cầu ri&ecirc;ng. Với Bảo T&iacute;n việc thiết kế v&agrave; x&acirc;y dựng một phần mềm ho&agrave;n to&agrave;n theo y&ecirc;u cầu đặc th&ugrave; c&ocirc;ng việc của bạn kh&ocirc;ng c&ograve;n qu&aacute; kh&oacute; khăn hay tốn k&eacute;m nữa. Dịch vụ v&agrave; quy tr&igrave;nh viết phần mềm theo y&ecirc;u cầu, mọi y&ecirc;u cầu ri&ecirc;ng đặc biệt của qu&yacute; vị đều được đ&aacute;p ứng hơn cả mong đợi.</span></p>

<p style="text-align:center"><img alt="BUSINESS E-PLATFORM - NSO.COM.VN" class="border-image" src="/Upload/images/News_Events/Introduction-600x380.jpg" style="height:317px; line-height:1.6; width:500px" /></p>

<p><span style="font-family:arial,sans-serif; font-size:11.5pt">Ch&uacute;ng t&ocirc;i nhận viết phần mềm theo mọi y&ecirc;u cầu (c&oacute; thể chạy online v&agrave; offline) trong thời gian nhanh nhất, chi ph&iacute; thấp nhất, đảm bảo uy t&iacute;n chất lượng. Với kinh nghiệm nhiều năm l&agrave;m việc ở c&aacute;c c&ocirc;ng ty chuy&ecirc;n về phần mềm quản l&yacute; ở tất cả c&aacute;c lĩnh vực sản xuất v&agrave; tự động h&oacute;a . Ch&uacute;ng t&ocirc;i sẵn s&agrave;ng đ&aacute;p ứng tất cả c&aacute;c nhu cầu ri&ecirc;ng đặc biệt của qu&yacute; kh&aacute;ch về phần mềm quản l&yacute;, với mọi quy m&ocirc; từ nhỏ đến lớn, đa ng&agrave;nh, đa địa điểm.</span></p>

<p><span style="font-family:arial,sans-serif; font-size:11.5pt">Quy tr&igrave;nh thực hiện: Lấy y&ecirc;u cầu kh&aacute;ch h&agrave;ng - Tư vấn giải ph&aacute;p - Triển khai phần mềm.<br />
C&aacute;c ưu điểm nổi bật về dịch vụ phần mềm theo y&ecirc;u cầu của ch&uacute;ng t&ocirc;i l&agrave;:&nbsp;<br />
&nbsp; &nbsp; &diams;&nbsp;Chi ph&iacute; tốt v&agrave; thời gian triển khai nhanh nhất.<br />
&nbsp; &nbsp; &diams;&nbsp;Cam kết về chất lượng</span><br />
<span style="font-family:arial,sans-serif; font-size:15.3333px">&nbsp; &nbsp; &diams; </span><span style="font-family:arial,sans-serif; font-size:11.5pt">Hỗ trợ 24/7</span><br />
<span style="font-family:arial,sans-serif; font-size:15.3333px">&nbsp; &nbsp; &diams;&nbsp;</span><span style="font-family:arial,sans-serif; font-size:11.5pt">Đ&atilde; được nhiều c&aacute; nh&acirc;n, đơn vị sử dụng v&agrave; đ&aacute;nh gi&aacute; cao</span><br />
<span style="font-family:arial,sans-serif; font-size:15.3333px">&nbsp; &nbsp; &diams;&nbsp;</span><span style="font-family:arial,sans-serif; font-size:11.5pt">C&oacute; thể n&acirc;ng cấp, mở rộng kh&ocirc;ng giới hạn c&aacute;c chức năng phần mềm t&ugrave;y nhu cầu sử dụng.</span></p>

<p><span style="font-family:arial,sans-serif; font-size:11.5pt">------------------------------oo00oo------------------------------</span></p>

<p><em><span style="color:#45818E; font-family:tahoma,sans-serif; font-size:11.5pt">Rất mong được phục vụ qu&yacute; kh&aacute;ch h&agrave;ng !</span></em></p>

<p><em><span style="color:#45818E; font-family:tahoma,sans-serif; font-size:11.5pt">Tham khảo web: </span></em><span style="color:#009900; font-family:tahoma,sans-serif; font-size:11.5pt">&nbsp;</span><em><span style="color:#222222; font-family:arial,sans-serif; font-size:11.5pt"><a href="http://baotinsoftware.com/" target="_blank"><span style="color:#F6B26B; font-family:tahoma,sans-serif">Http://baotinsoftware.com</span></a></span></em><span style="color:#F6B26B; font-family:tahoma,sans-serif; font-size:11.5pt">&nbsp;</span><em><span style="color:#45818E; font-family:tahoma,sans-serif; font-size:11.5pt">hoặc</span></em><span style="color:#F6B26B; font-family:tahoma,sans-serif; font-size:11.5pt">&nbsp;</span><em><span style="color:#222222; font-family:arial,sans-serif; font-size:11.5pt"><a href="http://baotinsoftware.com/" target="_blank"><span style="color:#F6B26B; font-family:tahoma,sans-serif">Http://baotinsoftware.com.vn</span></a></span></em></p>

<p><em><span style="color:#45818E; font-family:tahoma,sans-serif; font-size:11.5pt">Email:</span></em><span style="color:#009900; font-family:tahoma,sans-serif; font-size:11.5pt">&nbsp;</span><span style="color:#CC0000; font-family:tahoma,sans-serif; font-size:11.5pt">&nbsp;</span><span style="color:#3D85C6; font-family:tahoma,sans-serif; font-size:11.5pt"><a href="http://baotinsoftware.com/" target="_blank">baotinsoftware@gmail.com</a></span></p>

<p><em><span style="color:#0B5394; font-family:tahoma,sans-serif; font-size:11.5pt">Phone / Zalo :&nbsp;</span></em><em><span style="color:#0B5394; font-family:arial,sans-serif; font-size:11.5pt">&nbsp;0988 898996 Lộc</span></em></p>
', 0, 233, CAST(N'2015-06-18 00:00:00.000' AS DateTime), 2, 1, 7)
INSERT [dbo].[NEWS] ([ID], [Title], [Tag], [News_Sapo], [Image], [Content], [IsHot], [TotalView], [Date], [ID_UserPost], [Active], [ID_GroupNews]) VALUES (4, N'Dịch vụ Bảo Trì Máy Tính Định Kỳ', N'dich-vu-bao-tri-may-tinh-dinh-ky', N'<p><span style="font-family:arial,sans-serif; font-size:11.5pt">Dịch vụ bao tr&igrave; m&aacute;y t&iacute;nh của c&ocirc;ng ty Bảo T&iacute;n xin gửi tới qu&yacute; c&ocirc;ng ty lời ch&uacute;c sức khỏe v&agrave; th&agrave;nh đạt! Với phương ch&acirc;m &quot;<strong>Đảm bảo an to&agrave;n m&aacute;y t&iacute;nh của kh&aacute;ch l&agrave; th&agrave;nh c&ocirc;ng của c&ocirc;ng ty ch&uacute;ng t&ocirc;i</strong>&quot;, với đ&ocirc;i ngũ kỹ thuật vi&ecirc;n chuy&ecirc;n nghiệp lu&ocirc;n n&acirc;ng cao tr&igrave;nh độ để đem đến cho kh&aacute;ch h&agrave;ng những dịch vụ CNTT tốt nhất.</span></p>
', N'/Upload/images/SUAPC.jpg', N'<p style="text-align:center">&nbsp;</p>

<p><span style="color:#FF8C00"><strong><span style="font-family:arial,sans-serif; font-size:11.5pt">►DANH S&Aacute;CH C&Aacute;C THIẾT BỊ ĐƯỢC BẢO TR&Igrave;</span></strong></span></p>

<p><span style="font-family:arial,sans-serif; font-size:11.5pt">- C&aacute;c m&aacute;y trạm l&agrave;m việc (m&agrave;n h&igrave;nh, th&acirc;n m&aacute;y, b&agrave;n ph&iacute;m, chuột)<br />
- Mạng nội bộ (m&aacute;y chủ, c&aacute;c thiết bị mạng như: d&acirc;y cắm patch-cord, ổ nối mạng, hub, switch, modem,...)<br />
- Bộ lưu điện (UPS) v&agrave; c&aacute;c thiết bị ngoại vi (m&aacute;y in, m&aacute;y scanner,...)<br />
- M&aacute;y in m&atilde; vạch, m&aacute;y qu&eacute;t m&atilde; vạch...</span></p>

<p><span style="color:#FF8C00"><strong><span style="font-family:arial,sans-serif; font-size:11.5pt">►NỘI DUNG C&Ocirc;NG VIỆC THỰC HIỆN</span></strong></span></p>

<p><strong><span style="font-family:arial,sans-serif; font-size:11.5pt">1. Đối với c&aacute;c m&aacute;y trạm l&agrave;m việc</span></strong><br />
<span style="font-family:arial,sans-serif; font-size:11.5pt">- Tối ưu h&oacute;a tốc độ hoạt động của m&aacute;y t&iacute;nh<br />
- Kiểm tra hoạt động của m&aacute;y t&iacute;nh, dọn dẹp ổ đĩa, loại bỏ c&aacute;c tr&igrave;nh kh&ocirc;ng sử dụng, c&aacute;c tập tin r&aacute;c,...<br />
- Xử l&yacute; c&aacute;c lỗi m&aacute;y t&iacute;nh trong qu&aacute; tr&igrave;nh sử dụng phần cứng, phần mềm<br />
- Hướng dẫn sử dụng cơ bản, c&oacute; khuyến c&aacute;o c&aacute;ch sử dụng sao cho hiệu quả.<br />
- Vệ sinh to&agrave;n bộ b&ecirc;n trong, b&ecirc;n ngo&agrave;i m&aacute;y t&iacute;nh (lau ch&ugrave;i, h&uacute;t bụi c&aacute;c th&agrave;nh phần b&ecirc;n ngo&agrave;i đi k&egrave;m theo bộ m&aacute;y t&iacute;nh)<br />
- Cập nhật chương tr&igrave;nh v&agrave; qu&eacute;t virus m&aacute;y t&iacute;nh. C&oacute; thể đặt lịch cho chương tr&igrave;nh diệt tự động chạy kiểm tra. Kh&aacute;ch h&agrave;ng được cho mượn thiết thay thế, đảm bảo c&ocirc;ng việc kh&ocirc;ng bị gi&aacute;n đoạn.</span></p>

<p><strong><span style="font-family:arial,sans-serif; font-size:11.5pt">2. Mạng nội bộ</span></strong><br />
<span style="font-family:arial,sans-serif; font-size:11.5pt">- Tối ưu h&oacute;a tốc độ cho m&aacute;y chủ.<br />
- Backup dữ liệu định kỳ cho hệ thống m&aacute;y chủ.<br />
- Backup hệ thống mail.<br />
- Kiểm tra kết nối mạng.<br />
- Vệ sinh b&ecirc;n ngo&agrave;i c&aacute;c thiết bị đi k&egrave;m.<br />
- C&agrave;i đặt hệ thống ph&ograve;ng chống virus.<br />
- Chặn, lọc c&aacute;c phần mềm, c&aacute;c website theo y&ecirc;u cầu.<br />
- Xử l&yacute; lỗi phần cứng, phần mềm trong qu&aacute; tr&igrave;nh sử dụng.</span></p>

<p><strong><span style="font-family:arial,sans-serif; font-size:11.5pt">3. Bộ lưu điện v&agrave; c&aacute;c thiết bị ngoại vi</span></strong><br />
<span style="font-family:arial,sans-serif; font-size:11.5pt">- Kiểm tra đảm bảo c&aacute;c thiết bị ngoại vi v&agrave; bộ lưu điện hoạt động b&igrave;nh thường.<br />
- L&agrave;m vệ sinh b&ecirc;n ngo&agrave;i cho c&aacute;c thiết bị ngoại vi v&agrave; c&aacute;c bộ lưu điện.</span></p>

<p style="text-align:center"><img alt="" src="/Upload/images/Services/baotin-dich-vu-sua-chua-may-tinh.png" style="height:261px; width:628px" /></p>

<p><span style="font-family:arial,sans-serif; font-size:11.5pt">------------------------------oo00oo------------------------------</span></p>

<p><em><span style="color:rgb(69, 129, 142); font-family:tahoma,sans-serif; font-size:11.5pt">Rất mong được phục vụ qu&yacute; kh&aacute;ch h&agrave;ng !</span></em></p>

<p><em><span style="color:rgb(69, 129, 142); font-family:tahoma,sans-serif; font-size:11.5pt">Tham khảo web:&nbsp;</span></em><span style="color:rgb(0, 153, 0); font-family:tahoma,sans-serif; font-size:11.5pt">&nbsp;</span><em><span style="color:rgb(34, 34, 34); font-family:arial,sans-serif; font-size:11.5pt"><a href="http://baotinsoftware.com/" style="box-sizing: border-box; color: rgb(51, 122, 183); text-decoration: none; transition: 300ms; background-color: transparent;" target="_blank"><span style="color:rgb(246, 178, 107); font-family:tahoma,sans-serif">Http://baotinsoftware.com</span></a></span></em><span style="color:rgb(246, 178, 107); font-family:tahoma,sans-serif; font-size:11.5pt">&nbsp;</span><em><span style="color:rgb(69, 129, 142); font-family:tahoma,sans-serif; font-size:11.5pt">hoặc</span></em><span style="color:rgb(246, 178, 107); font-family:tahoma,sans-serif; font-size:11.5pt">&nbsp;</span><em><span style="color:rgb(34, 34, 34); font-family:arial,sans-serif; font-size:11.5pt"><a href="http://baotinsoftware.com/" style="box-sizing: border-box; color: rgb(51, 122, 183); text-decoration: none; transition: 300ms; background-color: transparent;" target="_blank"><span style="color:rgb(246, 178, 107); font-family:tahoma,sans-serif">Http://baotinsoftware.com.vn</span></a></span></em></p>

<p><em><span style="color:rgb(69, 129, 142); font-family:tahoma,sans-serif; font-size:11.5pt">Email:</span></em><span style="color:rgb(0, 153, 0); font-family:tahoma,sans-serif; font-size:11.5pt">&nbsp;</span><span style="color:rgb(204, 0, 0); font-family:tahoma,sans-serif; font-size:11.5pt">&nbsp;</span><span style="color:rgb(61, 133, 198); font-family:tahoma,sans-serif; font-size:11.5pt"><a href="http://baotinsoftware.com/" style="box-sizing: border-box; color: rgb(51, 122, 183); text-decoration: none; transition: 300ms; background-color: transparent;" target="_blank">baotinsoftware@gmail.com</a></span></p>

<p><em><span style="color:rgb(11, 83, 148); font-family:tahoma,sans-serif; font-size:11.5pt">Phone / Zalo :&nbsp;</span></em><em><span style="color:rgb(11, 83, 148); font-family:arial,sans-serif; font-size:11.5pt">&nbsp;0988 898996 Lộc</span></em></p>
', 0, 267, CAST(N'2015-06-19 22:37:40.070' AS DateTime), 2, 1, 7)
INSERT [dbo].[NEWS] ([ID], [Title], [Tag], [News_Sapo], [Image], [Content], [IsHot], [TotalView], [Date], [ID_UserPost], [Active], [ID_GroupNews]) VALUES (7, N'Đôi điều về chúng tôi', N'doi-dieu-ve-chung-toi', N'<p>C&ocirc;ng ty Bảo T&iacute;n l&agrave; một trong những c&ocirc;ng ty c&oacute; kinh nghiệm l&acirc;u năm về c&aacute;c sản phẩm m&ocirc; h&igrave;nh quản l&yacute; sản xuất v&agrave; hệ thống phần mềm quản l&yacute; trong c&aacute;c lĩnh vực &ldquo;<strong>Nhuộm,dệt.</strong>.&rdquo; Xin gởi đến qu&yacute; kh&aacute;ch h&agrave;ng lời ch&agrave;o tr&acirc;n trọng nhất.</p>

<p>C&ocirc;ng nghệ th&ocirc;ng tin hiện nay đang đ&oacute;ng một vai tr&ograve; th&uacute;c đẩy quan trọng trong lĩnh vực &nbsp;c&ocirc;ng nghiệp,thương mại &hellip;.cho ng&agrave;nh sản xuất. Mục ti&ecirc;u ph&aacute;t triển của ch&uacute;ng t&ocirc;i l&agrave; cung cấp cho kh&aacute;ch h&agrave;ng những&nbsp;<strong>&ldquo;</strong><strong>giải ph&aacute;p v&agrave; phần mềm ứng dụng</strong>&rdquo;.Gi&uacute;p doanh nghiệp n&acirc;ng cao hiệu suất c&ocirc;ng việc v&agrave; tăng khả năng cạnh tranh ,hiệu quả kinh kế cho doanh nghiệp.</p>

<p>Ch&uacute;ng t&ocirc;i h&acirc;n hạnh được l&agrave;m việc với qu&iacute; &nbsp;c&ocirc;ng ty để c&ugrave;ng n&acirc;ng cao hiệu quả v&agrave; lợi nhuận, để tạo niềm tin của qu&yacute; c&ocirc;ng ty ,ch&uacute;ng t&ocirc;i tạo điều kiện cho kh&aacute;ch h&agrave;ng d&ugrave;ng thử sản phẩm trong v&ograve;ng 1 th&aacute;ng.</p>

<p>Ngo&agrave;i việc thiết lập&nbsp;m&ocirc; h&igrave;nh quản l&yacute; v&agrave; phần mềm&nbsp;cho ph&ugrave; hợp với từng đối t&aacute;c kh&aacute;ch h&agrave;ng, ch&uacute;ng t&ocirc;i c&ograve;n sẵn s&agrave;ng tư vấn, khảo s&aacute;t, lập phương &aacute;n &nbsp;gi&uacute;p cho c&aacute;c đơn vị triển khai một c&aacute;ch đồng bộ, hiệu quả ngay với chi ph&iacute; thấp nhất.</p>

<p>Với kinh nghiệm đ&atilde; x&acirc;y dựng v&agrave; cung ứng cho c&aacute;c doanh nghiệp, tổ chức, c&aacute; nh&acirc;n tr&ecirc;n cả nước. Ch&uacute;ng t&ocirc;i tin tưởng rằng c&aacute;c sản phẩm của ch&uacute;ng t&ocirc;i sẽ thoả m&atilde;n mọi nhu cầu của qu&yacute; vị.</p>
', N'/Upload/images/Services/strategic_partners_600x380.jpg', N'<p>C&ocirc;ng ty Bảo T&iacute;n l&agrave; một trong những c&ocirc;ng ty c&oacute; kinh nghiệm l&acirc;u năm về c&aacute;c sản phẩm m&ocirc; h&igrave;nh quản l&yacute; sản xuất v&agrave; hệ thống phần mềm quản l&yacute; trong c&aacute;c lĩnh vực &ldquo;<strong>Nhuộm,dệt.</strong>.&rdquo; Xin gởi đến qu&yacute; kh&aacute;ch h&agrave;ng lời ch&agrave;o tr&acirc;n trọng nhất.</p>

<p>C&ocirc;ng nghệ th&ocirc;ng tin hiện nay đang đ&oacute;ng một vai tr&ograve; th&uacute;c đẩy quan trọng trong lĩnh vực &nbsp;c&ocirc;ng nghiệp,thương mại &hellip;.cho ng&agrave;nh sản xuất. Mục ti&ecirc;u ph&aacute;t triển của ch&uacute;ng t&ocirc;i l&agrave; cung cấp cho kh&aacute;ch h&agrave;ng những&nbsp;<strong>&ldquo;</strong><strong>giải ph&aacute;p v&agrave; phần mềm ứng dụng</strong>&rdquo;.Gi&uacute;p doanh nghiệp n&acirc;ng cao hiệu suất c&ocirc;ng việc v&agrave; tăng khả năng cạnh tranh ,hiệu quả kinh kế cho doanh nghiệp.</p>

<p style="text-align:center"><img alt="Bảo tin software" class="border-image" src="/Upload/images/News_Events/Introduction-600x380.jpg" style="height:380px; width:600px" /></p>

<p>Ch&uacute;ng t&ocirc;i h&acirc;n hạnh được l&agrave;m việc với qu&iacute; &nbsp;c&ocirc;ng ty để c&ugrave;ng n&acirc;ng cao hiệu quả v&agrave; lợi nhuận, để tạo niềm tin của qu&yacute; c&ocirc;ng ty ,ch&uacute;ng t&ocirc;i tạo điều kiện cho kh&aacute;ch h&agrave;ng d&ugrave;ng thử sản phẩm trong v&ograve;ng 1 th&aacute;ng.</p>

<p>Ngo&agrave;i việc thiết lập&nbsp;m&ocirc; h&igrave;nh quản l&yacute; v&agrave; phần mềm&nbsp;cho ph&ugrave; hợp với từng đối t&aacute;c kh&aacute;ch h&agrave;ng, ch&uacute;ng t&ocirc;i c&ograve;n sẵn s&agrave;ng tư vấn, khảo s&aacute;t, lập phương &aacute;n &nbsp;gi&uacute;p cho c&aacute;c đơn vị triển khai một c&aacute;ch đồng bộ, hiệu quả ngay với chi ph&iacute; thấp nhất.</p>

<p>Với kinh nghiệm đ&atilde; x&acirc;y dựng v&agrave; cung ứng cho c&aacute;c doanh nghiệp, tổ chức, c&aacute; nh&acirc;n tr&ecirc;n cả nước. Ch&uacute;ng t&ocirc;i tin tưởng rằng c&aacute;c sản phẩm của ch&uacute;ng t&ocirc;i sẽ thoả m&atilde;n mọi nhu cầu của qu&yacute; vị.</p>

<p><strong><em><span style="color:black; font-size:10pt">Chương tr&igrave;nh sản phẩm của ch&uacute;ng t&ocirc;i bao gồm:</span></em></strong></p>

<p><em><strong><span style="color:rgb(69, 129, 142); font-size:10pt">&bull;</span></strong></em><em><span style="color:rgb(69, 129, 142); font-size:10pt">&nbsp;<a href="http://baotinsoftware.com/san-pham.html">Phần mềm chuy&ecirc;n dụng cho ng&agrave;nh nhuộm, dệt</a></span></em></p>

<p><em><strong><span style="color:rgb(69, 129, 142); font-size:10pt">&bull;</span></strong></em><em><span style="color:rgb(69, 129, 142); font-size:10pt">&nbsp;<a href="http://baotinsoftware.com/san-pham.html">Hệ thống c&acirc;n chất lỏng tự động</a></span></em></p>

<p><em><strong><span style="color:rgb(69, 129, 142); font-size:10pt">&bull;</span></strong></em><em><span style="color:rgb(69, 129, 142); font-size:10pt">&nbsp;<a href="http://baotinsoftware.com/san-pham.html">Hệ thống b&aacute;n tự động</a></span></em></p>

<p><em><span style="color:rgb(69, 129, 142); font-family:arial,sans-serif; font-size:9pt">Rất mong được phục vụ qu&yacute; kh&aacute;ch h&agrave;ng !</span></em></p>
', 0, 356, CAST(N'2015-07-09 10:47:40.687' AS DateTime), 2, 1, 1)
INSERT [dbo].[NEWS] ([ID], [Title], [Tag], [News_Sapo], [Image], [Content], [IsHot], [TotalView], [Date], [ID_UserPost], [Active], [ID_GroupNews]) VALUES (8, N'Chính sách hỗ trợ khách hàng của Baotinsoftware', N'chinh-sach-ho-tro-khach-hang-cua-baotinsoftware', N'', N'/Upload/images/Services/f3_600x380.jpg', N'<p style="text-align:center"><img alt="" class="border-image" src="/Upload/images/News_Events/img_14-600x380.jpg" style="height:371px; width:600px" /></p>
', 0, 295, CAST(N'2015-07-09 11:23:26.347' AS DateTime), 2, 1, 12)
INSERT [dbo].[NEWS] ([ID], [Title], [Tag], [News_Sapo], [Image], [Content], [IsHot], [TotalView], [Date], [ID_UserPost], [Active], [ID_GroupNews]) VALUES (9, N'''Việt Nam là điển hình về ứng dụng thành công CNTT''', N'viet-nam-la-dien-hinh-ve-ung-dung-thanh-cong-cntt', N'<p>H&agrave;ng năm, Li&ecirc;n minh viễn th&ocirc;ng quốc tế (ITU) đều c&ocirc;ng bố chỉ số ph&aacute;t triển CNTT-VT (IDI) nhằm xếp hạng c&aacute;c quốc gia tr&ecirc;n thế giới dựa tr&ecirc;n những tiến bộ trong lĩnh vực CNTT-VT. Năm 2013, c&oacute; 161 quốc gia c&oacute; mặt tr&ecirc;n bảng xếp hạng IDI, trong đ&oacute; Việt Nam đứng thứ 81 tr&ecirc;n thế giới, thứ 4 tại Đ&ocirc;ng Nam &Aacute;, thứ 12/17 ở khu vực ch&acirc;u &Aacute; - Th&aacute;i B&igrave;nh Dương. Trong khi đ&oacute;, Bangladesh xếp thứ 145.</p>
', N'/Upload/images/News_Events/img_13-600x380.jpg', N'<p>Trong b&agrave;i viết đăng tr&ecirc;n b&aacute;o The Daily Kaler Kontho - một trong những tờ b&aacute;o lớn nhất tại Bangladesh, &ocirc;ng Kafi, hiện l&agrave; Chủ tịch Tổ chức C&ocirc;ng nghiệp điện to&aacute;n ch&acirc;u &Aacute; - ch&acirc;u Đại Dương (ASOCIO), chia sẻ:</p>

<p>H&agrave;ng năm, Li&ecirc;n minh viễn th&ocirc;ng quốc tế (ITU) đều c&ocirc;ng bố chỉ số ph&aacute;t triển CNTT-VT (IDI) nhằm xếp hạng c&aacute;c quốc gia tr&ecirc;n thế giới dựa tr&ecirc;n những tiến bộ trong lĩnh vực CNTT-VT. Năm 2013, c&oacute; 161 quốc gia c&oacute; mặt tr&ecirc;n bảng xếp hạng IDI, trong đ&oacute; Việt Nam đứng thứ 81 tr&ecirc;n thế giới, thứ 4 tại Đ&ocirc;ng Nam &Aacute;, thứ 12/17 ở khu vực ch&acirc;u &Aacute; - Th&aacute;i B&igrave;nh Dương. Trong khi đ&oacute;, Bangladesh xếp thứ 145.</p>

<p style="text-align:center"><img alt="" src="/Upload/images/News_Events/Introduction-600x380.jpg" style="height:380px; width:600px" /></p>

<p>Một điều th&uacute; vị l&agrave; năm 1975, sau khi ho&agrave;n to&agrave;n độc lập, Việt Nam l&agrave; một trong những nước k&eacute;m ph&aacute;t triển nhất tr&ecirc;n thế giới với thu nhập b&igrave;nh qu&acirc;n đầu người chỉ 40 USD, so với mức 80 USD của Bangladesh. Mọi thứ thay đổi ho&agrave;n to&agrave;n chỉ sau 35 năm v&agrave; CNTT-VT g&oacute;p phần quan trọng cho sự thay đổi đ&oacute;, khi 10% GDP của Việt Nam đến từ CNTT-VT. Quy m&ocirc; thị trường nội địa hiện ở mức 40 tỷ USD v&agrave; 1 triệu nh&acirc;n c&ocirc;ng. Trong năm 2014, Việt Nam thu được 1 tỷ USD từ xuất khẩu CNTT-VT. Ng&agrave;nh c&ocirc;ng nghiệp điện thoại di động cũng thu được 13 tỷ USD năm 2013. Hiện, quốc gia n&agrave;y đang l&agrave; một trong những nh&agrave; cung cấp nội dung số v&agrave; phần mềm h&agrave;ng đầu tr&ecirc;n thế giới. Theo c&aacute;c kết quả nghi&ecirc;n cứu của Trung t&acirc;m Thương mại Quốc tế, trị gi&aacute; c&aacute;c mặt h&agrave;ng điện tử xuất khẩu của Việt Nam trị gi&aacute; 38,4 tỷ USD trong năm 2013.</p>

<p>Trong những năm 2010-2012, Bộ Th&ocirc;ng tin truyền th&ocirc;ng đ&atilde; đầu tư khoảng 8,5 tỷ USD, phần lớn d&agrave;nh cho việc sản xuất phần mềm, gi&aacute;o dục CNTT-VT, ph&aacute;t triển v&agrave; cải tiến nguồn nh&acirc;n lực. Nhờ c&aacute;c khoản đầu tư n&agrave;y, tăng trưởng b&igrave;nh qu&acirc;n h&agrave;ng năm của ng&agrave;nh CNTT-VT của Việt Nam đạt mức 25-30%. C&aacute;c biện ph&aacute;p được ch&iacute;nh phủ nước n&agrave;y &aacute;p dụng bao gồm ban h&agrave;nh nghị định đặc biệt nhằm hỗ trợ ng&agrave;nh c&ocirc;ng nghiệp phần mềm năm 2007, x&acirc;y dựng c&aacute;c ch&iacute;nh s&aacute;ch ph&aacute;t triển ng&agrave;nh CNTT-VT giai đoạn 2007-2010, cấp ph&eacute;p cho dịch vụ chữ k&yacute; số năm 2009, thực hiện Kế hoạch Tổng thể cho CNTT-VT năm 2010, h&igrave;nh th&agrave;nh tầm nh&igrave;n mới v&agrave;o năm 2012 với việc CNTT-VT sẽ trở th&agrave;nh một phần quan trọng của cơ sở hạ tầng quốc gi&aacute;, v&agrave; thiết lập &quot;Ủy ban Quốc gia về ứng dụng CNTT-VT&quot; do Thủ tướng đứng đầu v&agrave;o năm 2014. Kể từ 2007, ch&iacute;nh phủ cũng nhấn mạnh đến việc &quot;Bảo hộ quyền sở hữu tr&iacute; tuệ&quot; v&agrave; th&agrave;nh quả l&agrave; Việt Nam đ&atilde; được x&oacute;a khỏi danh s&aacute;ch c&aacute;c quốc gia c&oacute; mức độ vi phạm bản quyền phần mềm cao nhất thế giới.</p>
', 0, 263, CAST(N'2015-07-09 11:27:35.707' AS DateTime), 2, 1, 2)
INSERT [dbo].[NEWS] ([ID], [Title], [Tag], [News_Sapo], [Image], [Content], [IsHot], [TotalView], [Date], [ID_UserPost], [Active], [ID_GroupNews]) VALUES (10, N'Trách nhiệm xã hội và phúc lợi cộng đồng của các doanh nghiệp', N'trach-nhiem-xa-hoi-va-phuc-loi-cong-dong-cua-cac-doanh-nghiep', N'<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat.</p>
', N'/Upload/images/News_Events/CORPORATE-SOCIAL-RESPONSIBILITY.jpg', N'<p style="text-align:center"><img alt="CORPORATE SOCIAL RESPONSIBILITY &amp; COMMUNITY-CENTRIC INITIATIVES" class="border-image" src="/Upload/images/News_Events/CORPORATE-SOCIAL-RESPONSIBILITY.jpg" style="height:500px; width:800px" /></p>

<p><strong>CORPORATE SOCIAL RESPONSIBILITY &amp; COMMUNITY-CENTRIC INITIATIVES</strong></p>

<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit.</p>

<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit.</p>
', 0, 189, CAST(N'2015-07-09 11:30:28.823' AS DateTime), 2, 1, 2)
INSERT [dbo].[NEWS] ([ID], [Title], [Tag], [News_Sapo], [Image], [Content], [IsHot], [TotalView], [Date], [ID_UserPost], [Active], [ID_GroupNews]) VALUES (11, N'Cơ hội tạo dấu ấn mới cho Việt Nam trên bản đồ CNTT thế giới', N'co-hoi-tao-dau-an-moi-cho-viet-nam-tren-ban-do-cntt-the-gioi', N'<p>&Ocirc;ng Trương Gia B&igrave;nh, Chủ tịch HĐQT FPT ki&ecirc;m Chủ tịch hiệp hội VINASA, đ&aacute;nh gi&aacute; ASOCIO Summit 2014 sẽ l&agrave; bước ngoặt lớn cho sự ph&aacute;t triển của CNTT tại Việt Nam.</p>
', N'/Upload/images/News_Events/Introduction-600x380.jpg', N'<p>ASOCIO ICT Summit (Diễn đ&agrave;n cấp cao CNTT v&agrave; Truyền th&ocirc;ng ch&acirc;u &Aacute; - ch&acirc;u Đại Dương 2014) sẽ diễn ra tại H&agrave; Nội v&agrave;o ng&agrave;y 28-31/10 tới. Đ&acirc;y mới l&agrave; lần thứ hai sau 11 năm Việt Nam gi&agrave;nh quyền đăng cai sự kiện n&agrave;y. Năm 2003, ASOCIO ICT Summit lần đầu được tổ chức tại H&agrave; Nội v&agrave; th&agrave;nh c&ocirc;ng của sự kiện đ&atilde; g&acirc;y bất ngờ, tạo tiếng vang lớn trong cộng đồng CNTT quốc tế bởi khi đ&oacute; Việt Nam vẫn chưa được biết đến tr&ecirc;n bản đồ CNTT thế giới.</p>

<p style="text-align:center"><img alt="" src="/Upload/images/News_Events/Introduction-600x380.jpg" style="height:380px; width:600px" /></p>

<p>- <em>Đ&acirc;y l&agrave; lần thứ hai Việt Nam đăng cai tổ chức ASOCIO ICT Summit, theo &ocirc;ng những lợi &iacute;ch m&agrave; c&aacute;c quốc gia đạt được khi đăng cai Hội nghị n&agrave;y l&agrave; g&igrave;?</em></p>

<p>- &Ocirc;ng Trương Gia B&igrave;nh: Năm 2003, Việt Nam lần đầu đăng cai tổ chức v&agrave; ở thời điểm đ&oacute;, Việt Nam chưa c&oacute; t&ecirc;n trong b&aacute;o c&aacute;o nghi&ecirc;n cứu của c&aacute;c tổ chức c&oacute; uy t&iacute;n như Gartner, IDC&hellip; Lĩnh vực xuất khẩu phần mềm của Việt Nam mới đang trong giai đoạn h&igrave;nh th&agrave;nh. Th&agrave;nh c&ocirc;ng của ASOCIO ICT Summit 2003 đ&atilde; tạo tiếng vang lớn trong cộng đồng CNTT quốc tế.</p>

<p>Ng&agrave;nh c&ocirc;ng nghiệp phần cứng v&agrave; phần mềm Việt Nam sau đ&oacute; đ&atilde; c&oacute; sự ph&aacute;t triển b&ugrave;ng nổ, đạt mức tăng trường cao 30-40% mỗi năm. Trong 11 năm, Việt Nam li&ecirc;n tục thăng tiến tr&ecirc;n c&aacute;c bảng xếp hạng CNTT thế giới, đặc biệt đ&atilde; trở th&agrave;nh một quốc gia c&oacute; t&ecirc;n tuổi trong lĩnh vực xuất khẩu phần mềm. H&agrave; Nội v&agrave; TP HCM lu&ocirc;n giữ vị tr&iacute; cao trong danh s&aacute;ch c&aacute;c th&agrave;nh phố hấp dẫn về xuất khẩu phần mềm. Năm 2012, Việt Nam vượt qua Ấn Độ trở th&agrave;nh đối t&aacute;c gia c&ocirc;ng phần mềm lớn thứ 2 của Nhật Bản. Sự ph&aacute;t triển Ch&iacute;nh phủ điện tử cũng được Li&ecirc;n hiệp quốc xếp hạng 4 khu vực Đ&ocirc;ng Nam &Aacute;.</p>
', 0, 166, CAST(N'2015-08-03 21:12:08.360' AS DateTime), 2, 1, 2)
INSERT [dbo].[NEWS] ([ID], [Title], [Tag], [News_Sapo], [Image], [Content], [IsHot], [TotalView], [Date], [ID_UserPost], [Active], [ID_GroupNews]) VALUES (12, N'CNTT đang đi bằng đôi chân khập khiễng', N'cntt-dang-di-bang-doi-chan-khap-khieng', N'<p>PGS.TS Nguyễn Ngọc B&igrave;nh, Hiệu trưởng Trường Đại học C&ocirc;ng nghệ, Đại học Quốc gia H&agrave; Nội, cho hay CNTT Việt Nam muốn đi bằng cả hai ch&acirc;n, tức cả về phần cứng lẫn phần mềm nhưng lại ph&aacute;t triển kh&ocirc;ng đồng đều.</p>
', N'/Upload/images/News_Events/software-600x380.jpg', N'<h2><span style="color:#0095DA">OUR STRATEGIC PARTNERS - A portfolio of strong brands</span></h2>

<p>&quot;Từ khi th&agrave;nh lập năm 1989, Hội Tin học Việt Nam (VAIP) đ&atilde; họp v&agrave; n&ecirc;u c&aacute;c việc cần l&agrave;m. Ch&uacute;ng ta muốn ph&aacute;t triển song song ng&agrave;nh c&ocirc;ng nghiệp phần cứng v&agrave; phần mềm. Đến nay Việt Nam đ&atilde; c&oacute; 90 triệu d&acirc;n nhưng ch&uacute;ng ta vẫn chưa chế tạo được linh kiện điện tử n&agrave;o. Đ&oacute; l&agrave; c&aacute;i đau của ch&uacute;ng ta. CNTT đang đi tr&ecirc;n đ&ocirc;i ch&acirc;n khập khiễng&quot;, &ocirc;ng B&igrave;nh chia sẻ trong Lễ kỷ niệm 25 năm ng&agrave;y th&agrave;nh lập Hội tin học Việt Nam.</p>

<p style="text-align:center"><img alt="OUR STRATEGIC PARTNERS NSO" class="border-image" src="/Upload/images/News_Events/img_14-600x380.jpg" style="height:380px; width:600px" /></p>

<p>Nhiều chuy&ecirc;n gia cũng nhận định, CNTT đang được coi l&agrave; nền tảng của phương thức ph&aacute;t triển mới nhằm n&acirc;ng cao to&agrave;n diện năng lực cạnh tranh quốc gia. Ch&iacute;nh phủ cũng đ&atilde; c&oacute; chủ trương x&aacute;c định CNTT l&agrave; một trong những động lực quan trọng nhất của sự ph&aacute;t triển, g&oacute;p phần l&agrave;m biến đổi s&acirc;u sắc đời sống kinh tế x&atilde; hội. Trong đ&oacute;, mảng phần mềm đang rất được coi trọng nhưng mảng phần cứng thời gian qua lại gần như bị bỏ qu&ecirc;n.</p>

<p>Tuy lĩnh vực phần cứng đ&atilde; c&oacute; những t&iacute;n hiệu tốt từ doanh nghiệp c&oacute; vốn đầu tư nước ngo&agrave;i. Chẳng hạn, Samsung đ&atilde; xuất khẩu hơn 20 tỷ USD trong năm 2013, chủ yếu l&agrave; điện thoại di động... D&ugrave; vậy, ng&agrave;nh n&agrave;y vẫn đa phần l&agrave; kiểm thử, lắp r&aacute;p, đ&oacute;ng g&oacute;i... tức phần c&oacute; gi&aacute; trị gia tăng thấp nhất.</p>

<p>&Ocirc;ng Nguyễn Long, Tổng thư k&yacute; VAIP, trăn trở: &quot;Những ước mơ đầu ti&ecirc;n, từ thời trước khi h&igrave;nh th&agrave;nh VAIP, về lắp r&aacute;p v&agrave; sản xuất m&aacute;y t&iacute;nh điện tử nhưng đến nay đi đến đ&acirc;u? Sản xuất phần cứng đến nay chuyển sang c&aacute;c doanh nghiệp FDI. Tr&ocirc;ng c&aacute;c đề &aacute;n, dự &aacute;n c&oacute; vẻ ch&uacute;ng ta th&agrave;nh c&ocirc;ng. Nhưng nh&igrave;n tỷ lệ của nửa tr&ecirc;n - c&ocirc;ng nghiệp phần cứng với nửa dưới - c&ocirc;ng nghiệp phần mềm, nội dung số th&igrave; đấy l&agrave; bức tranh chưa đẹp&quot;.</p>

<p>Trong khi đ&oacute;, &ocirc;ng Mike MacDonald, Gi&aacute;m đốc C&ocirc;ng nghệ của Huawei, nhận x&eacute;t CNTT vẫn thường được nh&igrave;n nhận dưới dạng phần cứng - phần mềm. Nhưng để CNTT ở một quốc gia th&agrave;nh c&ocirc;ng th&igrave; cần c&oacute; sự kết hợp nhuần nhuyễn giữa 3 yếu tố l&agrave; ch&iacute;nh s&aacute;ch, con người v&agrave; c&aacute;c cơ chế cần thiết. Do đ&oacute;, MacDonald cho rằng Ch&iacute;nh phủ Việt Nam cần ph&aacute;t triển nguồn nh&acirc;n lực, c&aacute;c t&agrave;i năng c&ocirc;ng nghệ, tạo m&ocirc;i trường, cơ chế khuyến kh&iacute;ch s&aacute;ng tạo, ph&aacute;t triển v&agrave; ứng dụng, x&acirc;y dựng c&aacute;c s&acirc;n chơi cho s&aacute;ng tạo v&agrave; phổ cập ứng dụng c&ocirc;ng nghệ v&agrave; c&oacute; cơ chế hợp t&aacute;c - tham vấn quốc tế.</p>

<p>&nbsp;</p>
', 0, 169, CAST(N'2015-09-19 17:58:13.257' AS DateTime), 2, 1, 2)
INSERT [dbo].[NEWS] ([ID], [Title], [Tag], [News_Sapo], [Image], [Content], [IsHot], [TotalView], [Date], [ID_UserPost], [Active], [ID_GroupNews]) VALUES (13, N'CNTT đang được coi là phương thức phát triển mới', N'cntt-dang-duoc-coi-la-phuong-thuc-phat-trien-moi', N'<p>C&aacute;c chuy&ecirc;n gia kinh tế v&agrave; c&ocirc;ng nghệ của Việt Nam khẳng định mọi mục ti&ecirc;u ph&aacute;t triển đất nước sẽ nằm ngo&agrave;i tầm với nếu kh&ocirc;ng c&oacute; những h&agrave;nh động thiết thực để n&acirc;ng cao nhận thức về vai tr&ograve; của CNTT.</p>
', N'/Upload/images/News_Events/img_14-600x380.jpg', N'<p>Để c&oacute; thể thực hiện tham vọng x&acirc;y dựng nước mạnh nhờ CNTT với những ưu ti&ecirc;n v&agrave; giải ph&aacute;p cụ thể, hiệu quả, trước hết phải thay đổi nhận thức về CNTT. Do đ&oacute;, ngay từ Diễn đ&agrave;n cấp cao CNTT-TT 2012 (Vietnam ICT Summit 2012) diễn ra v&agrave;o th&aacute;ng 6 năm ngo&aacute;i tại H&agrave; Nội, giới chuy&ecirc;n m&ocirc;n đ&atilde; đặt vấn đề phải &quot;tạo nhận thức s&acirc;u sắc ở c&aacute;c cấp, c&aacute;c ng&agrave;nh v&agrave; trong to&agrave;n x&atilde; hội về quan điểm mới của Đảng, x&aacute;c định CNTT giữ vai tr&ograve; l&agrave; hạ tầng quốc gia v&agrave; việc th&uacute;c đẩy ph&aacute;t triển, ứng dụng CNTT l&agrave; một nhiệm vụ ưu ti&ecirc;n h&agrave;ng đầu trong lộ tr&igrave;nh hiện đại h&oacute;a đất nước v&agrave; l&agrave; sự nghiệp của to&agrave;n Đảng, to&agrave;n d&acirc;n&quot;.</p>

<p>&quot;Những người đứng đầu ng&agrave;nh, địa phương chưa đặt ra những nhiệm vụ, đầu b&agrave;i về ứng dụng CNTT để tăng năng suất, một phần do họ chỉ được đ&agrave;o tạo theo chuy&ecirc;n ng&agrave;nh hẹp. Do đ&oacute;, ch&uacute;ng ta rất cần những c&aacute;n bộ vừa c&oacute; chuy&ecirc;n m&ocirc;n, vừa hiểu biết về CNTT&quot;, Ph&oacute; Thủ tướng Nguyễn Thiện Nh&acirc;n nhấn mạnh tại Diễn đ&agrave;n.</p>

<p>Trong khi đ&oacute;, tại Hội nghị Triển khai Nghị quyết Trung ương IV (kh&oacute;a XI) đầu năm 2013, Ph&oacute; Thủ tướng Ho&agrave;ng Trung Hải khẳng định: &quot;Chừng n&agrave;o x&atilde; hội, doanh nghiệp v&agrave; người d&acirc;n c&ograve;n chưa nhận thức được rằng &#39;phi tin bất ph&uacute;&#39;, chừng ấy c&aacute;c mục ti&ecirc;u về ph&aacute;t triển CNTT với tư c&aacute;ch hạ tầng của mọi hạ tầng sẽ c&ograve;n nằm ngo&agrave;i tầm với. Ch&uacute;ng ta cần phải c&oacute; h&agrave;nh động quyết liệt hơn, hiệu quả hơn, đặc biệt l&agrave; kh&acirc;u n&acirc;ng cao nhận thức về CNTT&quot;.</p>

<p style="text-align:center"><img alt="" src="/Upload/images/Services/fast-1.jpg" style="height:500px; width:500px" /></p>

<p>C&ograve;n theo tiến sĩ Mai Li&ecirc;m Trực, nguy&ecirc;n Thứ trưởng Bộ Bưu ch&iacute;nh Viễn th&ocirc;ng, CNTT kh&ocirc;ng những l&agrave; hạ tầng quốc gia m&agrave; c&ograve;n bắt đầu được coi như l&agrave; phương thức ph&aacute;t triển mới. Mỗi thời đại được ph&acirc;n biệt bằng c&ocirc;ng cụ lao động ch&iacute;nh ở thời đại đ&oacute;, như đồ đ&aacute;, đồ đồng, đồ sắt... c&ograve;n thời đại ng&agrave;y nay ch&iacute;nh l&agrave; thời đại của CNTT. &nbsp;Phương thức ph&aacute;t triển mới c&oacute; nghĩa CNTT sẽ l&agrave; nền tảng quan trọng v&agrave; mang t&iacute;nh đột ph&aacute; để giải quyết c&aacute;c vấn đề về năng suất lao động, về hiệu quả sản xuất, về ph&aacute;t triển con người để h&igrave;nh th&agrave;nh n&ecirc;n một nền kinh tế tri thức, x&atilde; hội văn minh, con người s&aacute;ng tạo.</p>

<p>Ch&iacute;nh v&igrave; vậy, sự kiện Vietnam ICT Summit năm nay, dự kiến được tổ chức ng&agrave;y 20-21/6 tại H&agrave; Nội, sẽ xoay quanh chủ đề &quot;CNTT - nền tảng của phương thức ph&aacute;t triển mới n&acirc;ng cao to&agrave;n diện năng lực cạnh tranh quốc gia&quot;. Tại đ&acirc;y, c&aacute;c diễn giả, chuy&ecirc;n gia trong mọi lĩnh vực từ c&ocirc;ng nghệ cho tới kinh tế, gi&aacute;o dục... sẽ c&ugrave;ng chia sẻ tầm nh&igrave;n, xu thế ph&aacute;t triển, chiến lược v&agrave; c&aacute;c giải ph&aacute;p lớn trong ph&aacute;t triển CNTT, trong ứng dụng CNTT v&agrave;o c&aacute;c lĩnh vực để n&acirc;ng cao sức cạnh tranh của đất nước.&nbsp;<br />
&nbsp;<br />
Diễn đ&agrave;n cấp cao CNTT-TT năm nay sẽ c&oacute; sự tham gia của cựu Thủ tướng Nhật Yukio Hatoyama.</p>
', 0, 204, CAST(N'2015-09-19 18:04:30.957' AS DateTime), 2, 1, 2)
INSERT [dbo].[NEWS] ([ID], [Title], [Tag], [News_Sapo], [Image], [Content], [IsHot], [TotalView], [Date], [ID_UserPost], [Active], [ID_GroupNews]) VALUES (14, N'Ứng dụng công nghệ thông tin trong quản lý doanh nghiệp', N'ung-dung-cong-nghe-thong-tin-trong-quan-ly-doanh-nghiep', N'<p>(KHCN)-Ng&agrave;y nay, c&ocirc;ng nghệ th&ocirc;ng tin được coi l&agrave; một trong những giải ph&aacute;p tối ưu để quản l&yacute; doanh nghiệp. Tuy nhi&ecirc;n, doanh nghiệp cần phải biết đầu tư hợp l&yacute;, vừa t&uacute;i tiền để c&aacute;c g&oacute;i giải ph&aacute;p c&ocirc;ng nghệ ph&aacute;t huy hiệu quả cao nhất trong điều kiện cho ph&eacute;p của m&igrave;nh.</p>

<p>- Nền CNTT đ&atilde; kh&ocirc;ng ngừng ph&aacute;t triển để đưa ra h&agrave;ng loạt sản phẩm CNTT phục vụ nhu cầu của c&aacute;c doanh nghiệp. Song, trong thực tế, kh&ocirc;ng phải tất cả c&aacute;c doanh nghiệp đều c&oacute; thể &aacute;p dụng CNTT v&agrave;o quản l&yacute; doanh nghiệp một c&aacute;ch kh&ocirc;n ngoan.</p>

<p>&nbsp;- Mu&ocirc;n m&agrave;u sản phẩm CNTT v&agrave; &ldquo;mu&ocirc;n mặt&rdquo; gi&aacute; cả của sản phẩm CNTT tr&ecirc;n thị trường, nhưng vấn đề ở đ&acirc;y kh&ocirc;ng phải l&agrave; gi&aacute; cả, m&agrave; điều ti&ecirc;n quyết để doanh nghiệp chọn c&aacute;c g&oacute;i giải ph&aacute;p CNTT l&agrave; sự đầu tư hợp l&yacute;.</p>
', N'/Upload/images/products-3-top-image-sm.jpg', N'<p>(KHCN)-Ng&agrave;y nay, c&ocirc;ng nghệ th&ocirc;ng tin được coi l&agrave; một trong những giải ph&aacute;p tối ưu để quản l&yacute; doanh nghiệp. Tuy nhi&ecirc;n, doanh nghiệp cần phải biết đầu tư hợp l&yacute;, vừa t&uacute;i tiền để c&aacute;c g&oacute;i giải ph&aacute;p c&ocirc;ng nghệ ph&aacute;t huy hiệu quả cao nhất trong điều kiện cho ph&eacute;p của m&igrave;nh.</p>

<p>Nền CNTT đ&atilde; kh&ocirc;ng ngừng ph&aacute;t triển để đưa ra h&agrave;ng loạt sản phẩm CNTT phục vụ nhu cầu của c&aacute;c doanh nghiệp. Song, trong thực tế, kh&ocirc;ng phải tất cả c&aacute;c doanh nghiệp đều c&oacute; thể &aacute;p dụng CNTT v&agrave;o quản l&yacute; doanh nghiệp một c&aacute;ch kh&ocirc;n ngoan.</p>

<p>&nbsp;Mu&ocirc;n m&agrave;u sản phẩm CNTT v&agrave; &ldquo;mu&ocirc;n mặt&rdquo; gi&aacute; cả của sản phẩm CNTT tr&ecirc;n thị trường, nhưng vấn đề ở đ&acirc;y kh&ocirc;ng phải l&agrave; gi&aacute; cả, m&agrave; điều ti&ecirc;n quyết để doanh nghiệp chọn c&aacute;c g&oacute;i giải ph&aacute;p CNTT l&agrave; sự đầu tư hợp l&yacute;.</p>

<p>&nbsp;Cụ thể l&agrave; c&aacute;c doanh nghiệp Việt Nam hiện phải biết &ldquo;liệu cơm gắp mắm&rdquo;, sử dụng c&aacute;c g&oacute;i CNTT n&agrave;o vừa t&uacute;i tiền lại ph&aacute;t huy được hiệu quả trong điều kiện thực tiễn của m&igrave;nh. X&aacute;c định r&otilde; thực trạng v&agrave; nhu cầu về CNTT của doanh nghiệp để đầu tư đ&uacute;ng mức gần như l&agrave; một nguy&ecirc;n tắc cơ bản m&agrave; doanh nghiệp cần phải &ldquo;thuộc b&agrave;i&rdquo; đầu tư hợp l&yacute;.</p>

<p>Hai trường hợp vừa n&ecirc;u cho thấy việc đầu tư kh&ocirc;ng hợp l&yacute; v&agrave;o c&ocirc;ng t&aacute;c quản l&yacute; doanh nghiệp bằng CNTT. Tr&ecirc;n thực tế, t&ugrave;y v&agrave;o quy m&ocirc; hoạt động v&agrave; độ chuy&ecirc;n nghiệp trong hệ thống quản l&yacute;, CNTT c&oacute; thể được &aacute;p dụng tại doanh nghiệp từ mức cơ bản (c&ocirc;ng cụ t&aacute;c nghiệp, kết nối li&ecirc;n lạc, quảng b&aacute;, tiếp thị&hellip;) đến chuy&ecirc;n m&ocirc;n h&oacute;a cao (sản xuất, cung ứng, kế hoạch, kiểm so&aacute;t, đo lường, cải tiến, huấn luyện&hellip;). V&igrave; thế, trước khi quyết định đầu tư x&acirc;y dựng hệ thống CNTT, doanh nghiệp cần nh&igrave;n thấy những lợi &iacute;ch thực tiễn qua việc ứng dụng CNTT v&agrave;o c&ocirc;ng t&aacute;c quản l&yacute;, t&ugrave;y v&agrave;o nhu cầu ở c&aacute;c cấp độ kh&aacute;c nhau của doanh nghiệp như:</p>

<p style="margin-left:.5in">- Lập trang web để quảng b&aacute; h&igrave;nh ảnh, thương hiệu.<br />
&nbsp;- N&acirc;ng cấp hệ thống CNTT để tăng khả năng hợp t&aacute;c với đối t&aacute;c.</p>

<p style="margin-left:.5in">- Tạo lợi thế cạnh tranh (một trang web chuy&ecirc;n nghiệp c&oacute; thể x&oacute;a đi ranh giới về tiềm lực t&agrave;i ch&iacute;nh, tuổi đời&hellip; của doanh nghiệp nhỏ).</p>

<p>&Ocirc;ng Mai Hạo Nhi&ecirc;n - Tổng gi&aacute;m đốc Trung t&acirc;m NTIS, Gi&aacute;m đốc OSENCO v&agrave; Chủ tịch Netmark Việt Nam - đ&atilde; kh&aacute;i qu&aacute;t bốn giai đoạn đầu tư CNTT tại doanh nghiệp:</p>

<p>1. X&acirc;y dựng cơ sở hạ tầng - Trang bị m&aacute;y t&iacute;nh.- Thiết lập mạng nội bộ (LAN).- Kết nối Internet v&agrave; viễn th&ocirc;ng.- Hệ thống an ninh cơ bản (tường lửa, phần mềm chống virus).- C&ocirc;ng cụ t&aacute;c nghiệp căn bản (c&aacute;c phần mềm hệ thống, văn ph&ograve;ng, kế to&aacute;n&hellip;).</p>

<p>&nbsp;2. N&acirc;ng cao hiệu quả hoạt động - Trang web, e-mail, diễn đ&agrave;n điện tử, blog&hellip;- Soạn thảo trực tuyến.- Họp trực tuyến.- L&agrave;m việc từ xa qua mạng ri&ecirc;ng ảo.</p>

<p style="margin-left:.5in">3. Tạo lợi thế cạnh tranh bền vững - C&aacute;c phần mềm quản l&yacute; nh&acirc;n sự, t&agrave;i liệu, dự &aacute;n, quan hệ kh&aacute;ch h&agrave;ng&hellip;- Cổng th&ocirc;ng tin nội bộ.</p>

<p style="margin-left:.5in">4. Biến đổi v&agrave; ph&aacute;t triển doanh nghiệp - Hoạch định t&agrave;i nguy&ecirc;n doanh nghiệp.- Quản l&yacute; chuỗi cung ứng.- Quản l&yacute; quy tr&igrave;nh kinh doanh.</p>

<p>Theo &ocirc;ng Nhi&ecirc;n, bốn giai đoạn n&agrave;y n&ecirc;n tạo th&agrave;nh một v&ograve;ng kh&eacute;p k&iacute;n, tức l&agrave; sau khi ho&agrave;n tất bốn bước đầu tư CNTT, doanh nghiệp cần quay lại bước ban đầu để tiếp tục đầu tư n&acirc;ng cấp, nhằm tr&aacute;nh tụt hậu trước sự biến đổi của CNTT tr&ecirc;n thế giới. Đối với c&aacute;c doanh nghiệp nhỏ v&agrave; vừa ở Việt Nam, để tr&aacute;nh những l&atilde;ng ph&iacute; kh&ocirc;ng cần thiết cho việc đầu tư CNTT, &ocirc;ng Nhi&ecirc;n đưa ra bốn bước thực hiện:</p>

<p>- Nghĩ lớn (doanh nghiệp cần nghĩ đến tương lai ph&aacute;t triển của m&igrave;nh).</p>

<p>&nbsp;- Bắt đầu nhỏ (chỉ cần đầu tư trước mắt những c&ocirc;ng nghệ vừa sức m&igrave;nh). - Sử dụng ngay (để c&oacute; thể hiệu chỉnh theo nhu cầu).</p>

<p>- Tăng dần đều (đầu tư l&acirc;u d&agrave;i, mang t&iacute;nh chiến lược n&ecirc;n phải li&ecirc;n tục n&acirc;ng cấp).</p>

<p>Lựa chọn c&ocirc;ng nghệ v&agrave; nh&agrave; cung cấp uy t&iacute;n l&agrave; một nguy&ecirc;n tắc nữa m&agrave; doanh nghiệp kh&ocirc;ng thể kh&ocirc;ng tu&acirc;n thủ. Trong h&agrave;ng loạt sản phẩm CNTT của c&aacute;c nh&agrave; cung cấp kh&aacute;c nhau, nếu kh&ocirc;ng c&oacute; kiến thức v&agrave; đủ tỉnh t&aacute;o, doanh nghiệp c&oacute; thể kh&ocirc;ng chọn đ&uacute;ng giải ph&aacute;p CNTT m&agrave; m&igrave;nh cần. Chẳng hạn sử dụng phần mềm g&igrave;, gi&aacute; cả ra sao, khả năng phần mềm tương th&iacute;ch với phần cứng hay kh&ocirc;ng&hellip;</p>

<p>Theo c&aacute;c chuy&ecirc;n gia CNTT th&igrave; tốt nhất doanh nghiệp c&oacute; thể chọn một nh&agrave; cung cấp phần cứng c&oacute; thể đ&aacute;p ứng lu&ocirc;n được phần mềm v&agrave; dễ d&agrave;ng thay đổi được phần mềm theo y&ecirc;u cầu.</p>

<p>Như vậy, việc n&acirc;ng cấp, ph&aacute;t triển CNTT của doanh nghiệp trong tương lai dễ d&agrave;ng hơn v&agrave; c&aacute;c chi ph&iacute; bỏ ra cũng sẽ được sử dụng hiệu quả. Với nhiều sản phẩm CNTT như phần mềm d&ugrave;ng thử, phầm mềm miễn ph&iacute;, phần mềm thương mại với nhiều gi&aacute; cả kh&aacute;c biệt, v&igrave; thế bắt buộc doanh nghiệp phải hiểu ch&iacute;nh m&igrave;nh muốn g&igrave; từ hệ thống CNTT, từ đ&oacute; mới c&oacute; thể quyết định việc d&ugrave;ng phần mềm m&atilde; nguồn mở, phần mềm miễn ph&iacute;, phần mềm gi&aacute; rẻ hay phần mềm cao cấp&hellip;</p>

<p>Tr&iacute;ch từ nguồn <a href="http://khcn.cinet.vn">khcn.cinet.vn</a></p>
', 0, 175, CAST(N'2016-08-28 17:15:24.703' AS DateTime), 10, 1, 2)
INSERT [dbo].[NEWS] ([ID], [Title], [Tag], [News_Sapo], [Image], [Content], [IsHot], [TotalView], [Date], [ID_UserPost], [Active], [ID_GroupNews]) VALUES (15, N'Ứng dụng công nghệ thông tin trong ngành dệt may', N'ung-dung-cong-nghe-thong-tin-trong-nganh-det-may', N'<p>Ph&ograve;ng Thương mại v&agrave; C&ocirc;ng nghiệp Việt Nam (VCCI) v&agrave; Intel vừa tổ chức Hội thảo &ldquo;<strong>Ứng dụng CNTT trong ng&agrave;nh dệt may</strong>&rdquo; c&ugrave;ng với c&aacute;c đối t&aacute;c l&agrave; Bộ Thương mại, Hiệp hội Dệt may Việt Nam, Microsoft v&agrave; Google.</p>

<p>Hội thảo nhằm n&acirc;ng cao tỷ lệ ứng dụng CNTT cho c&aacute;c doanh nghiệp dệt may trong nước, gi&uacute;p c&aacute;c doanh nghiệp dệt may cạnh tranh tốt hơn tại thị trường trong nước v&agrave; quốc tế.</p>
', N'/Upload/images/DetMay-01.jpg', N'<p>Ph&ograve;ng Thương mại v&agrave; C&ocirc;ng nghiệp Việt Nam (VCCI) v&agrave; Intel vừa tổ chức Hội thảo &ldquo;<strong>Ứng dụng CNTT trong ng&agrave;nh dệt may</strong>&rdquo; c&ugrave;ng với c&aacute;c đối t&aacute;c l&agrave; Bộ Thương mại, Hiệp hội Dệt may Việt Nam, Microsoft v&agrave; Google.</p>

<p>Hội thảo nhằm n&acirc;ng cao tỷ lệ ứng dụng CNTT cho c&aacute;c doanh nghiệp dệt may trong nước, gi&uacute;p c&aacute;c doanh nghiệp dệt may cạnh tranh tốt hơn tại thị trường trong nước v&agrave; quốc tế.</p>

<p>&nbsp;Tại Hội thảo n&agrave;y, Intel đ&atilde; giới thiệu nền tảng CNTT d&agrave;nh cho doanh nghiệp Intel&reg; VPro&trade; cho c&aacute;c doanh nghiệp dệt may. Những thử nghiệm nền tảng n&agrave;y tại 500 Cty h&agrave;ng đầu thế giới do tạp ch&iacute; Fortune lựa chọn cho thấy kết quả về khả năng tiết kiệm chi ph&iacute; vận h&agrave;nh l&ecirc;n tới 40%.</p>

<p>&nbsp;Đồng thời, khi thử nghiệm với hơn 20 doanh nghiệp với quy m&ocirc; kinh doanh kh&aacute;c nhau, kết quả cho thấy chi ph&iacute; bảo tr&igrave; m&aacute;y v&agrave; thu&ecirc; nh&acirc;n c&ocirc;ng c&oacute; thể dự kiến giảm được từ 7% đến 95%.<br />
&nbsp;</p>

<p>Tr&iacute;ch từ nguồn <a href="http://vietbao.vn">vietbao.vn</a></p>
', 0, 252, CAST(N'2016-08-28 17:26:17.633' AS DateTime), 10, 1, 2)
INSERT [dbo].[NEWS] ([ID], [Title], [Tag], [News_Sapo], [Image], [Content], [IsHot], [TotalView], [Date], [ID_UserPost], [Active], [ID_GroupNews]) VALUES (16, N'Giải pháp công nghệ cao dành cho ngành nhuộm', N'giai-phap-cong-nghe-cao-danh-cho-nganh-nhuom', N'<p>D&ugrave; chưa từng hay đ&atilde; trải nghiệm nhiều năm với &#39;con đường đau khổ&#39; trong ng&agrave;nh Nhuộm, bạn cũng n&ecirc;n t&igrave;m hiểu khả năng kỳ diệu m&agrave; c&ocirc;ng nghệ th&ocirc;ng tin (CNTT) mang đến cho lĩnh vực quản l&yacute; v&agrave; sản xuất m&agrave;usắcn&agrave;y.<br />
<br />
Tất cả c&aacute;c nh&agrave; sản xuất c&ocirc;ng nghiệp đều bận t&acirc;m đến bề ngo&agrave;i của sản phẩm: m&agrave;u sắc, độ b&oacute;ng bề mặt, h&igrave;nh d&aacute;ng, cấu tr&uacute;c bề mặt, mờ đục hay trong suốt... Trong đ&oacute;, dĩ nhi&ecirc;n m&agrave;u sắc kh&ocirc;ng phải l&agrave; to&agrave;n bộ chất lượng của sản phẩm nhưng lại quyết định rất lớn đến khả năng x&acirc;m nhập thị trường.</p>

<p>D&aacute;ng vẻ v&agrave; m&agrave;u sắc tạo n&ecirc;n một t&aacute;c động t&acirc;m l&yacute; nơi người ti&ecirc;u d&ugrave;ng về chất lượng, tuổi thọ sản phẩm để họ quyết định c&oacute;... bỏ tiền ra mua sản phẩm hay kh&ocirc;ng.Kh&aacute;ch h&agrave;ng c&ocirc;ng nghiệp c&ograve;n đ&ograve;i hỏi&nbsp; tất cả sản phẩm c&ugrave;ng loại phải c&oacute; m&agrave;u sắc đ&uacute;ng y&ecirc;u cầu v&agrave; giống nhau trong cả loạt sản phẩm. Khi ph&aacute;t hiện c&oacute; sự kh&aacute;c biệt về m&agrave;u sắc trong c&ugrave;ng một loạt sản phẩm, họ lu&ocirc;n cho rằng đ&oacute; l&agrave; biểu hiện của chất lượng k&eacute;m.</p>

<p>Để đạt được y&ecirc;u cầu đ&oacute;, từng sản phẩm phải c&oacute; c&aacute;c đặc t&iacute;nh giống hệt nhau về m&agrave;u sắc. Quan trọng như vậy, nhưng ch&uacute;ng ta c&oacute; bao giờ tự đặt một c&acirc;u hỏi như đứa trẻ l&ecirc;n ba: M&agrave;u sắc l&agrave; g&igrave;?</p>
', N'/Upload/images/Vai-02.jpg', N'<p>D&ugrave; chưa từng hay đ&atilde; trải nghiệm nhiều năm với &#39;con đường đau khổ&#39; trong ng&agrave;nh Nhuộm, bạn cũng n&ecirc;n t&igrave;m hiểu khả năng kỳ diệu m&agrave; c&ocirc;ng nghệ th&ocirc;ng tin (CNTT) mang đến cho lĩnh vực quản l&yacute; v&agrave; sản xuất m&agrave;usắcn&agrave;y.<br />
<br />
Tất cả c&aacute;c nh&agrave; sản xuất c&ocirc;ng nghiệp đều bận t&acirc;m đến bề ngo&agrave;i của sản phẩm: m&agrave;u sắc, độ b&oacute;ng bề mặt, h&igrave;nh d&aacute;ng, cấu tr&uacute;c bề mặt, mờ đục hay trong suốt... Trong đ&oacute;, dĩ nhi&ecirc;n m&agrave;u sắc kh&ocirc;ng phải l&agrave; to&agrave;n bộ chất lượng của sản phẩm nhưng lại quyết định rất lớn đến khả năng x&acirc;m nhập thị trường.</p>

<p>D&aacute;ng vẻ v&agrave; m&agrave;u sắc tạo n&ecirc;n một t&aacute;c động t&acirc;m l&yacute; nơi người ti&ecirc;u d&ugrave;ng về chất lượng, tuổi thọ sản phẩm để họ quyết định c&oacute;... bỏ tiền ra mua sản phẩm hay kh&ocirc;ng.&nbsp;&nbsp; Kh&aacute;ch h&agrave;ng c&ocirc;ng nghiệp c&ograve;n đ&ograve;i hỏi&nbsp; tất cả sản phẩm c&ugrave;ng loại phải c&oacute; m&agrave;u sắc đ&uacute;ng y&ecirc;u cầu v&agrave; giống nhau trong cả loạt sản phẩm. Khi ph&aacute;t hiện c&oacute; sự kh&aacute;c biệt về m&agrave;u sắc trong c&ugrave;ng một loạt sản phẩm, họ lu&ocirc;n cho rằng đ&oacute; l&agrave; biểu hiện của chất lượng k&eacute;m.</p>

<p>Để đạt được y&ecirc;u cầu đ&oacute;, từng sản phẩm phải c&oacute; c&aacute;c đặc t&iacute;nh giống hệt nhau về m&agrave;u sắc. Quan trọng như vậy, nhưng ch&uacute;ng ta c&oacute; bao giờ tự đặt một c&acirc;u hỏi như đứa trẻ l&ecirc;n ba: M&agrave;u sắc l&agrave; g&igrave;?</p>

<p><span style="color:#FF8C00">►L&yacute; thuyết về m&agrave;u sắc: những... con số3</span><br />
Từ đầu thế kỷ XX, Eugene Chevreul n&oacute;i: &#39;M&agrave;u sắc trong ch&uacute;ng ta&#39;.&nbsp;Ph&aacute;t biểu nổi tiếng n&agrave;y x&aacute;c định rằng rất kh&oacute; để c&oacute; thể th&ocirc;ng tin cho người kh&aacute;c về m&agrave;u sắc. Chẳng hạn: đỏ vừa, đỏ đậm, đỏ Bordeaux... &#39;T&iacute;m Huế&#39;, &#39;Mỡ g&agrave;&#39;, &#39;Xanh đọt chuối&#39;. Hay thậm ch&iacute; m&agrave;u... &#39;v&agrave;ng bệnh hoạn&#39;... Thế nhưng để diễn tả thật ch&iacute;nh x&aacute;c bằng lời n&oacute;i một m&agrave;u m&agrave; ta muốn người thợ sơn thực hiện như &yacute; ta th&igrave; quả l&agrave; qu&aacute; kh&oacute;, trừ khi &iacute;t ra bạn c&oacute; mẫu m&agrave;u để họ xem tận mắt.</p>

<p>Ng&agrave;y nay, cả một l&yacute; thuyết đồ sộ về m&agrave;u đ&atilde; được x&acirc;y dựng ho&agrave;n chỉnh v&agrave; được sử dụng trong tất cả c&aacute;c ng&agrave;nh li&ecirc;n quan đến đời sống con người, như in ấn, plastic, nhuộm vải, sơn, thực phẩm... L&yacute; thuyết n&agrave;y dựa tr&ecirc;n c&aacute;c kh&aacute;i niệm cơ bản:</p>

<table align="left" border="0" cellpadding="0" cellspacing="0" id="AutoNumber1" style="height:99px; line-height:normal; width:206px">
	<tbody>
		<tr>
			<td>
			<p><img src="http://www.pcworld.com.vn/pcworld/info/misc/2004/4/B0208_GP_MauVaSuKhacBiet.jpg" /><br />
			<br />
			<span style="color:#0000FF">M&agrave;u v&agrave; sự&#39;kh&aacute;c biệt&#39; dưới hai nguồn s&aacute;ng kh&aacute;c nhau: &aacute;nh s&aacute;ng nh&acirc;n tạo, &aacute;nh s&aacute;ng ban ng&agrave;y ngo&agrave;i trời</span></p>
			</td>
		</tr>
	</tbody>
</table>

<div style="clear:both;">M&agrave;u sắc của một vật thể được quyết định bởi 3 yếu tố: nguồn s&aacute;ng, đặc t&iacute;nh của vật liệu bề mặt, khả năng cảm ứng m&agrave;u sắc của nguời quan s&aacute;t.</div>

<p>Mọi m&agrave;u sắc được pha trộn từ 3 m&agrave;u cơ bản: đỏ (Red), lục (Green), xanh (Blue).</p>

<p>Giới đồ họa rất quen thuộc với kh&aacute;i niệm RGB n&agrave;y. Từ rất xa xưa, c&aacute;c thợ sơn v&agrave; thợ nhuộm đ&atilde; ph&aacute;t hiện rằng với 3 m&agrave;u cơ bản Đỏ - Lục - Xanh, họ c&oacute; thể pha chế n&ecirc;n mọi m&agrave;u sắc cần thiết m&agrave; con người c&oacute; thể nh&igrave;n thấy được.</p>

<p>Tuy vậy, phải cần đến thi&ecirc;n t&agrave;i Thomas Young giải th&iacute;ch hiện tượng tr&ecirc;n qua kh&aacute;m ph&aacute; về sự hiện diện của 3 loại tế b&agrave;o h&igrave;nh cone cảm biến m&agrave;u sắc tr&ecirc;n mắt người. 3&nbsp; loại n&agrave;y gồm: Blue Cone - loại tế b&agrave;o c&oacute; độ cảm ứng cao nhất với s&oacute;ng m&agrave;u Xanh (bước s&oacute;ng ngắn), Green Cone - cảm ứng với m&agrave;u Lục (bước s&oacute;ng trung b&igrave;nh), v&agrave; Red Cones cảm ứng với m&agrave;u Đỏ (bước s&oacute;ng d&agrave;i). Khi nh&igrave;n vật thể, &aacute;nh s&aacute;ng phản chiếu từ vật thể sẽ rọi l&ecirc;n v&otilde;ng mạc, v&agrave; tuỳ v&agrave;o m&agrave;u sắc phản chiếu m&agrave; từng loại tế b&agrave;o cảm ứng từng m&agrave;u với mức độ kh&aacute;c nhau. Luồng xung điện từ c&aacute;c tế b&agrave;o n&agrave;y đưa về n&atilde;o tổng hợp lại, gi&uacute;p con người ph&acirc;n biệt được m&agrave;u sắc n&agrave;y v&agrave; m&agrave;u sắc kh&aacute;c.</p>

<p><span style="color:#FF8C00">►D&ugrave;ng 3 đại lượng để x&aacute;c định m&agrave;u sắc:</span></p>

<p><em>- <strong>Độ s&aacute;ng</strong>:</em>&nbsp;Lightness (L) - biểu thị cho việc phản xạ hoặc ph&aacute;t xạ &aacute;nh s&aacute;ng của vật thể nhiều hay &iacute;t. Khi d&ugrave;ng kh&aacute;i niệm s&aacute;ng/tối, ch&iacute;nh l&agrave; bạn n&oacute;i đến gi&aacute; trị n&agrave;y.</p>

<p><em>- <strong>Sắc độ </strong>(độ ch&oacute;i):</em>&nbsp;Chroma (C) - biểu thị cường độ m&agrave;u đơn sắc của nguồn s&aacute;ng vật thể. Khi n&oacute;i đỏ đậm, đỏ nhạt..., ch&iacute;nh l&agrave; bạn n&oacute;i đến gi&aacute; trị n&agrave;y.</p>

<p><em>- <strong>M&agrave;u sắc</strong>:</em>&nbsp;Hue (H) - biểu thị c&aacute;c m&agrave;u đơn sắc. Đ&acirc;y ch&iacute;nh l&agrave; đại lượng l&agrave;m cho bạn gọi t&ecirc;n c&aacute;c m&agrave;u: đỏ, cam, v&agrave;ng, lục, lam... N&oacute; chỉ gi&aacute; trị tương ứng của c&aacute;c s&oacute;ng &aacute;nh s&aacute;ng c&oacute; bước s&oacute;ng kh&aacute;c nhau nằm trong dải thấy được của mắt người.</p>

<p>Tất&nbsp; cả c&aacute;c m&agrave;u sắc đều c&oacute; thể biểu thị bởi 3 đại lượng n&agrave;y, v&agrave; 3 gi&aacute; trị n&agrave;y l&agrave; duy nhất cho một m&agrave;u. Dựa v&agrave;o đ&oacute;, ta c&oacute; thể biểu thị một m&agrave;u sắc bất kỳ bằng một hệ toạ độ 3 chiều (hệ toạ độ m&agrave;u sắc).</p>

<p><span style="color:#FF8C00">►Quản l&yacute; m&agrave;u sắc khi chưa c&oacute;.... m&aacute;y t&iacute;nh</span></p>

<table align="left" border="0" cellpadding="0" cellspacing="0" id="AutoNumber2" style="height:118px; line-height:normal; width:200px">
	<tbody>
		<tr>
			<td>
			<p><img src="http://www.pcworld.com.vn/pcworld/info/misc/2004/4/B0208_GP_NguyenTacPhanChia.jpg" /><br />
			<br />
			<span style="color:#0000FF">Nguy&ecirc;n tắc ph&acirc;n chia m&agrave;u ở tập Atlas Munsell</span></p>
			</td>
		</tr>
	</tbody>
</table>

<div style="clear:both;">&nbsp;</div>

<p>Sau khi x&acirc;y dựng nền tảng về hệ toạ độ m&agrave;u sắc 3 chiều, người ta lần lượt s&aacute;ng chế c&aacute;c thiết bị để đo 3 đại lượng tr&ecirc;n (m&aacute;y đo quang phổ kế, m&aacute;y đo cường độ &aacute;nh s&aacute;ng...), v&agrave; x&acirc;y dựng c&aacute;c bộ chuẩn hệ thống về m&agrave;u sắc như CIE 1931 (ti&ecirc;u chuẩn quốc tế về m&agrave;u sắc). Trong đ&oacute;, to&aacute;n học được d&ugrave;ng để quy đổi c&aacute;c yếu tố L, C, H th&agrave;nh 3 đại lượng X, Y, Z để biểu thị m&agrave;u sắc bất kỳ:<br />
X: Biểu thị&nbsp; cho yếu tố m&agrave;u Đỏ.<br />
Y: Biểu thị cho yếu tố m&agrave;u Lục.<br />
Z: Biểu thị cho yếu tố m&agrave;u Xanh.</p>

<p>Trong c&ocirc;ng nghiệp về m&agrave;u sắc, thay v&igrave; n&oacute;i m&agrave;u đỏ, người ta sẽ d&ugrave;ng 3 toạ độ&nbsp; X, Y, Z để trao đổi th&ocirc;ng tin. D&ugrave; sao, chỉ dựa v&agrave;o đ&oacute; để đối chiếu m&agrave;u sắc khi sản xuất v&agrave; kiểm tra sản phẩm vẫn c&ograve;n rất kh&oacute; khăn. Bởi khi tiến h&agrave;nh đo lường, chỉ sai một đại lượng l&agrave; m&agrave;u sắc đ&atilde; thay đổi kh&aacute; xa. Do đ&oacute;, phải t&igrave;m c&aacute;ch tổ chức c&aacute;c m&agrave;u sắc theo một cấu tr&uacute;c (ph&acirc;n loại m&agrave;u sắc) v&agrave; sắp xếp theo trật tự quy ước.</p>

<p>Năm 1976, CIE đưa ra 2 hệ thống mới: CIELUV v&agrave; CIELAB, trong đ&oacute; phổ biến nhất l&agrave; CIELAB d&ugrave;ng c&aacute;c h&agrave;m to&aacute;n học để x&aacute;c định v&agrave; sắp xếp m&agrave;u sắc v&agrave;o một trật tự kh&ocirc;ng gian 3 chiều.</p>

<p>Người ta phải sử dụng bảng ph&acirc;n loại m&agrave;u được in ấn v&agrave; ph&aacute;t h&agrave;nh h&agrave;ng năm như một bảng ti&ecirc;u chuẩn về m&agrave;u sắc, l&agrave;m cầu nối cho người đặt h&agrave;ng v&agrave; người sản xuất. Nổi tiếng v&agrave; phổ biến nhất l&agrave; hệ thống bảng m&agrave;u của nh&agrave; xuất bản Pantome&reg;. Do số lượng m&agrave;u kh&ocirc;ng ngừng tăng l&ecirc;n mỗi năm, v&agrave; t&ugrave;y theo từng lĩnh vực m&agrave; ta c&oacute; Pantome cho ng&agrave;nh Dệt May, Pantome cho ng&agrave;nh In... C&aacute;c tập Atlas n&agrave;y cũng được sắp xếp tr&ecirc;n nền tảng của CIELAB.</p>

<p>Việc sử dụng bảng m&agrave;u cũng đ&ograve;i hỏi phải tu&acirc;n thủ c&aacute;c điều kiện về quan s&aacute;t m&agrave;u sắc như nguồn s&aacute;ng quan s&aacute;t, bảo quản (quan s&aacute;t bằng hộp so mẫu c&oacute; &aacute;nh s&aacute;ng ti&ecirc;u chuẩn). Th&ocirc;ng thường, kh&ocirc;ng c&oacute; bảng m&agrave;u n&agrave;o c&ograve;n giữ đ&uacute;ng m&agrave;u sắc sau 5 năm n&ecirc;n phải thay đổi v&agrave; cập nhật c&aacute;c ấn bản mới. Điểm hạn chế cơ bản: do c&aacute;c bảng m&agrave;u n&agrave;y đều in tr&ecirc;n giấy n&ecirc;n kh&oacute; đảm bảo độ ch&iacute;nh x&aacute;c của m&agrave;u sắc khi &aacute;p dụng v&agrave;o sản xuất c&aacute;c loại bề mặt vật liệu kh&aacute;c như vải, nhựa...&nbsp;</p>

<p><span style="color:#FF8C00">►CNTT giải ph&aacute;p tối ưu để quản l&yacute; m&agrave;u sắc</span><br />
<br />
Cuối c&ugrave;ng th&igrave; CNTT phải nhảy v&agrave;o &#39;cuộc chơi&#39; kh&oacute; khăn n&agrave;y. C&aacute;c nh&agrave; chế tạo thiết bị đo lập tức cho c&aacute;c thiết bị của m&igrave;nh nối trực tiếp v&agrave;o m&aacute;y t&iacute;nh: c&aacute;c đại lượng đo được truyền ngay v&agrave;o m&aacute;y để cho ra c&aacute;c con số X, Y, Z hay L, a, b (L, c, h) gần như tức thời. M&aacute;y t&iacute;nh c&oacute; thể điều khiển m&aacute;y đo lặp lại hoạt động đo nhiều lần để t&iacute;nh gi&aacute; trị trung b&igrave;nh ch&iacute;nh x&aacute;c nhất của c&aacute;c đại lượng.</p>

<p>Chưa dừng ở đ&oacute;, với khả năng xử l&yacute; cơ sở dữ liệu (CSDL) khổng lồ, người ta c&oacute; thể đưa v&agrave;o CSDL h&agrave;ng triệu gi&aacute; trị m&agrave;u sắc kh&aacute;c nhau khi tiến h&agrave;nh đo tr&ecirc;n c&aacute;c vật liệu kh&aacute;c nhau v&agrave; lưu trữ ch&uacute;ng đồng thời với c&aacute;c biện ph&aacute;p tạo ra m&agrave;u sắc đ&oacute; (như nguy&ecirc;n liệu bề mặt, loại phẩm m&agrave;u, điều kiện về m&aacute;y m&oacute;c thiết bị, nh&oacute;m kh&aacute;ch h&agrave;ng...).</p>

<p>Sau đ&oacute;, với c&aacute;c chức năng khai th&aacute;c CSDL như t&igrave;m kiếm, so s&aacute;nh, v&agrave; tuyệt vời l&agrave; khả năng t&aacute;i tạo m&agrave;u sắc từ c&aacute;c số liệu lưu trữ ngay tr&ecirc;n m&agrave;n h&igrave;nh, nh&agrave; sản xuất phần mềm chuy&ecirc;n nghiệp khai th&aacute;c c&aacute;c khả năng về lập tr&igrave;nh CSDL để phục vụ cho nh&agrave; sản xuất trong việc quản l&yacute; v&agrave; sản xuất m&agrave;u sắc.</p>

<p>M&aacute;y t&iacute;nh c&ograve;n được d&ugrave;ng để điều khiển c&aacute;c thiết bị li&ecirc;n quan trong qu&aacute; tr&igrave;nh sản xuất thử nghiệm như m&aacute;y pha m&agrave;u, c&acirc;n điện tử, quản l&yacute; kho ho&aacute; chất...; thậm ch&iacute;, quản l&yacute; cả robot điều khiển việc lấy m&agrave;u với số lượng ch&iacute;nh x&aacute;c trong kho, đem ra tận nơi sản xuất.</p>

<p><span style="color:#FF8C00">►&#39;Con đường đau khổ&#39; của ng&agrave;nh nhuộm</span></p>

<table align="left" border="0" cellpadding="0" cellspacing="0" id="AutoNumber3" style="height:104px; line-height:normal; width:125px">
	<tbody>
		<tr>
			<td>
			<p><img src="http://www.pcworld.com.vn/pcworld/info/misc/2004/4/B0208_GP_Atlas-NCS.jpg" /></p>
			</td>
		</tr>
	</tbody>
</table>

<div style="clear:both;">&nbsp;</div>

<p>Nếu bạn l&agrave;m việc trong ng&agrave;nh n&agrave;y, h&atilde;y thử đặt m&igrave;nh v&agrave;o ho&agrave;n cảnh sau: kh&aacute;ch h&agrave;ng đưa cho bạn một bảng vải mẫu c&oacute; khoảng 20 m&agrave;u kh&aacute;c nhau v&agrave; y&ecirc;u cầu nhuộm cho họ mỗi m&agrave;u 10.000m vải &#39;giống y thế n&agrave;y&#39;! C&oacute; đơn h&agrave;ng l&agrave; tốt qu&aacute;, nhưng l&agrave;m sao để bảo đảm qu&aacute; tr&igrave;nh nhuộm vừa đ&uacute;ng mẫu m&agrave;u, vừa phải đồng m&agrave;u trong cả l&ocirc;? Qu&aacute; kh&oacute;!</p>

<p>Cho đến nay, ch&iacute;nh r&agrave;o cản của kỹ thuật quản l&yacute; nhuộm đ&atilde; khiến cho ng&agrave;nh Dệt May Việt Nam ph&aacute;t triển theo hướng... mất c&acirc;n đối. Ch&uacute;ng ta xuất khẩu chủ yếu l&agrave; sản phẩm may nhưng đa phần l&agrave; may gia c&ocirc;ng (nguy&ecirc;n liệu vải v&oacute;c đưa v&agrave;o từ nước ngo&agrave;i), c&ograve;n sản phẩm nhuộm lại thiếu t&iacute;nh đồng bộ về m&agrave;u sắc, kh&ocirc;ng đ&aacute;p ứng nhu cầu may c&ocirc;ng nghiệp; việc thực hiện mẫu m&agrave;u theo &yacute; kh&aacute;ch h&atilde;y c&ograve;n chậm, dẫn tới tỷ lệ xuất khẩu vải của Việt Nam c&ograve;n rất thấp nếu so s&aacute;nh với sản phẩm may xuất khẩu.</p>

<p>Hiện nay, phần lớn c&aacute;c doanh nghiệp Dệt - Nhuộm - May Việt Nam đang l&agrave;m theo c&aacute;c bước sau:<br />
<br />
- Bằng kinh nghiệm, c&aacute;n bộ ph&ograve;ng th&iacute; nghiệm chọn ho&aacute; chất v&agrave; phẩm m&agrave;u ph&ugrave; hợp với vật liệu, so s&aacute;nh với m&agrave;u kh&aacute;ch đưa (bằng mắt) v&agrave; nhuộm thử. Đưa mẫu cho kh&aacute;ch x&aacute;c định m&agrave;u. Nếu chưa đ&uacute;ng th&igrave; nhuộm lại cho đến khi kh&aacute;ch đồng &yacute; x&aacute;c nhận m&agrave;u (k&yacute; v&agrave;o đ&oacute;!)<br />
<br />
- D&ugrave;ng c&ocirc;ng thức m&agrave;u m&agrave; kh&aacute;ch đ&atilde; x&aacute;c nhận để đưa v&agrave;o sản xuất lớn mẻ đầu ti&ecirc;n. Nếu c&oacute; sai lệch (d&ugrave;ng mắt x&aacute;c định so s&aacute;nh với mẫu vải m&agrave; kh&aacute;ch đ&atilde; x&aacute;c nhận) th&igrave; tiến h&agrave;nh sữa chữa, ch&acirc;m th&ecirc;m m&agrave;u..., giặt lại hay thậm ch&iacute; phải bỏ mẻ đầu l&agrave;m lại.</p>

<p>Đ&aacute;nh gi&aacute; tr&igrave;nh độ của một ph&ograve;ng th&iacute; nghiệm trong x&iacute; nghiệp Nhuộm, người ta lu&ocirc;n hỏi c&acirc;u đầu ti&ecirc;n: Nhuộm tr&uacute;ng mẻ đầu bao nhi&ecirc;u %?</p>

<p>Nếu mẻ đầu m&agrave; tr&uacute;ng m&agrave;u hơn 70% th&igrave; tr&igrave;nh độ ph&ograve;ng th&iacute; nghiệm thuộc loại giỏi!</p>

<p>- Khi mẻ đầu nhuộm được đ&uacute;ng như mẫu m&agrave;u kh&aacute;ch đ&atilde; đồng &yacute;, tất cả th&ocirc;ng số thiết bị, điều kiện nhuộm được ghi lại để sau đ&oacute; triển khai nhuộm h&agrave;ng loạt với c&ugrave;ng điều kiện nhuộm.</p>

<p>- Tuy vậy, đến đ&acirc;y chưa phải l&agrave; xong việc, bởi sau qu&aacute; tr&igrave;nh nhuộm, vải c&ograve;n phải ho&agrave;n tất v&agrave; kiểm tra lại về m&agrave;u sắc (do qu&aacute; tr&igrave;nh ho&agrave;n tất c&oacute; sinh nhiệt, n&ecirc;n c&oacute; khả năng m&agrave;u sắc bị thay đổi v&igrave; m&agrave;u bốc hơi bớt).</p>

<table align="right" border="0" cellpadding="0" cellspacing="0" id="AutoNumber4" style="height:87px; line-height:normal; width:292px">
	<tbody>
		<tr>
			<td>
			<p><img src="http://www.pcworld.com.vn/pcworld/info/misc/2004/4/B0208_GP_HeThongSoMau.jpg" /><br />
			<span style="color:#0000FF">Hệt thống so m&agrave;u v&agrave; pha trộn dung dịch tự động (Orintex)</span></p>
			</td>
		</tr>
	</tbody>
</table>

<div style="clear:both;">&nbsp;</div>

<p>- Kiểm tra lần cuối, so s&aacute;nh với mẫu chuẩn (kh&aacute;ch k&yacute; nhận), nếu kh&ocirc;ng ch&ecirc;nh m&agrave;u th&igrave; xem như đạt chất lượng (về m&agrave;u sắc)!</p>

<p>Diễn tả như vậy th&igrave; thấy c&ocirc;ng việc c&oacute; vẻ logic v&agrave; r&otilde; r&agrave;ng. Thế nhưng tr&ecirc;n thực tế, qu&aacute; tr&igrave;nh nhuộm vải để đạt được m&agrave;u sắc giống hệt nhau trong cả l&ocirc; sản phẩm đ&ograve;i hỏi phải bảo đảm ch&iacute;nh x&aacute;c trong tất cả c&ocirc;ng việc sau:<br />
<br />
- Phải x&aacute;c định c&ocirc;ng thức&nbsp; m&agrave;u tối ưu (kinh tế nhất, ổn định nhất).</p>

<p>- Phải bảo đảm c&acirc;n đong đo đếm khi pha m&agrave;u thật ch&iacute;nh x&aacute;c trong ph&ograve;ng th&iacute; nghiệm v&agrave; cả trong qu&aacute; tr&igrave;nh sản xuất (độ ch&iacute;nh x&aacute;c trong ph&ograve;ng th&iacute; nghiệm l&agrave; 0,01g, v&agrave; trong sản xuất sai số lớn nhất cho ph&eacute;p cũng phải l&agrave; 1g cho v&agrave;i trăm kg ho&aacute; chất).</p>

<p>- Phải bảo đảm tỷ lệ vải v&agrave; dung dịch nhuộm giống nhau (dung tỷ).</p>

<p>- Phải bảo đảm điều kiện l&agrave;m việc của thiết bị l&agrave; giống nhau (nhiệt độ, &aacute;p suất, thời gian, vận tốc...).</p>

<p>- Chỉ cần một ch&uacute;t sai s&oacute;t, cả mẻ nhuộm sẽ bị sai m&agrave;u, lệch m&agrave;u (m&agrave; thiệt hại của một mẻ nhuộm thường l&ecirc;n đến h&agrave;ng chục triệu đồng!).</p>

<p>Một chuy&ecirc;n gia nhuộm giỏi b&aacute;m theo suốt qu&aacute; tr&igrave;nh sản xuất một m&agrave;u c&ograve;n c&oacute; thể truy nguy&ecirc;n ra c&aacute;c sai s&oacute;t trong qu&aacute; tr&igrave;nh sản xuất để điều chỉnh kịp thời. Nhưng với 20 m&agrave;u, 200 m&agrave;u sản xuất đồng thời, l&agrave;m sao anh ta thực hiện nổi!</p>

<p>Đ&oacute; ch&iacute;nh l&agrave; c&ocirc;ng việc kh&oacute; khăn v&agrave; mất nhiều thời gian đối với người l&agrave;m c&ocirc;ng t&aacute;c kỹ thuật. Đ&oacute; cũng ch&iacute;nh l&agrave; vấn đề đau đầu nhất của c&aacute;c nh&agrave; quản l&yacute; c&aacute;c x&iacute; nghiệp Nhuộm v&agrave; c&ocirc;ng ty dệt may c&oacute; ng&agrave;nh Nhuộm hiện nay.</p>

<p>C&oacute; thể kết luận: Doanh nghiệp n&agrave;o quản l&yacute; th&agrave;nh c&ocirc;ng hệ thống sản xuất nhuộm (thực hiện được c&aacute;c ti&ecirc;u ch&iacute; nhanh, tiết kiệm, ch&iacute;nh x&aacute;c, độ ch&ecirc;nh m&agrave;u trong loạt lớn sản phẩm thấp), doanh nghiệp đ&oacute; nhất định th&agrave;nh c&ocirc;ng tr&ecirc;n thương trường kh&ocirc;ng chỉ trong nước m&agrave; c&ograve;n khắp thế giới.&nbsp;&nbsp;<br />
<br />
<span style="color:#FF8C00">►Hệ thống kỹ thuật số cho ng&agrave;nh nhuộm</span><br />
<br />
Số ho&aacute; (hay điện to&aacute;n ho&aacute;) c&ocirc;ng t&aacute;c quản l&yacute; m&agrave;u sắc l&agrave; chiếc ch&igrave;a kho&aacute; v&agrave;ng để gi&uacute;p c&aacute;c doanh nghiệp th&agrave;nh c&ocirc;ng trong thị trường cạnh tranh gay gắt hiện nay. N&oacute; kh&ocirc;ng giải quyết hết những vấn đề của ng&agrave;nh Nhuộm (như c&aacute;c phản ứng ho&aacute; học khi nhuộm, c&aacute;c điều kiện li&ecirc;n quan đến con người như thao t&aacute;c c&ocirc;ng nh&acirc;n tại m&aacute;y nhuộm), nhưng l&agrave; c&ocirc;ng cụ đắc lực để quản l&yacute; cả hệ thống sản xuất từ đầu v&agrave;o cho tới đầu ra.</p>

<p>Một hệ thống kỹ thuật số ho&agrave;n chỉnh v&agrave; cần c&oacute; cho ng&agrave;nh Nhuộm gồm c&aacute;c ph&acirc;n hệ sau (xin liệt k&ecirc; theo thứ tự đầu tư c&oacute; lợi nhất):&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
<br />
<strong>Trong ph&ograve;ng th&iacute; nghiệm:</strong><br />
- Hệ Thống So M&agrave;u Tự Động - Color Matching (CAD - hỗ trợ thiết kế): gồm m&aacute;y quang phổ kế; v&agrave; phần mềm gi&uacute;p thiết lập c&ocirc;ng thức m&agrave;u, lưu trữ c&ocirc;ng thức, ph&aacute;t sinh c&ocirc;ng thức m&agrave;u tự động từ dữ liệu đ&atilde; c&oacute;, điều chỉnh c&ocirc;ng thức tự động (hay bằng kinh nghiệm) cho đ&uacute;ng m&agrave;u, kiểm tra chất lượng về m&agrave;u sắc.</p>

<p>- Hệ Thống Pha Trộn Dung Dịch - Automatic Mixing and Meter of Solutions (CAM - hỗ trợ sản xuất): Pha dung dịch đạt nồng độ y&ecirc;u cầu trước khi đưa c&aacute;c b&igrave;nh dung dịch v&agrave;o m&aacute;y pha m&agrave;u tự động.&nbsp;&nbsp;&nbsp;</p>

<p>- Hệ Thống Pha M&agrave;u Tự Động - Color Automatic Dispensing (CAM): gồm m&aacute;y pha m&agrave;u tự động điều khiển bằng m&aacute;y t&iacute;nh, để phối trộn c&aacute;c loại m&agrave;u nhuộm theo đ&uacute;ng tỷ lệ nồng độ trong c&ocirc;ng thức đ&atilde; thiết lập từ hệ thống CAD nhằm tạo dung dịch nhuộm th&iacute; nghiệm.</p>

<p>- M&aacute;y Nhuộm Th&iacute; Nghiệm Bằng Tia Hồng Ngoại - Infra Red Dyeing Machine: Thực hiện c&aacute;c qu&aacute; tr&igrave;nh nhuộm theo đ&uacute;ng quy tr&igrave;nh về nhiệt độ v&agrave; thời gian m&ocirc; phỏng trong sản xuất lớn.</p>

<p><span style="color:#FF8C00">►Trong sản xuất nhuộm h&agrave;ng loạt:</span></p>

<p>- Phần mềm quản l&yacute; c&ocirc;ng thức để sản xuất: Thực hiện việc t&iacute;nh to&aacute;n tỷ lệ ho&aacute; chất, phẩm m&agrave;u cho v&agrave;o từng mẻ nhuộm tự động theo khối lượng nhuộm (Scheduling Formula).</p>

<table align="left" border="0" cellpadding="0" cellspacing="0" id="AutoNumber5" style="height:126px; line-height:normal; width:213px">
	<tbody>
		<tr>
			<td>
			<p><img src="http://www.pcworld.com.vn/pcworld/info/misc/2004/4/B0208_GP_TongSoMauKhacBiet.jpg" /><br />
			<br />
			<span style="color:#0000FF">Tổng số m&agrave;u kh&aacute;c biệt giữa hai quả banh đỏ</span></p>
			</td>
		</tr>
	</tbody>
</table>

<div style="clear:both;">&nbsp;</div>

<p>- Phần mềm quản l&yacute; kho ho&aacute; chất thuốc nhuộm - Filling Stock of Dyeing and Auxilary Products: Gi&uacute;p x&aacute;c định số thuốc nhuộm, chi ph&iacute; thuốc nhuộm, ho&aacute; chất cho từng mẻ nhuộm. Thống k&ecirc; lượng ho&aacute; chất sử dụng h&agrave;ng th&aacute;ng, h&agrave;ng năm, theo từng đơn h&agrave;ng, kh&aacute;ch h&agrave;ng, loại sản phẩm.</p>

<p>- Hệ Thống C&acirc;n Điện Tử (nối với m&aacute;y t&iacute;nh) v&agrave; phần mềm đi k&egrave;m: Tự động kiểm so&aacute;t việc c&acirc;n m&agrave;u đ&uacute;ng theo c&ocirc;ng thức (khắc phục trường hợp c&acirc;n sai). Hệ thống n&agrave;y in ra c&aacute;c phiếu c&acirc;n m&agrave;u để kiểm tra theo d&otilde;i việc pha chế phẩm nhuộm c&oacute; đ&uacute;ng c&ocirc;ng thức kh&ocirc;ng.<br />
<br />
- Hệ Thống Kho Thuốc Nhuộm Th&ocirc;ng Minh - Automatic Dyestuff Ware House:&nbsp;Hệ thống n&agrave;y mở rộng từ hệ thống c&acirc;n điện tử nối kết với kho thuốc nhuộm, gi&uacute;p việc lấy thuốc nhuộm từ kho chứa một c&aacute;ch nhanh ch&oacute;ng v&agrave; ch&iacute;nh x&aacute;c theo đ&uacute;ng c&ocirc;ng thức đ&atilde; đưa ra, loại trừ lầm lẫn trong thao t&aacute;c của c&ocirc;ng nh&acirc;n.</p>

<p>- Hệ Thống Pha Trộn Ho&aacute; Chất Dạng Lỏng Tự Động - Dosing of Liquid Products: L&agrave; một hệ thống ph&aacute;t triển của hệ thống pha m&agrave;u đ&atilde; n&oacute;i ở tr&ecirc;n nhưng được d&agrave;nh ri&ecirc;ng cho c&aacute;c ho&aacute; chất trợ ở dạng lỏng, hay đ&atilde; pha lỏng (chemical, auxilary) - ph&acirc;n biệt với thuốc nhuộm (dyestuff)). Hệ thống n&agrave;y pha chế ho&aacute; chất v&agrave; c&aacute;c chất trợ theo số lượng v&agrave; nồng độ định sẵn trong c&ocirc;ng thức m&agrave;u được &#39;l&ocirc;i&#39; ra từ&nbsp; phần mềm quản l&yacute; c&ocirc;ng thức n&oacute;i tr&ecirc;n.</p>

<p>- Hệ Thống Pha M&agrave;u Trung T&acirc;m, Dạng Bột - Dosing of Powder Products:&nbsp;Đ&acirc;y l&agrave; hệ thống robot để lần lượt đưa c&aacute;c hộp đựng phẩm nhuộm dạng bột v&agrave; c&acirc;n đong tự động theo đ&uacute;ng liều lượng cho từng mẻ nhuộm, sau đ&oacute; trộn chung lại th&agrave;nh c&aacute;c dung dịch m&agrave;u nhuộm v&agrave; đưa theo băng tải đến m&aacute;y nhuộm, hoặc đổ v&agrave;o x&ocirc; để mang tới m&aacute;y nhuộm.</p>

<p>- Hệ Thống Pha M&agrave;u Trung T&acirc;m, Dạng Lỏng: Như hệ thống pha m&agrave;u trong ph&ograve;ng th&iacute; nghiệm, nhưng phức tạp hơn v&agrave; kết hợp lu&ocirc;n với việc dẫn dung dịch phẩm nhuộm v&agrave;o thẳng m&aacute;y nhuộm theo chương tr&igrave;nh đ&atilde; đặt sẵn.</p>

<p>- Hệ Thống Điều Khiển (v&agrave; ghi nhận việc thực hiện từng mẻ nhuộm tại từng m&aacute;y nhuộm): Hệ thống n&agrave;y gồm phần mềm tương th&iacute;ch, v&agrave; hệ thống thu nhận t&iacute;n hiệu hoạt động của c&aacute;c m&aacute;y nhuộm để chuyển sang dạng số, đưa về m&aacute;y t&iacute;nh trung t&acirc;m để xử l&yacute; theo từng mẻ nhuộm. Dữ liệu n&agrave;y gi&uacute;p quản l&yacute; từng mẻ nhuộm, thậm ch&iacute; ph&acirc;n t&iacute;ch cả gi&aacute; th&agrave;nh thực tế của từng mẻ nhuộm (năng lượng sử dụng, nước sử dụng...).</p>

<p><span style="color:#FF8C00">►Trong c&ocirc;ng t&aacute;c kiểm tra chất lượng sản phẩm:</span></p>

<p>- Phần mềm quản l&yacute; chất lượng về m&agrave;u sắc v&agrave; ph&acirc;n l&ocirc; sản phẩm theo m&agrave;u sắc: Kết hợp với quang phổ kế cầm tay, gi&uacute;p nh&agrave; sản xuất kiểm tra ph&acirc;n loại sản phẩm theo từng nh&oacute;m m&agrave;u, v&agrave; ph&acirc;n l&ocirc; tự động theo từng nh&oacute;m m&agrave;u để quản l&yacute; sử dụng v&agrave; th&ocirc;ng b&aacute;o cho những đơn vị sản xuất ph&iacute;a sau (c&aacute;c x&iacute; nghiệp May).</p>

<p>- Hệ thống kiểm tra m&agrave;u sắc tự động vải ngay sau khi ho&agrave;n tất: Hệ thống n&agrave;y cực kỳ hiện đại, kết hợp nhiều bộ đo quang phổ kế tr&ecirc;n suốt chiều khổ của vải, gi&uacute;p ghi nhận tự động t&igrave;nh h&igrave;nh chất lượng m&agrave;u sắc tr&ecirc;n từng m&eacute;t vải theo suốt chiều d&agrave;i của cuộn vải để hỗ trợ nh&agrave; sản xuất ph&acirc;n loại v&agrave; đ&aacute;nh gi&aacute; chất lượng trong từng d&acirc;y vải.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>

<p>Với c&aacute;c đầu tư n&ecirc;u tr&ecirc;n, nh&agrave; m&aacute;y nhuộm của bạn sẽ đạt đẳng cấp h&agrave;ng đầu thế giới. Tuy vậy, xin đừng vội lạc quan ngay cả khi bạn c&oacute; đủ tiền để đầu tư hết cả c&aacute;c hệ thống tr&ecirc;n. Đơn giản v&igrave; bạn phải mất cỡ 6 th&aacute;ng để t&igrave;m hiểu v&agrave; khai th&aacute;c được chỉ một hệ thống so m&agrave;u tự động. Ri&ecirc;ng việc chuẩn bị CSDL c&aacute;c m&agrave;u thuốc nhuộm cơ bản đ&atilde; phải mất hơn 4 th&aacute;ng trời trong điều kiện bạn c&oacute; người, c&oacute; trang thiết bị để phục vụ ri&ecirc;ng cho c&ocirc;ng t&aacute;c n&agrave;y. 2 th&aacute;ng trời để nắm vững hệ thống phần mềm phức tạp l&agrave; kh&aacute; ngắn, đ&ograve;i hỏi c&aacute;n bộ kỹ thuật phải c&oacute; tr&igrave;nh độ, am hiểu về l&yacute; thuyết m&agrave;u, am hiểu về hệ thống thuốc nhuộm, giao diện phức tạp to&agrave;n d&ugrave;ng tiếng Anh, v&agrave; d&ugrave;ng to&agrave;n từ chuy&ecirc;n m&ocirc;n trong ng&agrave;nh Nhuộm.</p>

<p>Do đ&oacute;, d&ugrave; kỹ sư Ho&aacute; c&oacute; thực giỏi nhưng lỡ &iacute;t biết tiếng Anh cũng sẽ gặp rất nhiều kh&oacute; khăn; m&agrave; chuy&ecirc;n gia m&aacute;y t&iacute;nh thuần t&uacute;y cũng b&oacute; tay v&igrave; c&aacute;c thuật ngữ ng&agrave;nh. Phải am hiểu hệ thống m&aacute;y t&iacute;nh (nếu bạn đầu tư hơn một trạm sử dụng, bạn phải nắm kỹ thuật mạng NT v&agrave; hệ quản trị CSDL cỡ Sybase hay SQL Server), nếu kh&ocirc;ng muốn nhất cử nhất động phải đ&oacute;ng m&aacute;y, cầu cứu chuy&ecirc;n gia nước ngo&agrave;i!</p>

<p>Việc tiếp nhận v&agrave; nghi&ecirc;n cứu sử dụng tuy kh&oacute; nhưng chỉ cần 1-2 c&aacute;n bộ kỹ thuật giỏi l&agrave; giải quyết được. Kh&oacute; khăn gian khổ nhất l&agrave; phải đổi mới c&ocirc;ng t&aacute;c quản l&yacute; dựa tr&ecirc;n ti&ecirc;u chuẩn mới. Phải mất h&agrave;ng năm trời để x&acirc;y dựng lại hệ thống th&ocirc;ng tin nội bộ trong x&iacute; nghiệp Nhuộm cho khớp với c&aacute;c y&ecirc;u cầu m&agrave; hệ thống quản l&yacute; m&agrave;u sắc điện tử đặt ra. Bạn phải thiết lập bộ m&atilde; thống nhất trong x&iacute; nghiệp nhuộm của bạn, như lập m&atilde; số thuốc nhuộm, ho&aacute; chất, m&atilde; số c&ocirc;ng thức m&agrave;u, m&atilde; số thiết bị, m&atilde; số đơn h&agrave;ng, kh&aacute;ch h&agrave;ng, loại nguy&ecirc;n vật liệu, m&atilde; nh&oacute;m thuốc nhuộm...</p>

<p>Ngo&agrave;i ra, phải thiết lập một loạt quy định để bảo đảm 100% c&ocirc;ng thức m&agrave;u được quản l&yacute; bằng m&aacute;y t&iacute;nh, v&agrave; việc cập nhật c&aacute;c m&agrave;u sắc c&ugrave;ng c&aacute;c th&ocirc;ng số nhuộm cũng được thực hiện 100% tr&ecirc;n hệ thống m&aacute;y t&iacute;nh.</p>

<p>Tất cả đ&ograve;i hỏi vị gi&aacute;m đốc đơn vị phải quyết t&acirc;m chỉ đạo thực hiện, c&ograve;n tất cả c&aacute;n bộ li&ecirc;n quan phải to&agrave;n t&acirc;m to&agrave;n &yacute; cho c&ocirc;ng t&aacute;c n&agrave;y, đặc biệt l&agrave; đối với c&aacute;c doanh nghiệp lớn đ&atilde; c&oacute; nhiều năm hoạt động. Do đ&oacute;, việc đầu tư trang bị từng hệ thống, phần mềm như tr&ecirc;n l&agrave; cần thiết, nhưng đừng qu&ecirc;n đầu tư v&agrave;o con người cho hệ thống quản l&yacute; hiện hữu.&nbsp;<br />
<br />
<span style="color:#FF8C00">►Vẫn chưa thỏa m&atilde;n&#39;Thượng đế&#39;?</span></p>

<table align="left" border="0" cellpadding="0" cellspacing="0" id="AutoNumber6" style="height:105px; line-height:normal; width:213px">
	<tbody>
		<tr>
			<td>
			<p><img src="http://www.pcworld.com.vn/pcworld/info/misc/2004/4/B0208_GP_QuangPhoKe.jpg" /><br />
			<br />
			<span style="color:#0000FF">Quang phổ kế Microflash (Datacolor) gi&uacute;p đo m&agrave;u sắc của quả banh</span></p>
			</td>
		</tr>
	</tbody>
</table>

<div style="clear:both;">&nbsp;</div>

<p>Chưa hết, d&ugrave; đ&atilde; giải quyết xong vấn đề nội bộ nhưng chuyện sau mới rắc rối: M&aacute;y đ&atilde; cho ?E &lt;0.05 (ti&ecirc;u chuẩn đ&aacute;nh gi&aacute; về độ ch&ecirc;nh lệch m&agrave;u sắc) nhưng kh&aacute;ch h&agrave;ng vẫn bảo &#39;kh&ocirc;ng đạt khi so bằng mắt thường&#39;.&nbsp;<br />
<br />
Vậy l&agrave; sao? Hệ thống h&agrave;ng trăm triệu đồng của bạn l&agrave; kh&ocirc;ng ch&iacute;nh x&aacute;c?<br />
<br />
Kh&ocirc;ng phải, nhưng &#39;sự cố&#39; n&agrave;y đ&ograve;i hỏi bạn phải thay đổi cả c&aacute;ch l&agrave;m việc với kh&aacute;ch h&agrave;ng:&nbsp;<br />
- Khi nhận đơn h&agrave;ng, phải hỏi r&otilde;: Kh&aacute;ch h&agrave;ng sẽ sử dụng sản phẩm n&agrave;y ở đ&acirc;u, trong nh&agrave; dưới &aacute;nh s&aacute;ng nh&acirc;n tạo, hay &aacute;nh s&aacute;ng ban ng&agrave;y ngo&agrave;i trời? Điều n&agrave;y rất quan trọng để tr&aacute;nh c&aacute;c bất đồng sau n&agrave;y. Sau đ&oacute;, bạn phải điều chỉnh th&iacute;ch hợp nguồn s&aacute;ng của quang phổ kế ph&ugrave; hợp với điều kiện kh&aacute;ch h&agrave;ng đưa ra. V&agrave; cũng đừng qu&ecirc;n nhắc kh&aacute;ch h&agrave;ng: Khi so mẫu, cần phải so dưới điều kiện chuẩn (so bằng Light Box) với nguồn s&aacute;ng th&iacute;ch hợp.</p>

<p>- Cũng kh&ocirc;ng loại trừ khả năng người kiểm tra sản phẩm c&oacute;... khuyết tật tr&ecirc;n v&otilde;ng mạc, số lượng tế b&agrave;o h&igrave;nh cone ph&acirc;n bố kh&ocirc;ng đều cũng dẫn tới t&igrave;nh trạng n&agrave;y (!). L&uacute;c đ&oacute;, cần kh&eacute;o l&eacute;o thuyết phục kh&aacute;ch h&agrave;ng &#39;đừng tin v&agrave;o mắt m&igrave;nh m&agrave; h&atilde;y tin v&agrave;o m&aacute;y&#39;. Nếu kh&oacute; qu&aacute;, đ&agrave;nh phải thả một... Bug v&agrave;o phần mềm đ&aacute;nh dấu vị kh&aacute;ch h&agrave;ng đặc biệt n&agrave;y để về sau khi thực hiện đơn h&agrave;ng cho họ, ta sẽ lưu &yacute; tất cả m&agrave;u phải lệch sang &aacute;nh xanh một t&iacute; chẳng hạn, cho vừa l&ograve;ng &#39;thượng đế&#39;!<br />
<br />
<span style="color:#FF8C00">►Thiết bị, giải ph&aacute;p n&agrave;o tr&ecirc;n thị trường?</span><br />
<br />
Hiện c&oacute; nhiều loại phần mềm li&ecirc;n quan đến việc quản l&yacute; m&agrave;u sắc, quản l&yacute; sản xuất theo m&agrave;u sắc tr&ecirc;n thị trường. C&oacute; nh&agrave; cung cấp thực hiện từ A đến Z như DataColor (chế tạo lu&ocirc;n quang phổ kế v&agrave; c&aacute;c thiết bị CAM, phần mềm đi theo), nổi tiếng l&agrave; c&aacute;c sản phẩm DataMatch, ITM Process.</p>

<p>C&oacute; nh&agrave; cung cấp lại sử dụng quang phổ kế chuy&ecirc;n dụng h&agrave;ng đầu thế giới (như Matchbec) v&agrave; bi&ecirc;n soạn phần mềm ri&ecirc;ng của m&igrave;nh để tập trung thiết kế chế tạo đủ c&aacute;c hệ thống CAD/CAM cho suốt qu&aacute; tr&igrave;nh sản xuất của ng&agrave;nh nhuộm, v&iacute; dụ như Orintex (Italia).</p>

<p>C&aacute;c nh&agrave; sản xuất ch&acirc;u &Aacute; chuy&ecirc;n chế tạo c&aacute;c thiết bị CAM, nhất l&agrave; hệ thống Color Dispensing - nổi tiếng nhất l&agrave; CoPower (nay đ&atilde; s&aacute;p nhập v&agrave;o DataColor). Logic ART (LA) nổi tiếng với hệ thống kho th&ocirc;ng minh, hệ thống pha ho&aacute; chất dạng lỏng...</p>

<p>Vậy chọn lựa đầu tư như thế n&agrave;o?&nbsp;<br />
Đầu tư đến đ&acirc;u l&agrave; một c&acirc;u hỏi m&agrave; người viết muốn hỏi lại c&aacute;c doanh nghiệp.<br />
<br />
Ch&iacute;nh x&aacute;c hơn, bạn h&atilde;y thử trả lời c&aacute;c c&acirc;u hỏi sau trước khi quyết định số ho&aacute; to&agrave;n bộ quy tr&igrave;nh nhuộm của đơn vị m&igrave;nh: Đội ngũ kỹ thuật của c&ocirc;ng ty bạn hiện nay ra sao? Hệ thống quản l&yacute; c&ocirc;ng thức v&agrave; h&oacute;a chất thuốc nhuộm của c&ocirc;ng ty bạn như thế n&agrave;o? Bạn c&oacute; bao nhi&ecirc;u loại vật liệu vải c&oacute; kết cấu kh&aacute;c nhau? Bạn muốn biết th&ocirc;ng tin g&igrave; để quản l&yacute;? V&agrave;, đương nhi&ecirc;n, bạn định đầu tư bao nhi&ecirc;u tiền cho c&ocirc;ng t&aacute;c n&agrave;y?</p>

<p><strong>B&agrave;i viết từ Hồng Khắc &Aacute;i Nh&acirc;n</strong></p>
', 0, 249, CAST(N'2016-08-31 19:39:30.137' AS DateTime), 10, 1, 2)
INSERT [dbo].[NEWS] ([ID], [Title], [Tag], [News_Sapo], [Image], [Content], [IsHot], [TotalView], [Date], [ID_UserPost], [Active], [ID_GroupNews]) VALUES (17, N'Giải pháp ERP ứng dụng cho ngành nhuộm', N'giai-phap-erp-ung-dung-cho-nganh-nhuom', N'<p><a href="https://tinhte.vn/tags/enterprise-resource-planning-software/">Enterprise resource planning software</a>, viết tắt l&agrave; <a href="https://tinhte.vn/tags/erp/">ERP</a>, l&agrave; một giải ph&aacute;p phần mềm ra đời cũng đ&atilde; kh&aacute; l&acirc;u với mục đ&iacute;ch hỗ trợ việc quản trị một c&ocirc;ng ty. Phần mềm n&agrave;y kh&ocirc;ng sử dụng cho từng c&aacute; nh&acirc;n m&agrave; sẽ gi&uacute;p đỡ doanh nghiệp trong c&aacute;c hoạt động thường nhật của m&igrave;nh, bởi vậy mới c&oacute; chữ &ldquo;Enterprise&rdquo; (doanh nghiệp, c&ocirc;ng ty) trong c&aacute;i t&ecirc;n của n&oacute;. Chức năng ch&iacute;nh của ERP đ&oacute; l&agrave; t&iacute;ch hợp tất cả mọi ph&ograve;ng ban, mọi chức năng của c&ocirc;ng ty lại trong một hệ thống m&aacute;y t&iacute;nh duy nhất để dễ theo d&otilde;i hơn, nhưng đồng thời cũng đủ linh hoạt để đ&aacute;p ứng nhiều nhu cầu kh&aacute;c nhau. N&oacute;i c&aacute;ch kh&aacute;c, bạn c&oacute; thể tưởng tượng ERP như một phần mềm khổng lồ, n&oacute; c&oacute; khả năng l&agrave;m được những việc về t&agrave;i ch&iacute;nh, nh&acirc;n sự, sản xuất, quản l&yacute; chuỗi cung ứng v&agrave; rất rất nhiều những thứ kh&aacute;c.</p>
', N'/Upload/images/ERP SYSTEM.png', N'<p><span style="color:#008080"><strong>1. Erp l&agrave; g&igrave;</strong></span></p>

<p><a href="https://tinhte.vn/tags/enterprise-resource-planning-software/">Enterprise resource planning software</a>, viết tắt l&agrave; <a href="https://tinhte.vn/tags/erp/">ERP</a>, l&agrave; một giải ph&aacute;p phần mềm ra đời cũng đ&atilde; kh&aacute; l&acirc;u với mục đ&iacute;ch hỗ trợ việc quản trị một c&ocirc;ng ty. Phần mềm n&agrave;y kh&ocirc;ng sử dụng cho từng c&aacute; nh&acirc;n m&agrave; sẽ gi&uacute;p đỡ doanh nghiệp trong c&aacute;c hoạt động thường nhật của m&igrave;nh, bởi vậy mới c&oacute; chữ &ldquo;Enterprise&rdquo; (doanh nghiệp, c&ocirc;ng ty) trong c&aacute;i t&ecirc;n của n&oacute;. Chức năng ch&iacute;nh của ERP đ&oacute; l&agrave; t&iacute;ch hợp tất cả mọi ph&ograve;ng ban, mọi chức năng của c&ocirc;ng ty lại trong một hệ thống m&aacute;y t&iacute;nh duy nhất để dễ theo d&otilde;i hơn, nhưng đồng thời cũng đủ linh hoạt để đ&aacute;p ứng nhiều nhu cầu kh&aacute;c nhau. N&oacute;i c&aacute;ch kh&aacute;c, bạn c&oacute; thể tưởng tượng ERP như một phần mềm khổng lồ, n&oacute; c&oacute; khả năng l&agrave;m được những việc về t&agrave;i ch&iacute;nh, nh&acirc;n sự, sản xuất, quản l&yacute; chuỗi cung ứng v&agrave; rất rất nhiều những thứ kh&aacute;c.</p>

<p><img alt="" src="/Upload/images/ERP.jpg" style="height:340px; width:500px" /></p>

<p><span style="color:#008080"><strong>2. C&aacute;c t&iacute;nh năng ch&iacute;nh của ERP</strong></span></p>

<p>- Quản trị quan hệ kh&aacute;ch h&agrave;ng</p>

<p>- Quản trị mua h&agrave;ng</p>

<p>- Quản trị b&aacute;n h&agrave;ng</p>

<p>- Quản trị kho</p>

<p>- Quản trị sản xuất</p>

<p>- T&agrave;i ch&iacute;nh kế to&aacute;n</p>

<p>- Quản trị nh&acirc;n sự</p>

<p>- Quản trị c&ocirc;ng nghệ</p>

<p><span style="color:#008080"><strong>3. ERP gi&uacute;p cho c&aacute;c c&ocirc;ng ty như thế n&agrave;o ?</strong></span></p>

<p>Hi vọng lớn nhất đối với ERP đ&oacute; l&agrave; n&oacute; c&oacute; thể cải thiện việc xử l&iacute; đơn h&agrave;ng cũng như những thứ li&ecirc;n quan đến doanh thu, lợi nhuận, xuất h&oacute;a đơn&hellip; Đ&acirc;y l&agrave; những thứ được gọi với c&aacute;i t&ecirc;n &ldquo;<strong>fulfillment process</strong>&rdquo;, v&agrave; cũng v&igrave; l&yacute; do n&agrave;y m&agrave; ERP hay được gọi l&agrave; một &ldquo;<strong>phần mềm chống lưng</strong>&rdquo; cho văn ph&ograve;ng. Trong thời gian khoảng 10 năm trở lại đ&acirc;y c&oacute; xuất hiện th&ecirc;m một số module để quản l&yacute; kh&aacute;ch h&agrave;ng, chứ trước đ&oacute; ERP chỉ tập trung v&agrave;o việc tự động h&oacute;a những bước kh&aacute;c nhau trong hoạt động của c&ocirc;ng ty sản xuất.</p>

<p>Khi một nh&acirc;n vi&ecirc;n nhập th&ocirc;ng tin đơn h&agrave;ng v&agrave;o, anh ta sẽ c&oacute; hết tất cả những th&ocirc;ng tin cần thiết để ho&agrave;n tất order. Ngo&agrave;i ra, tất cả những nh&acirc;n vi&ecirc;n kh&aacute;c c&oacute; li&ecirc;n quan đều c&oacute; thể cập nhật th&ocirc;ng tin v&agrave; c&oacute; thể theo d&otilde;i tiến độ của một đơn h&agrave;ng bất k&igrave; khi n&agrave;o. ERP mang lại một thứ &ldquo;ma thuật&rdquo; gi&uacute;p kh&aacute;ch h&agrave;ng nhận thứ m&igrave;nh mua nhanh hơn v&igrave; th&ocirc;ng tin &iacute;t bị trễ, &iacute;t lỗi hơn, v&agrave; &ldquo;ma thuật&rdquo; đ&oacute; cũng &aacute;p dụng cho cả những hoạt động kh&aacute;c như t&iacute;nh lương cho nh&acirc;n vi&ecirc;n hay tạo b&aacute;o c&aacute;o t&agrave;i ch&iacute;nh.</p>

<p>N&oacute;i t&oacute;m lại một số lợi &iacute;ch ERP c&oacute; thể gi&uacute;p &iacute;ch cho c&ocirc;ng ty như sau:</p>

<p>- C&aacute;c ph&ograve;ng ban phối hợp hoạt động hiệu quả</p>

<p>- Th&ocirc;ng tin quản trị đ&aacute;ng tin cậy</p>

<p>- Theo d&otilde;i lượng h&agrave;ng tồn kho.</p>

<p>- Chuẩn h&oacute;a th&ocirc;ng tin nh&acirc;n sự</p>

<p>- T&iacute;ch hợp th&ocirc;ng tin đặt h&agrave;ng của kh&aacute;ch h&agrave;ng v&agrave; theo d&otilde;i đơn h&agrave;ng.</p>

<p>- Tăng hiệu suất sản xuất</p>

<p>- Quy tr&igrave;nh kinh doanh được x&aacute;c định r&otilde; r&agrave;ng hơn</p>

<p><span style="color:#008080"><strong>4. ERP cho ng&agrave;nh nhuộm</strong></span></p>

<p><span style="color:#008080"><strong><img alt="" src="/Upload/images/ERP%20SYSTEM.png" style="height:772px; width:738px" /></strong></span></p>

<p><span style="color:#008080"><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; M&Ocirc; H&Igrave;NH ERP CHO NG&Agrave;NH NHUỘM VẢI</strong></span></p>

<p>- Ở Việt Nam đ&atilde; c&oacute; c&aacute;c doanh nghiệp sử dụng <a href="http://crmviet.vn/he-thong-erp-la-gi-co-giup-hoach-dinh-nguon-luc/">hệ thống ERP</a> nhưng chưa r&otilde; r&agrave;ng .&Iacute;t c&ocirc;ng ty phần mềm x&acirc;y dụng đầy đủ t&iacute;nh năng c&aacute;c module theo chuẩn so với c&aacute;c hệ thống ERP tr&ecirc;n thế giới. Bạn nghi&ecirc;n cứu kỹ trước khi lựa chọn một giải ph&aacute;p tốt nhất. Giải ph&aacute;p đ&oacute; c&oacute; đ&aacute;p ứng được c&aacute;c nhu cầu hiện tại v&agrave; tương lai kh&ocirc;ng? N&oacute; c&oacute; kết hợp được với c&aacute;c giải ph&aacute;p kh&aacute;c kh&ocirc;ng? T&iacute;nh năng n&agrave;o l&agrave; quan trọng nhất ?</p>

<p>- Hy vọng qua b&agrave;i viết ERP l&agrave; g&igrave; &ndash; C&oacute; hoạch định nguồn lực doanh nghiệp kh&ocirc;ng, bạn t&igrave;m được giải ph&aacute;p cho doanh nghiệp m&igrave;nh. Ng&agrave;nh c&ocirc;ng nghệ phần mềm doanh nghiệp Việt Nam đang c&oacute; những bước ph&aacute;t triển s&acirc;u rộng đột ph&aacute; khi hội nhập. Gi&uacute;p c&aacute;c doanh nghiệp Việt c&oacute; được một giải ph&aacute;p tinh vi, đ&aacute;p ứng v&agrave; định hướng được c&aacute;c nhu cầu hiện tại hay ph&aacute;t sinh trong tương lai.</p>

<p>- Bạn cũng n&ecirc;n lưu &yacute; c&acirc;n nhắc hệ thống erp c&oacute;&nbsp;ph&ugrave; hợp với&nbsp;doanh nghiệp bạn kh&ocirc;ng ? Nếu quy m&ocirc; Doanh nghiệp của bạn dưới 50 người th&igrave; việc sử dụng &nbsp;<a href="http://crmviet.vn/erp-la-gi-co-hoach-dinh-nguon-luc-doanh-nghiep/crmviet.vn">phần mềm CRM l</a>ại ph&ugrave; hợp hơn v&igrave; n&oacute; tập trung v&agrave;o Kinh doanh v&agrave; kh&aacute;ch h&agrave;ng hơn việc vận h&agrave;nh cũng đơn giản hơn.</p>

<p>- Trong b&agrave;i viết sau, ch&uacute;ng ta về c&ugrave;ng ph&acirc;n t&iacute;ch s&acirc;u hơn về giải ph&aacute;p ERP cho ng&agrave;nh nhuộm được ứng dụng từng bộ phận.</p>

<p>&nbsp;</p>

<p><iframe frameborder="0" height="292" scrolling="no" src="https://www.facebook.com/plugins/page.php?href=https%3A%2F%2Fwww.facebook.com%2FBaoTinSoft%2F&amp;tabs=timeline&amp;width=340&amp;height=292&amp;small_header=false&amp;adapt_container_width=true&amp;hide_cover=false&amp;show_facepile=true&amp;appId" style="border:none;overflow:hidden" width="340"></iframe></p>

<p>&nbsp;</p>
', 1, 44, CAST(N'2017-11-16 11:34:24.297' AS DateTime), 10, 1, 2)
SET IDENTITY_INSERT [dbo].[NEWS] OFF
SET IDENTITY_INSERT [dbo].[ORDER_DETAILS] ON 

INSERT [dbo].[ORDER_DETAILS] ([ID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (1, 1, 1, 1, CAST(180000 AS Decimal(18, 0)))
INSERT [dbo].[ORDER_DETAILS] ([ID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (2, 1, 2, 1, CAST(250000 AS Decimal(18, 0)))
INSERT [dbo].[ORDER_DETAILS] ([ID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (3, 2, 1, 2, CAST(180000 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[ORDER_DETAILS] OFF
SET IDENTITY_INSERT [dbo].[ORDER_PRODUCTS] ON 

INSERT [dbo].[ORDER_PRODUCTS] ([ID], [CustomerName], [Mobile], [Email], [Address], [Date], [CustomerNote], [StatusID], [TypePayment], [TypeShipping]) VALUES (1, N'Thành Nam', N'0939203910', N'namnguyen1251@gmail.com', N'TP.HCM', CAST(N'2015-07-29 00:00:00.000' AS DateTime), N'Giao hàng nhận tiền', 6, N'Thanh toán tại nhà', NULL)
INSERT [dbo].[ORDER_PRODUCTS] ([ID], [CustomerName], [Mobile], [Email], [Address], [Date], [CustomerNote], [StatusID], [TypePayment], [TypeShipping]) VALUES (2, N'Thanh Tùng', N'01649660245', N'thanhtung@gmail.com', N'Hà Nội', CAST(N'2015-07-28 00:00:00.000' AS DateTime), N'Thanh toán tại nhà', 6, N'Thanh toán tại nhà', NULL)
SET IDENTITY_INSERT [dbo].[ORDER_PRODUCTS] OFF
SET IDENTITY_INSERT [dbo].[ORDER_STATUSES] ON 

INSERT [dbo].[ORDER_STATUSES] ([ID], [Name]) VALUES (1, N'Đã xử lý')
INSERT [dbo].[ORDER_STATUSES] ([ID], [Name]) VALUES (2, N'Chưa xử lý')
INSERT [dbo].[ORDER_STATUSES] ([ID], [Name]) VALUES (3, N'Đơn hàng hủy')
INSERT [dbo].[ORDER_STATUSES] ([ID], [Name]) VALUES (4, N'Đang giao hàng')
INSERT [dbo].[ORDER_STATUSES] ([ID], [Name]) VALUES (5, N'Chờ khách thanh toán')
INSERT [dbo].[ORDER_STATUSES] ([ID], [Name]) VALUES (6, N'Đơn hàng mới')
SET IDENTITY_INSERT [dbo].[ORDER_STATUSES] OFF
SET IDENTITY_INSERT [dbo].[PAGES] ON 

INSERT [dbo].[PAGES] ([ID], [Title], [Content], [Logo], [Slogan], [Description], [Keyword], [Image], [Favicon], [GoogleAnalytics], [MapCode], [Fanpage], [Copyright], [Contact]) VALUES (1, N'Bao Tin Software', N'', N'/Upload/images/Icons/baotinsoftware_com_logo.png', N'Hotline: 0988.898996 Lộc', N'Phần mềm quản lý mộc
Phần mềm quản lý hóa chất - thuốc nhuộm
Phần mềm quản lý dệt 
Hệ thống cân chất lỏng tự động', N'Phần mềm quản lý mộc
Phần mềm quản lý hóa chất - thuốc nhuộm
Phần mềm quản lý dệt 
Hệ thống cân chất lỏng tự động
Hệ thống cân thuốc tự động
Phần mềm quản lý máy nhuộm
Phần mềm quản lý kế hoạch máy định hình', N'/Upload/images/Icons/logo.png', N'/Upload/images/Icons/favicon-baotinsoftware.jpg', N'Phần mềm quản lý mộc
Phần mềm quản lý hóa chất - thuốc nhuộm
Phần mềm quản lý dệt 
Hệ thống cân chất lỏng tự động
Hệ thống cân thuốc tự động
Phần mềm quản lý máy nhuộm
Phần mềm quản lý kế hoạch máy định hình', N'<iframe src="https://www.google.com/maps/d/u/0/embed?mid=1uOPnPXqaAv_dqVtT_MTSWSdsMxM&z=15" width="100%" height="385px" frameborder="0"></iframe>', N'baotinsoftware@gmail.com', N'<p>Copyright &copy; 2016 Bao Tin Company LTD. All rights reserved.</p>
', N'<h4 style="text-align:center">C&Ocirc;NG TY TNHH ĐIỆN TỬ VIỄN TH&Ocirc;NG BẢO T&Iacute;N</h4>

<p style="text-align:center">Địa chỉ : 232/2B Nguyễn Văn Lượng, P.17, Q.G&ograve; Vấp, TP.HCM</p>

<p style="text-align:center">Điện thoại : 08.69633879&nbsp;- Fax :08.38953482</p>

<p style="text-align:center">Skype : <a href="Skype:baotinsoftware?chat"> Baotinsoftware</a></p>

<p style="text-align:center">Email : <a href="mailto:baotinsoftware@gmail.com">baotinsoftware@gmail.com</a></p>

<p style="text-align:center">&nbsp;<a href="http://baotinsoftware.com/" target="blank">http://baotinsoftware.com/</a></p>

<p style="text-align:center"><a href="http://baotinsofware.com">http://baotinsoftware.com.vn</a></p>
')
SET IDENTITY_INSERT [dbo].[PAGES] OFF
SET IDENTITY_INSERT [dbo].[PRODUCT_COLORS] ON 

INSERT [dbo].[PRODUCT_COLORS] ([ProductColorId], [ColorId], [ProductId], [Price]) VALUES (117, 2, 7, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PRODUCT_COLORS] ([ProductColorId], [ColorId], [ProductId], [Price]) VALUES (118, 3, 7, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PRODUCT_COLORS] ([ProductColorId], [ColorId], [ProductId], [Price]) VALUES (119, 4, 7, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PRODUCT_COLORS] ([ProductColorId], [ColorId], [ProductId], [Price]) VALUES (120, 5, 7, CAST(0 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[PRODUCT_COLORS] OFF
SET IDENTITY_INSERT [dbo].[PRODUCT_IMAGES] ON 

INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (745, N'/Upload/images/wax_resin.jpg', N'Armor', 5)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (746, N'/Upload/images/DECAL2.jpg', N'', 10)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (747, N'/Upload/images/DI28SS.jpg', N'', 2)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (947, N'/Upload/images/PCIndustry-1.jpg', N'Mặt sau máy tính', 1)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1492, N'/Upload/images/MOHINHQUANLY.jpg', N'Mô hình quản lý hóa chất', 17)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1493, N'/Upload/images/LOGINHC.jpg', N'Đăng nhập hệ thống', 17)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1494, N'/Upload/images/CTN.jpg', N'Công thức nhuộm', 17)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1495, N'/Upload/images/TAOPHIEUCAN.jpg', N'Tạo phiếu cân', 17)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1496, N'/Upload/images/NXT HOA CHAT.jpg', N'NXT hóa chất', 17)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1497, N'/Upload/images/PHIEUCAN.jpg', N'Phiếu cân thuốc', 17)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1498, N'/Upload/images/PhieuChamChinh.png', N'Phiếu châm chỉnh ', 17)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1499, N'/Upload/images/Products/img_4-600x380.jpg', N'Quản trị từ xa hệ thống', 17)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1500, N'/Upload/images/QLMOC.jpg', N'Mô hình quản lý mộc', 18)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1501, N'/Upload/images/LOGIN.jpg', N'Login phần mềm mộc', 18)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1502, N'/Upload/images/Products/NHAP MOC.jpg', N'Nhập mộc', 18)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1503, N'/Upload/images/ReportMoc.jpg', N'NXT Tồn mộc', 18)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1504, N'/Upload/images/PHANME.jpg', N'Phân mẻ', 18)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1505, N'/Upload/images/DINHHINH.jpg', N'Định Hình', 18)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1506, N'/Upload/images/KHOTP.jpg', N'Kho Thành Phẩm', 18)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1507, N'/Upload/images/XUATHANG.jpg', N'Xuất hàng', 18)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1508, N'/Upload/images/CONGNO.jpg', N'Theo Dõi Công Nợ', 18)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1509, N'/Upload/images/Products/img_4-600x380.jpg', N'Quản trị từ xa hệ thống', 18)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1510, N'/Upload/images/Login.png', N'Login hệ thống', 6)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1511, N'/Upload/images/Nhap Kho.png', N'Nhập kho cửa hàng', 6)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1512, N'/Upload/images/XB1.png', N'Xuất bán', 6)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1513, N'/Upload/images/XB2.png', N'Chi tiết xuất bán', 6)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1514, N'/Upload/images/NXT Kho.png', N'Nhập xuất tồn kho', 6)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1515, N'/Upload/images/CN.png', N'Công nợ khách hàng', 6)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1516, N'/Upload/images/PHIEU GIAO HANG2.png', N'Phiếu giao hàng', 6)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1517, N'/Upload/images/Products/img_8-600x380.jpg', N'Quản trị hệ thống từ xa', 6)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1550, N'/Upload/images/XeCanThuoc.jpg', N'Xe Cân Thuốc', 8)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1551, N'/Upload/images/BANCANDI28SS.jpg', N'Cân Lớn ', 8)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1552, N'/Upload/images/CanNho.jpg', N'Cân Nhỏ ', 8)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1553, N'/Upload/images/PCIndustry-1.jpg', N'Máy Tính Công Nghiệp', 8)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1554, N'/Upload/images/MayQuetMaVach.jpg', N'Máy quét mã vạch', 8)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1555, N'/Upload/images/4.jpg', N'Tổng Thể Mô Hình - 01', 8)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1556, N'/Upload/images/2.jpg', N'Tổng Thể - 02', 8)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1557, N'/Upload/images/1.jpg', N'Tổng Thể - 03', 8)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1558, N'/Upload/images/3.jpg', N'Đèn Báo Vị Trí', 8)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1559, N'/Upload/images/5.jpg', N'Xe Cân Thuốc Nhuộm', 8)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1560, N'/Upload/images/6.jpg', N'Hóa Chất ', 8)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1561, N'/Upload/images/Products/img_4-600x380.jpg', N'Quản trị hệ thống từ xa', 8)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1562, N'/Upload/images/CWAuto-NoPump.png', N'Mặt bằng 1', 19)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1563, N'/Upload/images/AUTO NO PUM 1.jpg', N'Mặt bằng 2', 19)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1564, N'/Upload/images/AUTO NO PUM 2.jpg', N'Mặt bằng 3', 19)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1565, N'/Upload/images/CWAUTO.jpg', N'Tủ điều khiển cân', 19)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1566, N'/Upload/images/AutoPumSoftware.jpg', N'Phần mềm cân Auto', 19)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1567, N'/Upload/images/Products/img_4-600x380.jpg', N'Quản trị hệ thống từ xa', 19)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1588, N'/Upload/images/KeHoach.png', N'Lập kế hoạch căng', 7)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1589, N'/Upload/images/Week.png', N'Lịch căng theo ngày', 7)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1590, N'/Upload/images/Week2.png', N'Lịch căng theo tuần', 7)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1591, N'/Upload/images/Month.png', N'Lịch căng theo tháng', 7)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1592, N'/Upload/images/TimeLine.png', N'Theo dõi thực tế', 7)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1593, N'/Upload/images/Products/img_4-600x380.jpg', N'Quản trị hệ thống từ xa', 7)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1594, N'/Upload/images/MainTank.jpg', N'Main Tank Chemical', 9)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1595, N'/Upload/images/three way valves.jpg', N'Three way valves', 9)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1596, N'/Upload/images/CWAUTO.jpg', N'Tủ điều khiển cân', 20)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1597, N'/Upload/images/ToughScreen.JPG', N'Màn hình cân', 20)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1598, N'/Upload/images/Valve.JPG', N'Valve điều khiển', 20)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1599, N'/Upload/images/StationPump.png', N'Trạm bơm hóa chất', 20)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1600, N'/Upload/images/CWAUTO-2.jpg', N'Tổng quan', 20)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1601, N'/Upload/images/AutoPumSoftware.jpg', N'Phần mềm cân auto', 20)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1602, N'/Upload/images/Products/img_4-600x380.jpg', N'Quản trị hệ thống từ xa', 20)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1603, N'/Upload/images/PhanMe.png', N'Phân mẻ ', 15)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1604, N'/Upload/images/CANTP.png', N'Cân thành phẩm', 15)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1605, N'/Upload/images/XUATHANG-QUET.png', N'Xuất hàng thành phẩm', 15)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1606, N'/Upload/images/GiaoHang.png', N'Phiếu giao hàng', 15)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1607, N'/Upload/images/NXT.png', N'Báo cáo NXT kho thành phẩm', 15)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (1608, N'/Upload/images/Products/img_4-600x380.jpg', N'Quản trị hệ thống từ xa', 15)
INSERT [dbo].[PRODUCT_IMAGES] ([ID], [Path], [Note], [ID_Products]) VALUES (2611, N'/Upload/images/News_Events/Introduction-600x380.jpg', N'', 4)
SET IDENTITY_INSERT [dbo].[PRODUCT_IMAGES] OFF
SET IDENTITY_INSERT [dbo].[PRODUCT_SIZES] ON 

INSERT [dbo].[PRODUCT_SIZES] ([ProductSizeId], [SizeId], [ProductId], [Price]) VALUES (742, 2, 17, CAST(10000 AS Decimal(18, 0)))
INSERT [dbo].[PRODUCT_SIZES] ([ProductSizeId], [SizeId], [ProductId], [Price]) VALUES (743, 3, 17, CAST(15000 AS Decimal(18, 0)))
INSERT [dbo].[PRODUCT_SIZES] ([ProductSizeId], [SizeId], [ProductId], [Price]) VALUES (744, 4, 17, CAST(29000 AS Decimal(18, 0)))
INSERT [dbo].[PRODUCT_SIZES] ([ProductSizeId], [SizeId], [ProductId], [Price]) VALUES (745, 5, 17, CAST(38000 AS Decimal(18, 0)))
INSERT [dbo].[PRODUCT_SIZES] ([ProductSizeId], [SizeId], [ProductId], [Price]) VALUES (746, 2, 18, CAST(10000 AS Decimal(18, 0)))
INSERT [dbo].[PRODUCT_SIZES] ([ProductSizeId], [SizeId], [ProductId], [Price]) VALUES (747, 3, 18, CAST(15000 AS Decimal(18, 0)))
INSERT [dbo].[PRODUCT_SIZES] ([ProductSizeId], [SizeId], [ProductId], [Price]) VALUES (748, 4, 18, CAST(25000 AS Decimal(18, 0)))
INSERT [dbo].[PRODUCT_SIZES] ([ProductSizeId], [SizeId], [ProductId], [Price]) VALUES (749, 5, 18, CAST(35000 AS Decimal(18, 0)))
INSERT [dbo].[PRODUCT_SIZES] ([ProductSizeId], [SizeId], [ProductId], [Price]) VALUES (759, 2, 20, CAST(10000 AS Decimal(18, 0)))
INSERT [dbo].[PRODUCT_SIZES] ([ProductSizeId], [SizeId], [ProductId], [Price]) VALUES (760, 5, 8, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PRODUCT_SIZES] ([ProductSizeId], [SizeId], [ProductId], [Price]) VALUES (761, 2, 19, CAST(10000 AS Decimal(18, 0)))
INSERT [dbo].[PRODUCT_SIZES] ([ProductSizeId], [SizeId], [ProductId], [Price]) VALUES (762, 3, 19, CAST(15000 AS Decimal(18, 0)))
INSERT [dbo].[PRODUCT_SIZES] ([ProductSizeId], [SizeId], [ProductId], [Price]) VALUES (763, 2, 7, CAST(10000 AS Decimal(18, 0)))
INSERT [dbo].[PRODUCT_SIZES] ([ProductSizeId], [SizeId], [ProductId], [Price]) VALUES (764, 3, 7, CAST(20000 AS Decimal(18, 0)))
INSERT [dbo].[PRODUCT_SIZES] ([ProductSizeId], [SizeId], [ProductId], [Price]) VALUES (765, 4, 7, CAST(30000 AS Decimal(18, 0)))
INSERT [dbo].[PRODUCT_SIZES] ([ProductSizeId], [SizeId], [ProductId], [Price]) VALUES (766, 5, 7, CAST(40000 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[PRODUCT_SIZES] OFF
SET IDENTITY_INSERT [dbo].[PRODUCT_STATUS] ON 

INSERT [dbo].[PRODUCT_STATUS] ([ID], [Name], [Tag]) VALUES (1, N'Còn hàng', N'con-hang')
INSERT [dbo].[PRODUCT_STATUS] ([ID], [Name], [Tag]) VALUES (2, N'Hết hàng', N'het-hang')
INSERT [dbo].[PRODUCT_STATUS] ([ID], [Name], [Tag]) VALUES (3, N'Đang nhập hàng', N'dang-nhap-hang')
SET IDENTITY_INSERT [dbo].[PRODUCT_STATUS] OFF
SET IDENTITY_INSERT [dbo].[PRODUCT_TYPES] ON 

INSERT [dbo].[PRODUCT_TYPES] ([ID], [ID_Product], [ID_Type]) VALUES (31, 11, 3)
INSERT [dbo].[PRODUCT_TYPES] ([ID], [ID_Product], [ID_Type]) VALUES (32, 11, 4)
INSERT [dbo].[PRODUCT_TYPES] ([ID], [ID_Product], [ID_Type]) VALUES (33, 12, 2)
INSERT [dbo].[PRODUCT_TYPES] ([ID], [ID_Product], [ID_Type]) VALUES (34, 12, 3)
INSERT [dbo].[PRODUCT_TYPES] ([ID], [ID_Product], [ID_Type]) VALUES (210, 10, 1)
INSERT [dbo].[PRODUCT_TYPES] ([ID], [ID_Product], [ID_Type]) VALUES (211, 10, 4)
INSERT [dbo].[PRODUCT_TYPES] ([ID], [ID_Product], [ID_Type]) VALUES (212, 2, 3)
INSERT [dbo].[PRODUCT_TYPES] ([ID], [ID_Product], [ID_Type]) VALUES (246, 1, 1)
INSERT [dbo].[PRODUCT_TYPES] ([ID], [ID_Product], [ID_Type]) VALUES (248, 13, 2)
INSERT [dbo].[PRODUCT_TYPES] ([ID], [ID_Product], [ID_Type]) VALUES (355, 17, 2)
INSERT [dbo].[PRODUCT_TYPES] ([ID], [ID_Product], [ID_Type]) VALUES (356, 14, 1)
INSERT [dbo].[PRODUCT_TYPES] ([ID], [ID_Product], [ID_Type]) VALUES (357, 14, 2)
INSERT [dbo].[PRODUCT_TYPES] ([ID], [ID_Product], [ID_Type]) VALUES (358, 18, 1)
INSERT [dbo].[PRODUCT_TYPES] ([ID], [ID_Product], [ID_Type]) VALUES (359, 6, 1)
INSERT [dbo].[PRODUCT_TYPES] ([ID], [ID_Product], [ID_Type]) VALUES (370, 8, 1)
INSERT [dbo].[PRODUCT_TYPES] ([ID], [ID_Product], [ID_Type]) VALUES (371, 19, 1)
INSERT [dbo].[PRODUCT_TYPES] ([ID], [ID_Product], [ID_Type]) VALUES (372, 19, 2)
INSERT [dbo].[PRODUCT_TYPES] ([ID], [ID_Product], [ID_Type]) VALUES (411, 21, 1)
INSERT [dbo].[PRODUCT_TYPES] ([ID], [ID_Product], [ID_Type]) VALUES (412, 21, 2)
INSERT [dbo].[PRODUCT_TYPES] ([ID], [ID_Product], [ID_Type]) VALUES (415, 7, 1)
INSERT [dbo].[PRODUCT_TYPES] ([ID], [ID_Product], [ID_Type]) VALUES (416, 7, 2)
INSERT [dbo].[PRODUCT_TYPES] ([ID], [ID_Product], [ID_Type]) VALUES (417, 9, 1)
INSERT [dbo].[PRODUCT_TYPES] ([ID], [ID_Product], [ID_Type]) VALUES (418, 9, 2)
INSERT [dbo].[PRODUCT_TYPES] ([ID], [ID_Product], [ID_Type]) VALUES (419, 20, 1)
INSERT [dbo].[PRODUCT_TYPES] ([ID], [ID_Product], [ID_Type]) VALUES (420, 20, 2)
INSERT [dbo].[PRODUCT_TYPES] ([ID], [ID_Product], [ID_Type]) VALUES (421, 15, 1)
INSERT [dbo].[PRODUCT_TYPES] ([ID], [ID_Product], [ID_Type]) VALUES (422, 15, 2)
INSERT [dbo].[PRODUCT_TYPES] ([ID], [ID_Product], [ID_Type]) VALUES (1427, 4, 1)
INSERT [dbo].[PRODUCT_TYPES] ([ID], [ID_Product], [ID_Type]) VALUES (1428, 4, 2)
SET IDENTITY_INSERT [dbo].[PRODUCT_TYPES] OFF
SET IDENTITY_INSERT [dbo].[PRODUCTS] ON 

INSERT [dbo].[PRODUCTS] ([ID], [Code], [Name], [Tag], [Image], [Sapo], [Content], [Price], [PriceOld], [ID_GroupProduct], [DatePublish], [CountView], [CountBuy], [StatusID], [IsActive], [IsHot], [LinkY]) VALUES (1, N'SP001', N'Máy Tính Công Nghiệp - ARK-2120L-S8A1E', N'may-tinh-cong-nghiep-ark2120ls8a1e', N'/Upload/images/Advantech_ARK-3380_Industrial_Computer.png', N'<p>&Aacute;o thun H&agrave;n quốc loại c&aacute;c Kpop đang mặc</p>
', N'<p><span style="color:#FF8C00">►CẤU H&Igrave;NH CHUNG</span></p>

<p>- Intel&reg; AtomTM N2600 1.6 GHz/D2550 1.86 GHz Fanless Embedded Box PC, DDR3 memory supports up to 4 GB</p>

<p>VGA and HDMI dual independent display, supports DirectX 9</p>

<p>- Mini PCIe expansion with SIM holder for communication module, i.e. HSDPA, WLAN</p>

<p>- Supports up to 2 x GbE, 6 x USB 2.0 and 4 x COMs ports</p>

<p>- Supports external CFast socket and 1 x 2.5&quot; HDD drive bay</p>

<p>- Lockable DC input jack</p>

<p>- Supports iManager, SUSIAccess and Embedded Software APIs</p>

<p><span style="color:#FF8C00">►ĐẶC T&Iacute;NH KỸ THUẬT</span></p>

<p>- Operating Temperature -10 to 60&deg;C (-14 to 140&deg;F)</p>

<p>- Operating Humidity 5% to 95% Non-condensing 1</p>

<p>- Shock: 10G acceleration peak&nbsp;</p>

<p>- H&agrave;ng nhập khẩu 100% ch&iacute;nh h&atilde;ng, chuẩn c&ocirc;ng nghiệp, chống sốc, bụi, độ ẩm</p>

<p><span style="color:#FF8C00">►GIẤY CHỨNG NHẬN</span></p>

<p>&nbsp;- Giấy chứng nhận xuất xứ ch&iacute;nh h&atilde;ng (Certificate of Origin)</p>

<p>&nbsp;- Giấy chứng nhận chất lượng / Số lượng (CQ) (Certificate of Quality/Quantity)</p>

<p><a href="/Upload/images/Documents/ARK-2120L.pdf"><img alt="" class="border-image" src="http://baotinsoftware.com/Upload/images/Icons/PDF_downlaod-2.png" style="border:1px solid rgb(222, 222, 222); box-sizing:border-box; font-family:roboto condensed,sans-serif; font-size:15px; line-height:21.4285717010498px; max-width:100%; padding:5px; vertical-align:middle" /><span style="color:rgb(169, 169, 169); font-family:roboto condensed,sans-serif; font-size:15px">Download T&agrave;i Liệu Về Sản Phẩm</span></a></p>

<p>&nbsp;</p>
', CAST(180000 AS Decimal(18, 0)), CAST(150000 AS Decimal(18, 0)), 24, CAST(N'2016-09-05 07:04:10.350' AS DateTime), 145, 1, 1, 1, 1, N'')
INSERT [dbo].[PRODUCTS] ([ID], [Code], [Name], [Tag], [Image], [Sapo], [Content], [Price], [PriceOld], [ID_GroupProduct], [DatePublish], [CountView], [CountBuy], [StatusID], [IsActive], [IsHot], [LinkY]) VALUES (2, N'SP002', N'Đầu cân 60Kg DI28SS', N'dau-can-60kg-di28ss', N'/Upload/images/BANCANDI28SS.jpg', N'<p>Lorem ipsum dolor sit amet, consectetur adip, sed do eiusmod tempor incididunt ut aut reiciendise voluptat maiores alias consequaturs aut perferendis doloribus asperiores ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
', N'<p style="text-align:center"><img alt="" src="/Upload/images/Products/img_7-600x380.jpg" style="height:380px; width:600px" /></p>

<p>Lorem ipsum dolor sit amet, consectetur adip, sed do eiusmod tempor incididunt ut aut reiciendise voluptat maiores alias consequaturs aut perferendis doloribus asperiores ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>

<p>Nulla nunc dui, tristique in semper vel, congue sed ligula. Nam dolor ligula, faucibus id sodales in, auctor fringilla libero. Pellentesque pellentesque eget tempor tellus. Fusce lacinia tempor malesuada. Ut lacus sapien, placerat a ornare nec, elementum sit amet felis. Maecenas pretium lorem hendrerit eros sagittis fermentum.</p>

<p>Morbi augue velit, tempus mattis dignissim nec, porta sed risus. Donec eget magna eu lorem tristique pellentesque eget eu dui. Fusce lacinia tempor malesuada. Ut lacus sapien, placerat a ornare nec, elementum sit amet felis. Maecenas pretium hendrerit fermentum. Fusce lacinia tempor malesuada. Ut lacus sapien, placerat a ornare nec, elementum sit amet felis. Maecenas pretium lorem hendrerit eros sagittis fermentum.</p>

<p>Donec in ut odio libero, at vulputate urna. Nulla tristique mi a massa convallis cursus. Nulla eu mi magna. Etiam suscipit commodo gravida. Cras suscipit, quam vitae adipiscing faucibus, risus nibh laoreet odio, a porttitor metus eros ut enim. Morbi augue velit, tempus mattis dignissim nec, porta sed risus. Donec eget magna eu lorem tristique pellentesque eget eu duiport titor metus eros ut enim.</p>

<div class="box-body" style="line-height: 20.8px;">
<table class="table table-bordered">
	<tbody>
		<tr>
			<th style="width:10px">#</th>
			<th>Task</th>
			<th>Progress</th>
			<th style="width:40px">Label</th>
		</tr>
		<tr>
			<td>1.</td>
			<td>Update software</td>
			<td>
			<div class="progress xs">
			<div class="progress-bar progress-bar-danger" style="width: 30.7969px;">&nbsp;</div>
			</div>
			</td>
			<td>55%</td>
		</tr>
		<tr>
			<td>2.</td>
			<td>Clean database</td>
			<td>
			<div class="progress xs">
			<div class="progress-bar progress-bar-yellow" style="width: 39.1875px;">&nbsp;</div>
			</div>
			</td>
			<td>70%</td>
		</tr>
		<tr>
			<td>3.</td>
			<td>Cron job running</td>
			<td>
			<div class="progress xs progress-striped active">
			<div class="progress-bar progress-bar-primary" style="width: 16.7969px;">&nbsp;</div>
			</div>
			</td>
			<td>30%</td>
		</tr>
		<tr>
			<td>4.</td>
			<td>Fix and squish bugs</td>
			<td>
			<div class="progress xs progress-striped active">
			<div class="progress-bar progress-bar-success" style="width: 50.3906px;">&nbsp;</div>
			</div>
			</td>
			<td>90%</td>
		</tr>
	</tbody>
</table>
</div>

<p>Trong một m&ocirc;i trường thay đổi kh&ocirc;ng ngừng, c&ocirc;ng việc dồn dập, ch&uacute;ng ta cần học c&aacute;ch sắp xếp thứ tự c&ocirc;ng việc v&agrave; n&acirc;ng cao hiệu suất l&agrave;m việc nhiều nhất c&oacute; thể.</p>

<p>Nhưng cũng đừng qu&ecirc;n ch&uacute; &yacute; sức khỏe v&agrave; t&igrave;nh h&igrave;nh t&agrave;i ch&iacute;nh c&aacute; nh&acirc;n. Bỏ qua 2 yếu tố n&agrave;y c&oacute; thể khiến bạn gặp hậu quả kh&oacute; lường.</p>

<p><span style="color:#0000CD"><strong>Download t&agrave;i liệu:</strong></span> <a href="/Upload/images/Documents/huong-dan-su-dung.docx" target="_blank">t&agrave;i liệu hướng dẫn sử dụng 01</a></p>
', CAST(250000 AS Decimal(18, 0)), CAST(150000 AS Decimal(18, 0)), 15, CAST(N'2016-08-31 21:12:07.740' AS DateTime), 155, 1, 1, 0, 0, N'//www.youtube.com/embed/fb5xSzuEEsg')
INSERT [dbo].[PRODUCTS] ([ID], [Code], [Name], [Tag], [Image], [Sapo], [Content], [Price], [PriceOld], [ID_GroupProduct], [DatePublish], [CountView], [CountBuy], [StatusID], [IsActive], [IsHot], [LinkY]) VALUES (4, N'SP004', N'Quản lý lịch nhuộm & năng suất máy -Dyeing  & productivity V2.3.1', N'quan-ly-lich-nhuom-nang-suat-may-dyeing-productivity-v231', N'/Upload/images/Products/baotinsoftware-phan-mem-quan-ly-moc.jpg', N'Đối với ng&agrave;nh nhuộm vải, c&ocirc;ng đoạn nhuộm quyết định 70% chất lượng sản phẩm. Những bất cập đối với c&aacute;c chủ doanh nghiệp như: thời gian v&ocirc; m&agrave;u c&oacute; đ&uacute;ng theo qui tr&igrave;nh, nhiệt độ c&oacute; chạy đ&uacute;ng thời gian theo từng loại mặt h&agrave;ng hay kh&ocirc;ng, c&ocirc;ng nh&acirc;n c&oacute; thực hiện đ&uacute;ng theo y&ecirc;u cầu về qui tr&igrave;nh đưa ra hay kh&ocirc;ng v&agrave; v&ocirc; v&agrave;ng l&iacute; do dẫn đến h&agrave;ng h&oacute;a hư hỏng.&nbsp;', N'<p style="text-align:center"><img alt="" src="/Upload/images/Products/img_7-600x380.jpg" style="height:380px; width:600px" /></p>

<p>&nbsp;</p>

<p>Đối với ng&agrave;nh nhuộm vải, c&ocirc;ng đoạn nhuộm quyết định 70% chất lượng sản phẩm. Những bất cập đối với c&aacute;c chủ doanh nghiệp như: thời gian v&ocirc; m&agrave;u c&oacute; đ&uacute;ng theo qui tr&igrave;nh, nhiệt độ c&oacute; chạy đ&uacute;ng thời gian theo từng loại mặt h&agrave;ng hay kh&ocirc;ng, c&ocirc;ng nh&acirc;n c&oacute; thực hiện đ&uacute;ng theo y&ecirc;u cầu về qui tr&igrave;nh đưa ra hay kh&ocirc;ng v&agrave; v&ocirc; v&agrave;ng l&iacute; do dẫn đến h&agrave;ng h&oacute;a hư hỏng. &nbsp;Nhằm để hỗ trợ giải quyết một số vấn đề tr&ecirc;n c&ocirc;ng ty Bảo T&iacute;n đưa ra g&oacute;i giải ph&aacute;p phần mềm cho hệ thống qu&aacute;n l&yacute; sản xuất gi&uacute;p cho doanh nghiệp giảm thiểu sai s&oacute;t, kiểm so&aacute;t hệ thống tốt hơn. Sản phẩm đưa ra&nbsp; gồm c&aacute;c t&iacute;nh năng như sau:</p>

<p><span style="color:#008080">A.) Ph&acirc;n mềm</span></p>

<p><span style="color:#008080">►</span> Lập kế hoạch nhuộm chi tiết cho từng mẻ nhuộm của từng kh&aacute;ch h&agrave;ng. Lập kế hoạch bao gồm: thời gian dự t&iacute;nh ho&agrave;n tất mẻ, ca thực hiện, nh&acirc;n vi&ecirc;n đứng m&aacute;y, qui tr&igrave;nh nhuộm, m&atilde; c&ocirc;ng nghệ&hellip;</p>

<p><span style="color:#008080">►</span> Thực thi mẻ nhuộm th&ocirc;ng qua x&aacute;c nhận tr&ecirc;n hệ thống phần mềm.</p>

<p><span style="color:#008080">► </span>Ghi nhận nhật k&iacute; nhuộm của mẻ gồm: thời gian v&agrave;o mẻ, ra mẻ, nh&acirc;n vi&ecirc;n đứng m&aacute;y, qui tr&igrave;nh m&aacute;y, thời gian giao ca&hellip;</p>

<p><span style="color:#008080">►</span> Ghi nhận chi tiết th&ocirc;ng số m&aacute;y nhuộm như nhiệt độ m&aacute;y, tốc độ motor ch&iacute;nh, dosing bồn m&agrave;u, thời gian v&agrave;o m&agrave;u&hellip;</p>

<p><span style="color:#008080">►</span> B&aacute;o c&aacute;o chi tiết mẻ nhuộm.</p>

<p><span style="color:#008080">►</span> B&aacute;o c&aacute;o năng suất m&aacute;y nhuộm.</p>

<p>B&aacute;o c&aacute;o năng suất nh&acirc;n vi&ecirc;n đứng m&aacute;y.</p>

<p><span style="color:#B22222"><em>Lưu &yacute;: ở đ&acirc;y ch&uacute;ng t&ocirc;i chỉ liệt k&ecirc; những t&iacute;nh năng cơ bản của hệ thống quản l&yacute;, t&ugrave;y theo từng cơ quan c&oacute; y&ecirc;u cầu thiết lập ri&ecirc;ng ch&uacute;ng t&ocirc;i sẽ tư vấn chi tiết hơn.</em></span></p>

<p><span style="color:#008080">B.) Phần cứng</span></p>

<p><span style="color:#008080">►</span> Tự on hoặc off tủ điện ch&iacute;nh m&aacute;y nhuộm sau khi k&iacute;ch hoạt ph&eacute;p phiếu sản xuất.</p>

<p><span style="color:#008080">►</span> Hỗ trợ giao tiếp tủ điện ch&iacute;nh ( ghi nhận nhiệt độ, tốc độ bơm ch&iacute;nh, valve bồn m&agrave;u, thời gian v&agrave;o m&agrave;u&hellip;)</p>

<p><span style="color:#008080">►</span> Tự off hệ thống tủ điện ch&iacute;nh sau khi ho&agrave;n tất nhuộm 1 mẻ.</p>

<p><span style="color:#008080">►</span> Chuẩn giao tiếp RS232 hỗ trợ kết nối đến 70 thiết bị ngoại vi.</p>

<div class="box-body" style="line-height: 20.8px;">
<div class="progress xs progress-striped active">
<div class="progress-bar progress-bar-red" style="width: 5.3906px;">&nbsp;</div>
</div>

<table class="table table-bordered">
	<tbody>
		<tr>
			<th style="width:10px">#</th>
			<th>Task</th>
			<th>Progress</th>
			<th style="width:40px">Label</th>
		</tr>
		<tr>
			<td>1.</td>
			<td>H&agrave;ng nhuộm đ&uacute;ng thời gian y&ecirc;u cầu</td>
			<td>
			<div class="progress xs">
			<div class="progress-bar progress-bar-blue" style="width: 60.7969px;">&nbsp;</div>
			</div>
			</td>
			<td>60%</td>
		</tr>
		<tr>
			<td>2.</td>
			<td>H&agrave;ng vượt qu&aacute; thời gian y&ecirc;u cầu</td>
			<td>
			<div class="progress xs">
			<div class="progress-bar progress-bar-danger" style="width: 20.1875px;">&nbsp;</div>
			</div>
			</td>
			<td>20%</td>
		</tr>
		<tr>
			<td>3.</td>
			<td>H&agrave;ng nhuộm bị lỗi</td>
			<td>
			<div class="progress xs">
			<div class="progress-bar progress-bar-primary" style="width: 10.7969px;">&nbsp;</div>
			</div>
			</td>
			<td>10%</td>
		</tr>
		<tr>
			<td>4.</td>
			<td>H&agrave;ng nhuộm lại</td>
			<td>
			<div class="progress xs">
			<div class="progress-bar progress-bar-red" style="width: 5.3906px;">&nbsp;</div>
			</div>
			</td>
			<td>5%</td>
		</tr>
		<tr>
			<td>5</td>
			<td>L&yacute; do kh&aacute;c</td>
			<td>
			<div class="progress xs">
			<div class="progress-bar progress-bar-yellow" style="width: 5.3906px;">&nbsp;</div>
			</div>
			</td>
			<td>5%</td>
		</tr>
	</tbody>
</table>
</div>

<p>&nbsp;</p>

<p><em>Rất mong được phục vụ qu&yacute; kh&aacute;ch h&agrave;ng ! Nhấn &quot;<span style="color:#000080"><strong>Th&iacute;ch trang hoặc chia sẽ</strong></span>&quot; để nhận được th&ocirc;ng tin b&agrave;i viết mới &amp; sản phẩm từ cty ch&uacute;ng t&ocirc;i.</em></p>

<p>&nbsp;</p>

<p><iframe frameborder="0" height="292" scrolling="no" src="https://www.facebook.com/plugins/page.php?href=https%3A%2F%2Fwww.facebook.com%2FBaoTinSoft%2F&amp;tabs=timeline&amp;width=340&amp;height=292&amp;small_header=false&amp;adapt_container_width=true&amp;hide_cover=false&amp;show_facepile=true&amp;appId" style="border:none;overflow:hidden" width="340"></iframe></p>

<p><a href="http://baotinsoftware.com/lien-he.html"><em>►Vui l&ograve;ng li&ecirc;n hệ với ch&uacute;ng t&ocirc;i&nbsp;</em></a></p>

<p><em>Tham khảo web:&nbsp;</em>&nbsp;<em><a href="http://baotinsoftware.com/" target="_blank">Http://baotinsoftware.com</a></em>&nbsp;</p>

<p><em>Hoặc</em>&nbsp;<em><a href="http://baotinsoftware.com/" target="_blank">Http://baotinsoftware.com.vn</a></em></p>

<p><em>Email:</em>&nbsp;&nbsp;<em><a href="http://baotinsoftware.com/" target="_blank">baotinsoftware@gmail.com</a></em></p>

<p><em>Phone / Zalo :&nbsp;</em>&nbsp;<em><strong>0988 898996 Lộc</strong></em></p>
', CAST(220000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 2, CAST(N'2017-11-19 14:32:58.067' AS DateTime), 312, 0, 1, 1, 1, N'https://www.youtube.com/embed/4vNZq5U1PmY')
INSERT [dbo].[PRODUCTS] ([ID], [Code], [Name], [Tag], [Image], [Sapo], [Content], [Price], [PriceOld], [ID_GroupProduct], [DatePublish], [CountView], [CountBuy], [StatusID], [IsActive], [IsHot], [LinkY]) VALUES (5, N'SP005', N'Armor Wax/Resin', N'armor-waxresin', N'/Upload/images/ARMOR WAX.jpg', N'', N'<p><span style="color:#FF8C00">►C&Ocirc;NG DỤNG</span></p>

<p>D&ugrave;ng cho c&aacute;c loại giấy th&ocirc;ng thường v&agrave; một số loại giấy đặc biệt, in tốt m&atilde; vạch cả 2 phương nằm ngang hay thẳng đứng, với độ b&aacute;m cao, chống được trầy xước kh&aacute; tốt, chống được 1 số loại h&oacute;a chất. ứng dụng trong c&aacute;c ng&agrave;nh vận chuyển, kiểm k&ecirc;, dược phẩm, may mặc, b&aacute;n lẻ, thực phẩm, đ&ocirc;ng lạnh, c&aacute;c ứng dụng ngo&agrave;i trời ...</p>

<p><span style="color:#FF8C00">►C&Aacute;C D&Ograve;NG M&Aacute;Y SỬ DỤNG</span></p>

<p>- Datamax</p>

<p>- Bixolon</p>

<p>- C&aacute;c d&ograve;ng m&aacute;y in nhiệt..</p>

<p>----------------------oo00oo----------------------</p>

<p><em><strong>Rất mong được phục vụ qu&yacute; kh&aacute;ch h&agrave;ng !</strong></em></p>

<p>Tham khảo web&nbsp;<a href="http://baotinsoftware.com/" target="_blank">Http://baotinsoftware.com</a>&nbsp;hoặc&nbsp;<a href="http://baotinsoftware.com/" target="_blank">Http://baotinsoftware.com.vn</a></p>

<p>Email:&nbsp;&nbsp;<a href="http://baotinsoftware.com/" target="_blank">baotinsoftware@gmail.com</a></p>

<p><em>Phone - Zalo:&nbsp;</em><em>&nbsp;0988 898996 Lộc</em></p>
', CAST(20000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 22, CAST(N'2016-08-31 21:10:14.033' AS DateTime), 198, 0, 1, 1, 0, N'')
INSERT [dbo].[PRODUCTS] ([ID], [Code], [Name], [Tag], [Image], [Sapo], [Content], [Price], [PriceOld], [ID_GroupProduct], [DatePublish], [CountView], [CountBuy], [StatusID], [IsActive], [IsHot], [LinkY]) VALUES (6, N'X008', N'Phần mềm quản lý bán vải 1.3', N'phan-mem-quan-ly-ban-vai-13', N'/Upload/images/PM- QUAN LY DET.jpg', N'', N'<p>&nbsp;- Phần mềm b&aacute;n h&agrave;ng gi&uacute;p cho người quản l&yacute; nắm bắt lượng h&agrave;ng b&aacute;n ra v&agrave; theo d&otilde;i c&ocirc;ng nợ kh&aacute;ch h&agrave;ng. Hệ thống phần mềm hỗ trợ kết n&oacute;i thiết bị qu&eacute;t m&atilde; vạch v&agrave; c&acirc;n điện tử gi&uacute;p cho người d&ugrave;ng thao t&aacute;c đơn giản v&agrave; ch&iacute;nh x&aacute;c. Ngo&agrave;i ra, &nbsp;phần mềm c&ograve;n c&oacute; c&aacute;c ưu điểm sau:</p>

<p><span style="color:rgb(255, 140, 0)">1.)SỬ DỤNG DỄ D&Agrave;NG</span></p>

<p>Ưu điểm nổi trội của phần mềm b&aacute;n mộc của Bảo T&iacute;n l&agrave; sự th&acirc;n thiện với cấu tr&uacute;c giao diện logic, th&ocirc;ng minh. Nh&acirc;n vi&ecirc;n b&aacute;n h&agrave;ng trực tiếp trong cửa h&agrave;ng cần thực hiện tối đa từ 2 đến 3 thao t&aacute;c tr&ecirc;n phần mềm để ho&agrave;n th&agrave;nh một nghiệp vụ cụ thể.&nbsp;Sản phẩm của Bảo T&iacute;n được thiết kế với sự nghi&ecirc;n cứu kỹ lưỡng c&aacute;c nghiệp vụ ph&aacute;t sinh thường gặp trong cửa h&agrave;ng từ đơn giản như: Nhập h&agrave;ng, điều chỉnh nhập kho, xuất b&aacute;n v&hellip;v&hellip; tới phức tạp như nhập h&agrave;ng trả về, điều chỉnh c&ocirc;ng nợ&hellip;Trung b&igrave;nh, một nh&acirc;n vi&ecirc;n thao t&aacute;c tr&ecirc;n phần mềm để xử l&yacute; một nghiệp vụ bất kỳ thường chỉ mất từ 5s &ndash; 7s, rất tiết kiệm thời gian để mau ch&oacute;ng phục vụ những kh&aacute;ch h&agrave;ng kh&aacute;c.</p>

<p>Đội ngũ b&aacute;n h&agrave;ng chỉ cần một buổi huấn luyện c&ugrave;ng c&aacute;c chuy&ecirc;n vi&ecirc;n của Bảo T&iacute;n để trở n&ecirc;n th&agrave;nh thạo. Nếu trong b&aacute;n h&agrave;ng thực tế gặp kh&oacute; khăn g&igrave;, hotline của Bảo T&iacute;n lu&ocirc;n sẵn s&agrave;ng để hỗ trợ v&agrave; hướng dẫn.</p>

<p><span style="color:rgb(255, 140, 0)">2.)T&Iacute;NH NĂNG LINH HOẠT</span></p>

<p>Phần mềm b&aacute;n mộc Bảo T&iacute;n ph&ugrave; hợp cho rất nhiều m&ocirc; h&igrave;nh kinh doanh kh&aacute;c nhau, từ quy nhỏ tới quy m&ocirc; lớn. T&iacute;nh linh hoạt của hệ thống giải ph&aacute;p c&ograve;n thể hiện ở chỗ: Phần mềm đ&aacute;p ứng rất tốt nhu cầu của kh&aacute;ch h&agrave;ng khi họ c&oacute; nhu cầu chuyển đổi lĩnh vực kinh doanh hay thay đổi m&ocirc; h&igrave;nh hoạt động.</p>

<p>Sự thay đổi tr&ecirc;n c&oacute; nhiều h&igrave;nh thức như từ cửa h&agrave;ng b&aacute;n mộc li&ecirc;n kết với nh&agrave; m&aacute;y Dệt, Nhuộm. Bảo T&iacute;n đ&aacute;p ứng đầy đủ c&aacute;c nhu cầu tr&ecirc;n với cấu tr&uacute;c hệ thống t&ugrave;y biến th&ocirc;ng minh, đảm bảo luồng th&ocirc;ng tin di chuyển ch&iacute;nh x&aacute;c tới c&aacute;c bộ phận, phục vụ tốt nhất y&ecirc;u cầu quản trị.</p>

<p><span style="color:rgb(255, 140, 0)">3.)QUẢN L&Yacute; TO&Agrave;N CHUỖI</span></p>

<p>M&ocirc; h&igrave;nh kinh doanh theo chuỗi đang ng&agrave;y c&agrave;ng phổ biến v&agrave; đ&ograve;i hỏi những giải ph&aacute;p quản trị tối ưu, hiệu quả hơn. Bảo T&iacute;n l&agrave; một trong số &iacute;t đơn vị đ&aacute;p ứng ho&agrave;n hảo nhu cầu đ&oacute;. Phần mềm b&aacute;n h&agrave;ng Bảo T&iacute;n phi&ecirc;n bản Client/Server gi&uacute;p tổng hợp dữ liệu doanh thu, chi ph&iacute;, tồn kho, c&ocirc;ng nợ tại ri&ecirc;ng lẻ từng điểm b&aacute;n rồi thống k&ecirc; dưới dạng c&aacute;c b&aacute;o c&aacute;o cụ thể tr&ecirc;n cơ sở kinh doanh ch&iacute;nh. B&ecirc;n cạnh đ&oacute;, c&aacute;c thao t&aacute;c như chỉnh sửa gi&aacute; b&aacute;n, điều chỉnh mức chiết khấu, điều chỉnh c&ocirc;ng nợ v&hellip;v&hellip; c&oacute; thể được c&aacute;c chủ cửa h&agrave;ng thực hiện tại bất cứ đ&acirc;u. Sau khi thiết lập c&aacute;c ch&iacute;nh s&aacute;ch, phần mềm b&aacute;n h&agrave;ng Bảo T&iacute;n gi&uacute;p c&aacute;c th&ocirc;ng tin tr&ecirc;n tự động truyền tới c&aacute;c điểm kinh doanh lẻ v&agrave; tự động được triển khai v&agrave;o đ&uacute;ng thời gian định trước.</p>

<p>Với Bảo T&iacute;n, c&aacute;c nh&agrave; quản l&yacute; lu&ocirc;n c&oacute; được c&aacute;i nh&igrave;n bao qu&aacute;t to&agrave;n chuỗi để đ&aacute;nh gi&aacute; hiệu quả hoạt động, đưa ra những quyết định đ&uacute;ng đắn gi&uacute;p thương hiệu ph&aacute;t triển.</p>

<p><span style="color:rgb(255, 140, 0)">4.)KIỂM SO&Aacute;T TỪ XA</span></p>

<p>Khi ph&aacute;t triển l&ecirc;n m&ocirc; h&igrave;nh chuỗi, người chủ thường đối diện với rất nhiều kh&oacute; khăn khi kh&ocirc;ng thể s&aacute;t sao với từng cơ sở kinh doanh. Việc c&oacute; c&aacute;i nh&igrave;n tổng thể về doanh thu/chi ph&iacute; to&agrave;n chuỗi l&agrave; rất quan trọng để đưa ra những quyết định hợp l&yacute;. Hiểu được nỗi lo n&agrave;y của nh&agrave; quản trị, Bảo T&iacute;n đ&atilde; ph&aacute;t triển ứng dụng quản l&yacute; từ xa người củ quản l&yacute; hiệu quả nhất.</p>

<p>Remote Desktop được thiết kế khoa học th&ocirc;ng minh, rất dễ c&agrave;i đặt v&agrave; sử dụng. Chỉ cần kết nối internet, người chủ nh&agrave; h&agrave;ng c&oacute; thể biết được mọi thứ đang diễn ra tại cửa h&agrave;ng như sl b&aacute;n, gi&aacute; b&aacute;n hay doanh thu t&iacute;nh đến thời điểm hiện tại. Hệ thống b&aacute;o c&aacute;o trực quan, cụ thể v&agrave; cập nhật li&ecirc;n tục, gi&uacute;p nh&agrave; quản trị so s&aacute;nh c&aacute;c chỉ số kinh doanh theo từng th&aacute;ng/qu&yacute;/năm với nhau v&agrave; so s&aacute;nh giữa c&aacute;c điểm b&aacute;n trong c&ugrave;ng một chuỗi.&nbsp;</p>

<p><img alt="" src="/Upload/images/Icons/PDF_downlaod-2.png" style="height:24px; width:24px" /><span style="color:rgb(169, 169, 169)"><span style="font-size:15.3333px">Download T&agrave;i Liệu Về Sản Phẩm</span></span></p>

<hr />
<p><em><span style="color:rgb(69, 129, 142); font-family:arial,sans-serif; font-size:9pt">Rất mong được phục vụ qu&yacute; kh&aacute;ch h&agrave;ng !</span></em></p>

<p><iframe frameborder="0" height="292" scrolling="no" src="https://www.facebook.com/plugins/page.php?href=https%3A%2F%2Fwww.facebook.com%2FBaoTinSoft%2F&amp;tabs=timeline&amp;width=340&amp;height=292&amp;small_header=false&amp;adapt_container_width=true&amp;hide_cover=false&amp;show_facepile=true&amp;appId" style="border:none;overflow:hidden" width="340"></iframe></p>

<p><span style="font-family:arial,sans-serif; font-size:9pt"><a href="http://baotinsoftware.com/lien-he.html" style="box-sizing: border-box; transition: 300ms;"><em><span style="color:rgb(69, 129, 142)">►Vui l&ograve;ng li&ecirc;n hệ với ch&uacute;ng t&ocirc;i&nbsp;</span></em></a></span></p>

<p><em><span style="color:rgb(69, 129, 142); font-family:arial,sans-serif; font-size:9pt">Tham khảo web:&nbsp;</span></em><span style="color:rgb(0, 153, 0); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span><em><span style="color:rgb(34, 34, 34); font-family:arial,sans-serif; font-size:9pt"><a href="http://baotinsoftware.com/" style="box-sizing: border-box; transition: 300ms;" target="_blank"><span style="color:rgb(246, 178, 107)">Http://baotinsoftware.com</span></a></span></em><span style="color:rgb(246, 178, 107); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span></p>

<p><em><span style="color:rgb(69, 129, 142); font-family:arial,sans-serif; font-size:9pt">Hoặc</span></em><span style="color:rgb(246, 178, 107); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span><em><span style="color:rgb(34, 34, 34); font-family:arial,sans-serif; font-size:9pt"><a href="http://baotinsoftware.com/" style="box-sizing: border-box; transition: 300ms;" target="_blank"><span style="color:rgb(246, 178, 107)">Http://baotinsoftware.com.vn</span></a></span></em></p>

<p><em><span style="color:rgb(69, 129, 142); font-family:arial,sans-serif; font-size:9pt">Email:</span></em><span style="color:rgb(0, 153, 0); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span><span style="color:rgb(204, 0, 0); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span><em><span style="color:rgb(61, 133, 198); font-family:arial,sans-serif; font-size:9pt"><a href="http://baotinsoftware.com/" style="box-sizing: border-box; transition: 300ms;" target="_blank"><span style="color:rgb(51, 122, 183)">baotinsoftware@gmail.com</span></a></span></em></p>

<p><em><span style="color:rgb(11, 83, 148); font-family:arial,sans-serif; font-size:9pt">Phone / Zalo :&nbsp;</span></em><em><span style="font-family:arial,sans-serif; font-size:10pt">&nbsp;</span></em><strong><em><span style="color:rgb(11, 83, 148); font-family:arial,sans-serif; font-size:9pt">0988 898996 Lộc</span></em></strong></p>
', CAST(15000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 25, CAST(N'2017-11-18 15:08:32.987' AS DateTime), 177, 0, 1, 1, 0, N'')
INSERT [dbo].[PRODUCTS] ([ID], [Code], [Name], [Tag], [Image], [Sapo], [Content], [Price], [PriceOld], [ID_GroupProduct], [DatePublish], [CountView], [CountBuy], [StatusID], [IsActive], [IsHot], [LinkY]) VALUES (7, N'SX700D', N'Quản lý kế hoạch & sản lượng máy định hình vải  - Manager Complete  V2.3.1', N'quan-ly-ke-hoach-san-luong-may-dinh-hinh-vai-manager-complete-v231', N'/Upload/images/ManagerTemp3.png', N'&nbsp; Phần mềm quản l&yacute; kế hoạch căng v&agrave; sản lượng m&aacute;y định h&igrave;nh gi&uacute;p cho người quản l&yacute; theo d&otilde;i kế hoạch căng h&agrave;ng cho từng kh&aacute;ch h&agrave;ng theo từng mốc thời gian kh&aacute;c nhau. Trong đ&oacute;, hệ thống c&ograve;n đ&aacute;nh gi&aacute; được nh&acirc;n vi&ecirc;n căng c&oacute; thực hiện đ&uacute;ng kế hoạch y&ecirc;u cầu, theo d&otilde;i lượng h&agrave;ng th&agrave;nh phẩm ở t&igrave;nh trạng hư hỏng hoặc đ&uacute;ng theo y&ecirc;u cầu đưa ra&hellip;.', N'<p style="text-align:center"><img alt="" src="/Upload/images/Products/img_7-600x380.jpg" style="height:380px; width:600px" /></p>

<p>Phần mềm quản l&yacute; kế hoạch căng v&agrave; sản lượng m&aacute;y định h&igrave;nh gi&uacute;p cho người quản l&yacute; theo d&otilde;i kế hoạch căng h&agrave;ng cho từng kh&aacute;ch h&agrave;ng theo từng mốc thời gian kh&aacute;c nhau. Trong đ&oacute;, hệ thống c&ograve;n đ&aacute;nh gi&aacute; được nh&acirc;n vi&ecirc;n căng c&oacute; thực hiện đ&uacute;ng kế hoạch y&ecirc;u cầu, theo d&otilde;i lượng h&agrave;ng th&agrave;nh phẩm ở t&igrave;nh trạng hư hỏng hoặc đ&uacute;ng theo y&ecirc;u cầu đưa ra&hellip;.</p>

<p>C&aacute;c t&iacute;nh năng ch&iacute;nh của phần mềm bao gồm:</p>

<p>- Quản l&yacute; kế hoạch căng h&agrave;ng ( người quản l&yacute; sắp xếp mẻ căng theo đơn đặt h&agrave;ng của kh&aacute;ch h&agrave;ng) tr&ecirc;n hệ thống phần mềm.</p>

<p>- &Aacute;p đặt nh&acirc;n vi&ecirc;n thực hiện căng h&agrave;ng hoặc trưởng ca.</p>

<p>- Thiết lập thời gian dự t&iacute;nh ho&agrave;n tất của từng mẻ căng.</p>

<p>- Theo d&otilde;i từng mẻ căng theo ng&agrave;y, tuần, th&aacute;ng.</p>

<p>- B&aacute;o c&aacute;o năng suất căng từng m&aacute;y căng.</p>

<p>- B&aacute;o c&aacute;o năng suất l&agrave;m việc của nh&acirc;n vi&ecirc;n căng.</p>

<p>- B&aacute;o c&aacute;o lượng h&agrave;ng căng ( đạt, hư, sửa chữa&hellip;)</p>

<div class="box-body">
<table class="table table-bordered">
	<tbody>
		<tr>
			<th style="width:10px">#</th>
			<th>Task</th>
			<th>Progress</th>
			<th style="width:40px">%</th>
		</tr>
		<tr>
			<td>1.</td>
			<td>H&agrave;ng căng bị hư</td>
			<td>
			<div class="progress xs">
			<div class="progress-bar progress-bar-danger" style="width: 10%">&nbsp;</div>
			</div>
			</td>
			<td>10%</td>
		</tr>
		<tr>
			<td>2.</td>
			<td>H&agrave;ng lỗi</td>
			<td>
			<div class="progress xs">
			<div class="progress-bar progress-bar-yellow" style="width: 15%">&nbsp;</div>
			</div>
			</td>
			<td>15%</td>
		</tr>
		<tr>
			<td>3.</td>
			<td>H&agrave;ng căng lại</td>
			<td>
			<div class="progress xs progress-striped active">
			<div class="progress-bar progress-bar-primary" style="width: 5%">&nbsp;</div>
			</div>
			</td>
			<td>5%</td>
		</tr>
		<tr>
			<td>4.</td>
			<td>H&agrave;ng đạt y&ecirc;u cầu</td>
			<td>
			<div class="progress xs progress-striped active">
			<div class="progress-bar progress-bar-success" style="width: 90%">&nbsp;</div>
			</div>
			</td>
			<td>70%</td>
		</tr>
	</tbody>
</table>
</div>
<!-- /.box-body -->

<p style="margin-left:0.25in"><em><strong>Sản phẩm c&ocirc;ng ty lu&ocirc;n cập nhật những t&iacute;nh năng mới cho kh&aacute;ch h&agrave;ng. Vui l&ograve;ng li&ecirc;n hệ với ch&uacute;ng tối để được tư vấn sản phẩm chi tiết hơn.</strong></em></p>

<p style="margin-left:0.25in"><span style="color:#A52A2A"><em>Lưu &yacute;: nếu kh&aacute;ch h&agrave;ng c&oacute; nhu cầu cập nhật phi&ecirc;n bản full sau khi sử dụng, phi&ecirc;n b&agrave;n n&agrave;y vẫn hỗ trợ n&acirc;ng cấp t&iacute;nh năng kh&ocirc;ng bắt buộc phải thay đổi hoặc loại bỏ phi&ecirc;n bản đang sử dụng.</em></span></p>

<p><em>Rất mong được phục vụ qu&yacute; kh&aacute;ch h&agrave;ng !</em></p>

<p><iframe frameborder="0" height="292" scrolling="no" src="https://www.facebook.com/plugins/page.php?href=https%3A%2F%2Fwww.facebook.com%2FBaoTinSoft%2F&amp;tabs=timeline&amp;width=340&amp;height=292&amp;small_header=false&amp;adapt_container_width=true&amp;hide_cover=false&amp;show_facepile=true&amp;appId" style="border:none;overflow:hidden" width="340"></iframe></p>

<p><a href="http://baotinsoftware.com/lien-he.html"><em>►Vui l&ograve;ng li&ecirc;n hệ với ch&uacute;ng t&ocirc;i&nbsp;</em></a></p>

<p><em>Tham khảo web:&nbsp;</em>&nbsp;<em><a href="http://baotinsoftware.com/" target="_blank">Http://baotinsoftware.com</a></em>&nbsp;</p>

<p><em>Hoặc</em>&nbsp;<em><a href="http://baotinsoftware.com/" target="_blank">Http://baotinsoftware.com.vn</a></em></p>

<p><em>Email:</em>&nbsp;&nbsp;<em><a href="http://baotinsoftware.com/" target="_blank">baotinsoftware@gmail.com</a></em></p>

<p><em>Phone / Zalo :&nbsp;</em>&nbsp;<em><strong>0988 898996 Lộc</strong></em></p>
', CAST(5000000 AS Decimal(18, 0)), CAST(4500000 AS Decimal(18, 0)), 2, CAST(N'2017-11-18 15:22:01.320' AS DateTime), 292, 0, 1, 1, 1, N'')
INSERT [dbo].[PRODUCTS] ([ID], [Code], [Name], [Tag], [Image], [Sapo], [Content], [Price], [PriceOld], [ID_GroupProduct], [DatePublish], [CountView], [CountBuy], [StatusID], [IsActive], [IsHot], [LinkY]) VALUES (8, N'025', N'Hệ thống cân hóa chất - Chemical Station V1.2', N'he-thong-can-hoa-chat-chemical-station-v12', N'/Upload/images/CWSTATION-4.jpg', N'<p>Chuột quang m&aacute;y t&iacute;nh SLN si&ecirc;u tốc cực nhạy d&agrave;nh cho Game thủ</p>
', N'<p>&nbsp;</p>

<p><span style="color:#FF8C00">►M&Ocirc; H&Igrave;NH PH&Ograve;NG C&Acirc;N</span></p>

<p><span style="color:#FF8C00"><img alt="" src="/Upload/images/4.jpg" style="height:450px; width:600px" /></span></p>

<p><span style="color:#FF8C00"><span style="font-family:arial,sans-serif; font-size:10pt">►Đ&Ocirc;I N&Eacute;T VỀ HỆ THỐNG C&Acirc;N CHẤT H&Oacute;A CHẤT</span></span></p>

<p><span style="color:rgb(124, 124, 124); font-family:arial,sans-serif; font-size:10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Hệ thống quản l&yacute; c&acirc;n h&oacute;a chất cho ph&eacute;p nhập c&aacute;c c&ocirc;ng thức h&oacute;a chất v&agrave; trọng lượng vải v&agrave;o m&aacute;y t&iacute;nh để tự động t&iacute;nh to&aacute;n c&aacute;c c&ocirc;ng thức nhuộm. Sau đ&oacute;, hệ thống sẽ hướng dẫn vị tr&iacute; c&acirc;n từng chất cho nh&acirc;n vi&ecirc;n ph&ograve;ng c&acirc;n, chỉ cần thực hiện c&acirc;n đ&uacute;ng số lượng y&ecirc;u cầu theo dung sai cho ph&eacute;p. Trọng lượng c&acirc;n của c&aacute;c h&oacute;a chất n&agrave;y c&oacute; thể in, lưu lại v&agrave; c&oacute; thể ghi lại th&ocirc;ng tin phản hồi cho quản l&yacute; h&agrave;ng tồn kho.</span></p>

<p><span style="color:rgb(124, 124, 124); font-family:arial,sans-serif; font-size:10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Hệ thống n&agrave;y c&oacute; thể cho ph&eacute;p c&aacute;c nh&agrave; m&aacute;y nhuộm để tập trung quản l&yacute; h&oacute;a chất v&agrave; tăng năng suất c&ocirc;ng việc.</span></p>

<p><span style="color:rgb(124, 124, 124); font-family:arial,sans-serif; font-size:10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Hệ thống n&agrave;y cũng l&agrave;m giảm tỷ lệ lỗi của con người v&agrave; g&acirc;y l&atilde;ng ph&iacute; về h&oacute;a chất.</span></p>

<p><span style="color:#FF8C00"><span style="font-family:arial,sans-serif; font-size:10pt">►C&Aacute;C T&Iacute;NH NĂNG CH&Iacute;NH</span></span></p>

<p><span style="color:rgb(124, 124, 124); font-family:arial,sans-serif; font-size:10pt">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;- Sử dụng đ&egrave;n b&aacute;o hiệu vị tr&iacute; h&oacute;a chất cần c&acirc;n.</span></p>

<p><span style="color:rgb(124, 124, 124); font-family:arial,sans-serif; font-size:10pt">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; - Sử dụng barcode để kiểm tra x&aacute;c nhận h&oacute;a chất cần c&acirc;n.</span></p>

<p><span style="color:rgb(124, 124, 124); font-family:arial,sans-serif; font-size:10pt">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; - Quản l&yacute; nhập kho h&oacute;a chất từ c&aacute;c nh&agrave; cung cấp bằng hệ thống c&acirc;n v&agrave; được lưu trữ bằng hệ thống m&atilde; vạch.</span></p>

<p><span style="color:rgb(124, 124, 124); font-family:arial,sans-serif; font-size:10pt">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; - Sử dụng c&acirc;n điện tử sai số thấp để n&acirc;ng cao độ ch&iacute;nh x&aacute;c y&ecirc;u cầu của từng chất.</span></p>

<p><span style="color:rgb(124, 124, 124); font-family:arial,sans-serif; font-size:10pt">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; - Hệ thống th&ocirc;ng b&aacute;o đầy đủ tr&ecirc;n nền tảng phần mềm v&agrave; tự động t&iacute;nh to&aacute;n c&ocirc;ng thức theo trọng lượng vải .</span></p>

<p><span style="color:rgb(124, 124, 124); font-family:arial,sans-serif; font-size:10pt">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; - Đ&egrave;n b&aacute;o sử dụng led s&aacute;ng v&agrave; an to&agrave;n cho người sử dụng.</span></p>

<p><span style="color:rgb(124, 124, 124); font-family:arial,sans-serif; font-size:10pt">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; - Xe c&acirc;n di chuyển dễ d&agrave;ng gi&uacute;p thao t&aacute;c người c&acirc;n thuận lợi nhất.</span></p>

<p><span style="color:rgb(124, 124, 124); font-family:arial,sans-serif; font-size:10pt">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; - Xe c&acirc;n c&oacute; thể chứa tối đa 3 th&ugrave;ng c&acirc;n , tạo điều kiện thực hiện c&acirc;n nhiều phiếu c&ugrave;ng l&uacute;c.</span></p>

<p><span style="color:rgb(124, 124, 124); font-family:arial,sans-serif; font-size:10pt">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; - Tủ điện c&oacute; thể mở rộng th&ecirc;m từ 30 đến 50 vị tr&iacute; tủ đ&egrave;n b&aacute;o.</span></p>

<p><span style="color:#FF8C00"><span style="font-family:arial,sans-serif; font-size:10pt">►PHẦN MỀM</span></span></p>

<p><span style="color:rgb(124, 124, 124); font-family:arial,sans-serif; font-size:10pt">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;- Giao diện người d&ugrave;ng th&acirc;n thiện về đồ họa hỗ trợ hoạt động dễ d&agrave;ng, sử dụng m&agrave;n h&igrave;nh th&ocirc;ng b&aacute;o hỗ gi&uacute;p người d&ugrave;ng thao t&aacute;c đơn giản.</span></p>

<p><span style="color:rgb(124, 124, 124); font-family:arial,sans-serif; font-size:10pt">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;- Quản l&yacute; nhập xuất tồn h&oacute;a chất nhập kho.</span></p>

<p><span style="color:rgb(124, 124, 124); font-family:arial,sans-serif; font-size:10pt">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;- Quản l&yacute; c&ocirc;ng thức nhuộm theo từng kh&aacute;ch h&agrave;ng.</span></p>

<p><span style="color:rgb(124, 124, 124); font-family:arial,sans-serif; font-size:10pt">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;- C&oacute; thể t&ugrave;y chọn t&iacute;ch hợp với hệ thống quản l&yacute; c&ocirc;ng việc đang hiện h&agrave;nh tại nh&agrave; m&aacute;y.</span></p>

<p><span style="color:rgb(124, 124, 124); font-family:arial,sans-serif; font-size:10pt">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;- Phần mềm được t&iacute;ch hợp với hệ thống đầu đọc m&atilde; vạch.</span></p>

<p><span style="color:rgb(124, 124, 124); font-family:arial,sans-serif; font-size:10pt">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;- Phần mềm c&oacute; thể hỗ trợ tối đa 120 vị tr&iacute; đ&egrave;n b&aacute;o.</span></p>

<p><span style="color:rgb(124, 124, 124); font-family:arial,sans-serif; font-size:10pt">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;- Lịch sử c&acirc;n được ghi lại gi&uacute;p cho người quản l&yacute; nắm bắt th&ocirc;ng tin c&acirc;n chi tiết.</span></p>

<p><span style="color:rgb(124, 124, 124); font-family:arial,sans-serif; font-size:10pt">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;- Hệ thống ghi nhận, thống k&ecirc; lượng h&oacute;a chất sử dụng.</span></p>

<p><span style="color:#FF8C00">►TH&Ocirc;NG TIN SẢN PHẨM</span></p>

<table border="1" cellpadding="0" cellspacing="0">
	<tbody>
		<tr>
			<td style="width:37px">
			<p style="text-align:center"><strong>Stt</strong></p>
			</td>
			<td style="width:150px">
			<p style="text-align:center"><strong>T&ecirc;n thiết bị</strong></p>
			</td>
			<td style="width:30px">
			<p style="text-align:center"><strong>SL</strong></p>
			</td>
			<td style="width:264px">
			<p style="text-align:center"><strong>Cấu h&igrave;nh</strong></p>
			</td>
		</tr>
		<tr>
			<td style="width:37px">
			<p style="text-align:center">01</p>
			</td>
			<td style="width:150px">
			<p>Tủ điện ch&iacute;nh</p>
			</td>
			<td style="width:30px">
			<p style="text-align:center">01</p>
			</td>
			<td style="width:264px">
			<p>-K&iacute;ch thướt 500 x 300 x 200mm</p>

			<p>-Power Voltage : AC 220 x 240V</p>
			</td>
		</tr>
		<tr>
			<td style="width:37px">
			<p style="text-align:center">02</p>
			</td>
			<td style="width:150px">
			<p>Xe c&acirc;n thuốc</p>
			</td>
			<td style="width:30px">
			<p style="text-align:center">01</p>
			</td>
			<td style="width:264px">
			<p>-K&iacute;ch thướt 1500 x 1250 x 780mm</p>

			<p>-Trọng lượng 30.5Kg</p>
			</td>
		</tr>
		<tr>
			<td style="width:37px">
			<p style="text-align:center">03</p>
			</td>
			<td style="width:150px">
			<p>C&acirc;n nhỏ 3Kg100gram</p>
			</td>
			<td style="width:30px">
			<p style="text-align:center">01</p>
			</td>
			<td style="width:264px">
			<p>-Trọng lượng 3100gram Sai số &plusmn;0.01gram</p>
			</td>
		</tr>
		<tr>
			<td style="width:37px">
			<p style="text-align:center">04</p>
			</td>
			<td style="width:150px">
			<p>C&acirc;n lớn 30Kg</p>
			</td>
			<td style="width:30px">
			<p style="text-align:center">01</p>
			</td>
			<td style="width:264px">
			<p>-Trọng lượng 30Kg Sai số &plusmn;0.1</p>
			</td>
		</tr>
		<tr>
			<td style="width:37px">
			<p style="text-align:center">05</p>
			</td>
			<td style="width:150px">
			<p>M&agrave;n h&igrave;nh LCD 17&rsquo;&rsquo;</p>
			</td>
			<td style="width:30px">
			<p style="text-align:center">01</p>
			</td>
			<td style="width:264px">
			<p>-Độ ph&acirc;n giải 1500 x 1200 pixel</p>
			</td>
		</tr>
		<tr>
			<td style="width:37px">
			<p style="text-align:center">06</p>
			</td>
			<td style="width:150px">
			<p>M&aacute;y t&iacute;nh c&ocirc;ng nghiệp</p>
			</td>
			<td style="width:30px">
			<p style="text-align:center">01</p>
			</td>
			<td style="width:264px">
			<p>-</p>
			</td>
		</tr>
		<tr>
			<td style="width:37px">
			<p style="text-align:center">07</p>
			</td>
			<td style="width:150px">
			<p>M&aacute;y đọc m&atilde; vạch</p>
			</td>
			<td style="width:30px">
			<p style="text-align:center">01</p>
			</td>
			<td style="width:264px">
			<p>-</p>
			</td>
		</tr>
		<tr>
			<td style="width:37px">
			<p style="text-align:center">08</p>
			</td>
			<td style="width:150px">
			<p>UPS</p>
			</td>
			<td style="width:30px">
			<p style="text-align:center">01</p>
			</td>
			<td style="width:264px">
			<p>-</p>
			</td>
		</tr>
		<tr>
			<td style="width:37px">
			<p style="text-align:center">09</p>
			</td>
			<td style="width:150px">
			<p>Bộ điều khiển button</p>
			</td>
			<td style="width:30px">
			<p style="text-align:center">01</p>
			</td>
			<td style="width:264px">
			<p>Gồm nguồn tổng, đ&egrave;n b&aacute;o, n&uacute;t nhấn</p>
			</td>
		</tr>
	</tbody>
</table>

<p><strong><em>►&nbsp;</em></strong>G&oacute;i sản phẩm li&ecirc;n kết :</p>

<p><em>&rArr;</em><em>&nbsp;&nbsp;<a href="http://baotinsoftware.com/san-pham/chuyen-dung-cho-nha-may-nhuom-5/phan-mem-quan-ly-moc-nha-may-nhuom-18.html" style="box-sizing: border-box; color: rgb(51, 122, 183); text-decoration: none; transition: 300ms; background-color: transparent;">Phần mềm quản l&yacute; mộc</a></em></p>

<p><em>&rArr;</em><em>&nbsp;&nbsp;<a href="http://baotinsoftware.com/san-pham/chuyen-dung-cho-nha-may-det-7/phan-mem-quan-ly-det-nha-may-det-14.html" style="box-sizing: border-box; color: rgb(51, 122, 183); text-decoration: none; transition: 300ms; background-color: transparent;">Phần mềm quản l&yacute; dệt</a></em></p>

<p><a href="/Upload/images/Documents/ChemicalStation.pdf"><img alt="" src="/Upload/images/Icons/PDF_downlaod-2.png" style="height:24px; width:24px" /></a><a href="/Upload/images/Documents/ChemicalStation.pdf"><span style="color:#A9A9A9"><span style="font-size:15.3333px">Download T&agrave;i Liệu Về Sản Phẩm</span></span></a></p>

<hr />
<p><em><span style="color:rgb(69, 129, 142); font-family:arial,sans-serif; font-size:9pt">Rất mong được phục vụ qu&yacute; kh&aacute;ch h&agrave;ng !</span></em></p>

<p><iframe frameborder="0" height="292" scrolling="no" src="https://www.facebook.com/plugins/page.php?href=https%3A%2F%2Fwww.facebook.com%2FBaoTinSoft%2F&amp;tabs=timeline&amp;width=340&amp;height=292&amp;small_header=false&amp;adapt_container_width=true&amp;hide_cover=false&amp;show_facepile=true&amp;appId" style="border:none;overflow:hidden" width="340"></iframe></p>

<p><span style="font-family:arial,sans-serif; font-size:9pt"><a href="http://baotinsoftware.com/lien-he.html" style="box-sizing: border-box; transition: 300ms;"><em><span style="color:rgb(69, 129, 142)">►Vui l&ograve;ng li&ecirc;n hệ với ch&uacute;ng t&ocirc;i&nbsp;</span></em></a></span></p>

<p><em><span style="color:rgb(69, 129, 142); font-family:arial,sans-serif; font-size:9pt">Tham khảo web:&nbsp;</span></em><span style="color:rgb(0, 153, 0); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span><em><span style="color:rgb(34, 34, 34); font-family:arial,sans-serif; font-size:9pt"><a href="http://baotinsoftware.com/" style="box-sizing: border-box; transition: 300ms;" target="_blank"><span style="color:rgb(246, 178, 107)">Http://baotinsoftware.com</span></a></span></em><span style="color:rgb(246, 178, 107); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span></p>

<p><em><span style="color:rgb(69, 129, 142); font-family:arial,sans-serif; font-size:9pt">Hoặc</span></em><span style="color:rgb(246, 178, 107); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span><em><span style="color:rgb(34, 34, 34); font-family:arial,sans-serif; font-size:9pt"><a href="http://baotinsoftware.com/" style="box-sizing: border-box; transition: 300ms;" target="_blank"><span style="color:rgb(246, 178, 107)">Http://baotinsoftware.com.vn</span></a></span></em></p>

<p><em><span style="color:rgb(69, 129, 142); font-family:arial,sans-serif; font-size:9pt">Email:</span></em><span style="color:rgb(0, 153, 0); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span><span style="color:rgb(204, 0, 0); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span><em><span style="color:rgb(61, 133, 198); font-family:arial,sans-serif; font-size:9pt"><a href="http://baotinsoftware.com/" style="box-sizing: border-box; transition: 300ms;" target="_blank"><span style="color:rgb(51, 122, 183)">baotinsoftware@gmail.com</span></a></span></em></p>

<p><em><span style="color:rgb(11, 83, 148); font-family:arial,sans-serif; font-size:9pt">Phone / Zalo :&nbsp;</span></em><em><span style="font-family:arial,sans-serif; font-size:10pt">&nbsp;</span></em><strong><em><span style="color:rgb(11, 83, 148); font-family:arial,sans-serif; font-size:9pt">0988 898996 Lộc</span></em></strong></p>
', CAST(250000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 11, CAST(N'2017-11-18 15:15:29.473' AS DateTime), 372, 0, 1, 1, 1, N'')
INSERT [dbo].[PRODUCTS] ([ID], [Code], [Name], [Tag], [Image], [Sapo], [Content], [Price], [PriceOld], [ID_GroupProduct], [DatePublish], [CountView], [CountBuy], [StatusID], [IsActive], [IsHot], [LinkY]) VALUES (9, N'OX7', N'Hệ thống cân chất lỏng tự động - MultiLine Auto', N'he-thong-can-chat-long-tu-dong-multiline-auto', N'/Upload/images/MultiLineAuto.jpg', N'', N'<p><span style="color:darkorange; font-family:arial,sans-serif; font-size:11.5pt">►Đ&Ocirc;I N&Eacute;T VỀ HỆ THỐNG C&Acirc;N CHẤT LỎNG TỰ ĐỘNG</span></p>

<p><span style="font-family:arial,sans-serif; font-size:11.5pt">&nbsp; &nbsp; &nbsp;</span><span style="font-family:arial,sans-serif; font-size:10pt">&nbsp;&nbsp;</span><span style="color:#7C7C7C; font-family:arial,sans-serif; font-size:9.0pt">- Hệ thống c&acirc;n chất lỏng tự động cho ph&eacute;p nhập c&aacute;c c&ocirc;ng thức v&agrave; dung tỷ v&agrave;o m&aacute;y t&iacute;nh để tự động t&iacute;nh to&aacute;n c&aacute;c c&ocirc;ng thức c&acirc;n cho từng mẻ nhuộm. Sau đ&oacute;, hệ thống sẽ k&iacute;ch hoạt c&aacute;c m&aacute;y bơm m&agrave;ng để chuyển h&oacute;a chất v&agrave;o c&aacute;c th&ugrave;ng chứa h&oacute;a chất th&ocirc;ng qua c&aacute;c m&aacute;y t&iacute;nh v&agrave; PLC điều khiển sử dụng c&acirc;n điện tử điều chỉnh về liều lượng chất lỏng ch&iacute;nh x&aacute;c. Trọng lượng của c&aacute;c h&oacute;a chất n&agrave;y c&oacute; thể in v&agrave; c&oacute;&nbsp; ghi lại th&ocirc;ng tin phản hồi cho quản l&yacute; h&agrave;ng tồn kho.</span></p>

<p><span style="color:#7C7C7C; font-family:arial,sans-serif; font-size:9.0pt">&nbsp; &nbsp; &nbsp; - Hệ thống n&agrave;y c&oacute; thể cho ph&eacute;p c&aacute;c nh&agrave; m&aacute;y nhuộm để tập trung quản l&yacute; h&oacute;a chất v&agrave; tăng năng suất c&ocirc;ng việc.</span></p>

<p><img alt="" src="/Upload/images/Mutiline%20Auto%20-3.jpg" style="height:332px; width:827px" /></p>

<p><span style="color:darkorange; font-family:arial,sans-serif; font-size:11.5pt">►C&Aacute;C T&Iacute;NH NĂNG CH&Iacute;NH</span></p>

<p><span style="color:#7C7C7C; font-family:arial,sans-serif; font-size:9.0pt">- Bơm h&oacute;a chất từ trạm bơm ra trực tiếp bồn m&agrave;u m&aacute;y nhuộm theo số lượng y&ecirc;u cầu.</span></p>

<p><span style="font-size:12px"><span style="font-family:arial,helvetica,sans-serif"><span style="color:rgb(124, 124, 124)">&nbsp;</span>- Sử dụng c&acirc;n điện tử để tăng độ ch&iacute;nh x&aacute;c liều lượng h&oacute;a chất,sai số cho ph&eacute;p của từng chất&nbsp; trong khoảng 1~3 %.</span></span></p>

<p><span style="color:#7C7C7C; font-family:arial,sans-serif; font-size:9.0pt">&nbsp;- D&atilde;y h&oacute;a chất nằm gần nhau tiết kiệm kh&ocirc;ng gian v&agrave; dễ d&agrave;ng thay thế.</span></p>

<p><span style="color:#7C7C7C; font-family:arial,sans-serif; font-size:9.0pt">&nbsp;- Mỗi d&atilde;i h&oacute;a chất duy nhất c&oacute; thể kiểm so&aacute;t 6 - 8 loại h&oacute;a chất.</span></p>

<p><span style="color:#7C7C7C; font-family:arial,sans-serif; font-size:9.0pt">&nbsp;- C&acirc;n ho&agrave;n to&agrave;n tự động li&ecirc;n tục v&agrave; đ&uacute;ng số lượng h&oacute;a chất được sử dụng, l&agrave;m giảm lỗi của con người v&agrave; l&atilde;nh ph&iacute; qu&aacute; mức.</span></p>

<p><span style="color:#7C7C7C; font-family:arial,sans-serif; font-size:9.0pt">&nbsp;- Tủ điện ch&iacute;nh được l&agrave;m bằng Inox&nbsp; 304 kh&ocirc;ng rỉ v&agrave; c&oacute; thể rửa được bằng nước.</span></p>

<p><span style="color:#7C7C7C; font-family:arial,sans-serif; font-size:9.0pt">&nbsp;- Xử dụng m&agrave;n h&igrave;nh cảm ứng gi&uacute;p c&ocirc;ng nh&acirc;n thao t&aacute;c dễ d&agrave;ng.</span></p>

<p><span style="color:rgb(255, 140, 0); font-family:arial,sans-serif; font-size:10pt">►PHẦN MỀM</span></p>

<p><span style="color:#7C7C7C; font-family:arial,sans-serif; font-size:9.0pt">- Giao diện người d&ugrave;ng th&acirc;n thiện về đồ họa cho hoạt động dễ d&agrave;ng, sử dụng m&agrave;n h&igrave;nh cảm ứng gi&uacute;p thao t&aacute;c đơn giản tr&ecirc;n phần mềm.</span></p>

<p><span style="color:#7C7C7C; font-family:arial,sans-serif; font-size:9.0pt">- Phần mềm được t&iacute;ch hợp với hệ thống đầu đọc m&atilde; vạch.</span></p>

<p><span style="color:#7C7C7C; font-family:arial,sans-serif; font-size:9.0pt">- C&oacute; thể t&ugrave;y chọn li&ecirc;n kết với hệ thống quản l&yacute; c&ocirc;ng việc đang hiện h&agrave;nh tại nh&agrave; m&aacute;y.</span></p>

<p><span style="color:#7C7C7C; font-family:arial,sans-serif; font-size:9.0pt">- Lịch sử c&acirc;n được ghi lại tr&ecirc;n hệ thống m&aacute;y chủ, gi&uacute;p cho người quản l&yacute; nắm bắt th&ocirc;ng tin chi tiết từng phiếu c&acirc;n.</span></p>

<p><span style="color:#7C7C7C; font-family:arial,sans-serif; font-size:9.0pt">- H&oacute;a chất đầu v&agrave;o ngay được kiểm so&aacute;t bằng hệ thống nhập kho phần mềm.</span></p>

<p><span style="color:#7C7C7C; font-family:arial,sans-serif; font-size:9.0pt">- Phần mềm hỗ trợ người quản l&yacute; kiểm so&aacute;t danh s&aacute;ch phiếu chưa c&acirc;n ho&agrave;n chỉnh của từng mẻ.</span></p>

<p><strong><em>►&nbsp;</em></strong>G&oacute;i sản phẩm li&ecirc;n kết :</p>

<p><em>&rArr;</em><em>&nbsp; <a href="http://baotinsoftware.com/san-pham/chuyen-dung-cho-nha-may-nhuom-5/phan-mem-quan-ly-moc-nha-may-nhuom-18.html">Phần mềm quản l&yacute; mộc</a></em></p>

<p><em>&rArr;</em><em> &nbsp;<a href="http://baotinsoftware.com/san-pham/chuyen-dung-cho-nha-may-det-7/phan-mem-quan-ly-det-nha-may-det-14.html">Phần mềm quản l&yacute; dệt</a></em></p>

<p><img alt="" src="/Upload/images/Icons/PDF_downlaod-2.png" style="height:24px; width:24px" /><span style="color:#A9A9A9">Download T&agrave;i Liệu Về Sản Phẩm</span></p>

<hr />
<p><em><span style="color:rgb(69, 129, 142); font-family:arial,sans-serif; font-size:9pt">Rất mong được phục vụ qu&yacute; kh&aacute;ch h&agrave;ng !</span></em></p>

<p><iframe frameborder="0" height="292" scrolling="no" src="https://www.facebook.com/plugins/page.php?href=https%3A%2F%2Fwww.facebook.com%2FBaoTinSoft%2F&amp;tabs=timeline&amp;width=340&amp;height=292&amp;small_header=false&amp;adapt_container_width=true&amp;hide_cover=false&amp;show_facepile=true&amp;appId" style="border:none;overflow:hidden" width="340"></iframe></p>

<p><span style="font-family:arial,sans-serif; font-size:9pt"><a href="http://baotinsoftware.com/lien-he.html" style="box-sizing: border-box; transition: 300ms;"><em><span style="color:rgb(69, 129, 142)">►Vui l&ograve;ng li&ecirc;n hệ với ch&uacute;ng t&ocirc;i&nbsp;</span></em></a></span></p>

<p><em><span style="color:rgb(69, 129, 142); font-family:arial,sans-serif; font-size:9pt">Tham khảo web:&nbsp;</span></em><span style="color:rgb(0, 153, 0); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span><em><span style="color:rgb(34, 34, 34); font-family:arial,sans-serif; font-size:9pt"><a href="http://baotinsoftware.com/" style="box-sizing: border-box; transition: 300ms;" target="_blank"><span style="color:rgb(246, 178, 107)">Http://baotinsoftware.com</span></a></span></em><span style="color:rgb(246, 178, 107); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span></p>

<p><em><span style="color:rgb(69, 129, 142); font-family:arial,sans-serif; font-size:9pt">Hoặc</span></em><span style="color:rgb(246, 178, 107); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span><em><span style="color:rgb(34, 34, 34); font-family:arial,sans-serif; font-size:9pt"><a href="http://baotinsoftware.com/" style="box-sizing: border-box; transition: 300ms;" target="_blank"><span style="color:rgb(246, 178, 107)">Http://baotinsoftware.com.vn</span></a></span></em></p>

<p><em><span style="color:rgb(69, 129, 142); font-family:arial,sans-serif; font-size:9pt">Email:</span></em><span style="color:rgb(0, 153, 0); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span><span style="color:rgb(204, 0, 0); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span><em><span style="color:rgb(61, 133, 198); font-family:arial,sans-serif; font-size:9pt"><a href="http://baotinsoftware.com/" style="box-sizing: border-box; transition: 300ms;" target="_blank"><span style="color:rgb(51, 122, 183)">baotinsoftware@gmail.com</span></a></span></em></p>

<p><em><span style="color:rgb(11, 83, 148); font-family:arial,sans-serif; font-size:9pt">Phone / Zalo :&nbsp;</span></em><em><span style="font-family:arial,sans-serif; font-size:10pt">&nbsp;</span><span style="color:rgb(11, 83, 148); font-family:arial,sans-serif; font-size:9pt">0988 898996 Lộc</span></em></p>
', CAST(6700000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 10, CAST(N'2017-11-18 15:20:13.803' AS DateTime), 390, 0, 1, 1, 1, N'')
INSERT [dbo].[PRODUCTS] ([ID], [Code], [Name], [Tag], [Image], [Sapo], [Content], [Price], [PriceOld], [ID_GroupProduct], [DatePublish], [CountView], [CountBuy], [StatusID], [IsActive], [IsHot], [LinkY]) VALUES (10, N'SP990', N'Giấy Decal', N'giay-decal', N'/Upload/images/DECAL.jpg', N'', N'<p><span style="color:#FF8C00">►TH&Ocirc;NG TIN SẢN PHẨM</span></p>

<p>- Vật liệu, giấy, PVC, Satin &hellip; c&oacute; nguồn gốc xuất xứ từ c&aacute;c h&atilde;ng nổi tiếng như Avery Fasson (USA),..</p>

<p>- Sản xuất theo k&iacute;ch thước t&ugrave;y chọn của kh&aacute;ch h&agrave;ng</p>

<p>- Chất lượng ổn định, l&acirc;u d&agrave;i</p>

<p>- Đạt ti&ecirc;u chuẩn c&aacute;c m&aacute;y in nh&atilde;n chuy&ecirc;n dụng</p>

<p>- Tư vấn lọai ruy băng &amp; giấy in tem ph&ugrave; hợp ứng dụng &amp; m&aacute;y in của kh&aacute;ch h&agrave;ng.</p>

<p>----------------------oo00oo----------------------</p>

<p><em><strong>Rất mong được phục vụ qu&yacute; kh&aacute;ch h&agrave;ng !</strong></em></p>

<p>Tham khảo web&nbsp;<a href="http://baotinsoftware.com/" target="_blank">Http://baotinsoftware.com</a>&nbsp;hoặc&nbsp;<a href="http://baotinsoftware.com/" target="_blank">Http://baotinsoftware.com.vn</a></p>

<p>Email:&nbsp;&nbsp;<a href="http://baotinsoftware.com/" target="_blank">baotinsoftware@gmail.com</a></p>

<p><em>Phone - Zalo:&nbsp;</em><em>&nbsp;0988 898996 Lộc</em></p>
', CAST(13900000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 22, CAST(N'2016-08-31 21:10:31.150' AS DateTime), 163, 0, 3, 1, 0, N'')
INSERT [dbo].[PRODUCTS] ([ID], [Code], [Name], [Tag], [Image], [Sapo], [Content], [Price], [PriceOld], [ID_GroupProduct], [DatePublish], [CountView], [CountBuy], [StatusID], [IsActive], [IsHot], [LinkY]) VALUES (11, N'5S64G', N'Apple Iphone 6S - 64G Black/White/Gold chính hãng', N'apple-iphone-6s-64g-blackwhitegold-chinh-hang', N'/Upload/images/Products/iphone-6s-pink_1_2_1.jpg', N'', N'', CAST(16900000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 8, CAST(N'2015-09-28 13:58:56.610' AS DateTime), 62, 0, 2, 0, 0, NULL)
INSERT [dbo].[PRODUCTS] ([ID], [Code], [Name], [Tag], [Image], [Sapo], [Content], [Price], [PriceOld], [ID_GroupProduct], [DatePublish], [CountView], [CountBuy], [StatusID], [IsActive], [IsHot], [LinkY]) VALUES (12, N'24SP16', N'Apple iPad Air 2 4G 16 GB', N'apple-ipad-air-2-4g-16-gb', N'/Upload/images/Products/ipad-air-2-gold_2.jpg', N'', N'', CAST(12900000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 9, CAST(N'2015-09-28 14:01:30.027' AS DateTime), 56, 0, 2, 0, 0, NULL)
INSERT [dbo].[PRODUCTS] ([ID], [Code], [Name], [Tag], [Image], [Sapo], [Content], [Price], [PriceOld], [ID_GroupProduct], [DatePublish], [CountView], [CountBuy], [StatusID], [IsActive], [IsHot], [LinkY]) VALUES (13, N'S18-55', N'Hệ thống quản lý nhiệt độ máy nhuộm - Auto Temp V.1.0', N'he-thong-quan-ly-nhiet-do-may-nhuom-auto-temp-v10', N'/Upload/images/ManagerTemp.jpg', N'', N'<p><img alt="" src="/Upload/images/Icons/PDF_downlaod-2.png" style="height:24px; line-height:20.8px; width:24px" /><span style="color:rgb(169, 169, 169)">Download T&agrave;i Liệu Về Sản Phẩm</span></p>

<hr />
<p><em><span style="color:rgb(69, 129, 142); font-family:arial,sans-serif; font-size:9pt">Rất mong được phục vụ qu&yacute; kh&aacute;ch h&agrave;ng !</span></em></p>

<p><span style="font-family:arial,sans-serif; font-size:9pt"><a href="http://baotinsoftware.com/lien-he.html" style="box-sizing: border-box; transition: 300ms;"><em><span style="color:rgb(69, 129, 142)">►Vui l&ograve;ng li&ecirc;n hệ với ch&uacute;ng t&ocirc;i&nbsp;</span></em></a></span></p>

<p><em><span style="color:rgb(69, 129, 142); font-family:arial,sans-serif; font-size:9pt">Tham khảo web:&nbsp;</span></em><span style="color:rgb(0, 153, 0); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span><em><span style="color:rgb(34, 34, 34); font-family:arial,sans-serif; font-size:9pt"><a href="http://baotinsoftware.com/" style="box-sizing: border-box; transition: 300ms;" target="_blank"><span style="color:rgb(246, 178, 107)">Http://baotinsoftware.com</span></a></span></em><span style="color:rgb(246, 178, 107); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span></p>

<p><em><span style="color:rgb(69, 129, 142); font-family:arial,sans-serif; font-size:9pt">Hoặc</span></em><span style="color:rgb(246, 178, 107); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span><em><span style="color:rgb(34, 34, 34); font-family:arial,sans-serif; font-size:9pt"><a href="http://baotinsoftware.com/" style="box-sizing: border-box; transition: 300ms;" target="_blank"><span style="color:rgb(246, 178, 107)">Http://baotinsoftware.com.vn</span></a></span></em></p>

<p><em><span style="color:rgb(69, 129, 142); font-family:arial,sans-serif; font-size:9pt">Email:</span></em><span style="color:rgb(0, 153, 0); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span><span style="color:rgb(204, 0, 0); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span><em><span style="color:rgb(61, 133, 198); font-family:arial,sans-serif; font-size:9pt"><a href="http://baotinsoftware.com/" style="box-sizing: border-box; transition: 300ms;" target="_blank"><span style="color:rgb(51, 122, 183)">baotinsoftware@gmail.com</span></a></span></em></p>

<p><em><span style="color:rgb(11, 83, 148); font-family:arial,sans-serif; font-size:9pt">Phone / Zalo :&nbsp;</span>&nbsp;<span style="color:rgb(11, 83, 148); font-family:arial,sans-serif; font-size:9pt">0988 898996 Lộc</span></em></p>
', CAST(11000000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 16, CAST(N'2016-09-05 07:10:24.673' AS DateTime), 170, 0, 1, 1, 0, N'')
INSERT [dbo].[PRODUCTS] ([ID], [Code], [Name], [Tag], [Image], [Sapo], [Content], [Price], [PriceOld], [ID_GroupProduct], [DatePublish], [CountView], [CountBuy], [StatusID], [IsActive], [IsHot], [LinkY]) VALUES (14, N'LGG32', N'Phần mềm quản lý dệt - Nhà máy dệt', N'phan-mem-quan-ly-det-nha-may-det', N'/Upload/images/PM- DET-1.jpg', N'', N'<p><img alt="" src="/Upload/images/Icons/PDF_downlaod-2.png" style="height:24px; line-height:20.8px; width:24px" /><span style="color:rgb(169, 169, 169)">Download T&agrave;i Liệu Về Sản Phẩm</span></p>

<hr />
<p><img alt="" src="/Upload/images/Products/img_7-600x380.jpg" style="height:380px; width:600px" /></p>

<p><em><span style="color:rgb(69, 129, 142); font-family:arial,sans-serif; font-size:9pt">Rất mong được phục vụ qu&yacute; kh&aacute;ch h&agrave;ng !</span></em></p>

<p><iframe frameborder="0" height="292" scrolling="no" src="https://www.facebook.com/plugins/page.php?href=https%3A%2F%2Fwww.facebook.com%2FBaoTinSoft%2F&amp;tabs=timeline&amp;width=340&amp;height=292&amp;small_header=false&amp;adapt_container_width=true&amp;hide_cover=false&amp;show_facepile=true&amp;appId" style="border:none;overflow:hidden" width="340"></iframe></p>

<p><span style="font-family:arial,sans-serif; font-size:9pt"><a href="http://baotinsoftware.com/lien-he.html" style="box-sizing: border-box; transition: 300ms;"><em><span style="color:rgb(69, 129, 142)">►Vui l&ograve;ng li&ecirc;n hệ với ch&uacute;ng t&ocirc;i&nbsp;</span></em></a></span></p>

<p><em><span style="color:rgb(69, 129, 142); font-family:arial,sans-serif; font-size:9pt">Tham khảo web:&nbsp;</span></em><span style="color:rgb(0, 153, 0); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span><em><span style="color:rgb(34, 34, 34); font-family:arial,sans-serif; font-size:9pt"><a href="http://baotinsoftware.com/" style="box-sizing: border-box; transition: 300ms;" target="_blank"><span style="color:rgb(246, 178, 107)">Http://baotinsoftware.com</span></a></span></em><span style="color:rgb(246, 178, 107); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span></p>

<p><em><span style="color:rgb(69, 129, 142); font-family:arial,sans-serif; font-size:9pt">Hoặc</span></em><span style="color:rgb(246, 178, 107); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span><em><span style="color:rgb(34, 34, 34); font-family:arial,sans-serif; font-size:9pt"><a href="http://baotinsoftware.com/" style="box-sizing: border-box; transition: 300ms;" target="_blank"><span style="color:rgb(246, 178, 107)">Http://baotinsoftware.com.vn</span></a></span></em></p>

<p><em><span style="color:rgb(69, 129, 142); font-family:arial,sans-serif; font-size:9pt">Email:</span></em><span style="color:rgb(0, 153, 0); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span><span style="color:rgb(204, 0, 0); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span><em><span style="color:rgb(61, 133, 198); font-family:arial,sans-serif; font-size:9pt"><a href="http://baotinsoftware.com/" style="box-sizing: border-box; transition: 300ms;" target="_blank"><span style="color:rgb(51, 122, 183)">baotinsoftware@gmail.com</span></a></span></em></p>

<p><em><span style="color:rgb(11, 83, 148); font-family:arial,sans-serif; font-size:9pt">Phone / Zalo :&nbsp;</span></em><em><span style="font-family:arial,sans-serif; font-size:10pt">&nbsp;</span><span style="color:rgb(11, 83, 148); font-family:arial,sans-serif; font-size:9pt">0988 898996 Lộc</span></em></p>
', CAST(12000000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 7, CAST(N'2017-11-18 14:54:50.407' AS DateTime), 222, 0, 1, 1, 1, N'')
INSERT [dbo].[PRODUCTS] ([ID], [Code], [Name], [Tag], [Image], [Sapo], [Content], [Price], [PriceOld], [ID_GroupProduct], [DatePublish], [CountView], [CountBuy], [StatusID], [IsActive], [IsHot], [LinkY]) VALUES (15, N'XZ364G', N'Cân thành phẩm & xuất hàng - Weigh & Export V1.3', N'can-thanh-pham-xuat-hang-weigh-export-v13', N'/Upload/images/Complete_Out.png', N'', N'<p><img alt="" src="/Upload/images/Products/img_7-600x380.jpg" style="height:380px; width:600px" /></p>

<p>Nhằm đ&aacute;p ứng nhu cầu của kh&aacute;ch h&agrave;ng, ch&uacute;ng t&ocirc;i đưa ra phi&ecirc;n bản quản l&iacute; c&acirc;n th&agrave;nh phẩm mộc v&agrave; xuất h&agrave;ng. C&aacute;c t&iacute;nh năng ch&iacute;nh của phần mềm như sau:</p>

<p><span style="color:#008080">►</span> L&ecirc;n đơn h&agrave;ng v&agrave; ph&acirc;n mẻ căng cho kh&aacute;ch h&agrave;ng.</p>

<p><span style="color:#008080">►</span> Thực hiện c&acirc;n h&agrave;ng ( phần n&agrave;y c&oacute; li&ecirc;n kết thiết bị như c&acirc;n điện tử v&agrave; m&aacute;y in tem)</p>

<p><span style="color:#008080">►</span> Theo d&otilde;i chi tiết h&agrave;ng th&agrave;nh phẩm</p>

<p><span style="color:#008080">►</span> Quản l&yacute; nhập xuất tồn kho th&agrave;nh phẩm</p>

<p><span style="color:#008080">► </span>Xuất h&agrave;ng th&agrave;nh phẩm giao kh&aacute;ch v&agrave; in phiếu giao h&agrave;ng.</p>

<p><span style="color:#008080">►</span> Xuất c&aacute;c b&aacute;o c&aacute;o ( nhập kho hằng ng&agrave;y, xuất kho, NXT kho th&agrave;nh phẩm..)</p>

<p>Một số mẫu tem ch&uacute;ng t&ocirc;i đ&atilde; x&acirc;y dựng cho kh&aacute;ch h&agrave;ng, Bảo T&iacute;n sẽ update cho tham khảo.</p>

<p><span style="color:#A52A2A"><em>Lưu &yacute;: nếu kh&aacute;ch h&agrave;ng c&oacute; nhu cầu cập nhật phi&ecirc;n bản full sau khi sử dụng, phi&ecirc;n b&agrave;n n&agrave;y vẫn hỗ trợ n&acirc;ng cấp t&iacute;nh năng kh&ocirc;ng bắt buộc phải thay đổi hoặc loại bỏ phi&ecirc;n bản đang sử dụng.</em></span></p>

<p><em>Rất mong được phục vụ qu&yacute; kh&aacute;ch h&agrave;ng !</em></p>

<p><iframe frameborder="0" height="292" scrolling="no" src="https://www.facebook.com/plugins/page.php?href=https%3A%2F%2Fwww.facebook.com%2FBaoTinSoft%2F&amp;tabs=timeline&amp;width=340&amp;height=292&amp;small_header=false&amp;adapt_container_width=true&amp;hide_cover=false&amp;show_facepile=true&amp;appId" style="border:none;overflow:hidden" width="340"></iframe></p>

<p><a href="http://baotinsoftware.com/lien-he.html"><em>►Vui l&ograve;ng li&ecirc;n hệ với ch&uacute;ng t&ocirc;i&nbsp;</em></a></p>

<p><em>Tham khảo web:&nbsp;</em>&nbsp;<em><a href="http://baotinsoftware.com/" target="_blank">Http://baotinsoftware.com</a></em>&nbsp;</p>

<p><em>Hoặc</em>&nbsp;<em><a href="http://baotinsoftware.com/" target="_blank">Http://baotinsoftware.com.vn</a></em></p>

<p><em>Email:</em>&nbsp;&nbsp;<em><a href="http://baotinsoftware.com/" target="_blank">baotinsoftware@gmail.com</a></em></p>

<p><em>Phone / Zalo :&nbsp;</em>&nbsp;<em><strong>0988 898996 Lộc</strong></em></p>
', CAST(14900000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 2, CAST(N'2017-11-18 15:10:40.937' AS DateTime), 123, 0, 1, 1, 1, N'')
INSERT [dbo].[PRODUCTS] ([ID], [Code], [Name], [Tag], [Image], [Sapo], [Content], [Price], [PriceOld], [ID_GroupProduct], [DatePublish], [CountView], [CountBuy], [StatusID], [IsActive], [IsHot], [LinkY]) VALUES (17, N'SX170', N'Phần mềm quản lý cân hóa chất - Nhà máy nhuộm', N'phan-mem-quan-ly-can-hoa-chat-nha-may-nhuom', N'/Upload/images/PM- HOA CHAT2.jpg', N'<p>C&oacute; những thay đổi trong cuộc đời kh&ocirc;ng phải ai cũng sẽ nhận biết hết được. Bạn v&agrave; t&ocirc;i hoặc ai đ&oacute;, giữa ch&uacute;ng ta lu&ocirc;n c&oacute; một mối li&ecirc;n kết v&ocirc; h&igrave;nh đầy k&igrave; diệu khiến cho cuộc sống của mỗi người thật nhiều &yacute; nghĩa hơn.&nbsp;</p>
', N'<p><img alt="" src="/Upload/images/Products/img_7-600x380.jpg" style="height:380px; width:600px" /></p>

<p><span style="color:rgb(255, 140, 0)"><span style="font-family:arial,sans-serif; font-size:10pt">►Đ&Ocirc;I N&Eacute;T VỀ HỆ THỐNG C&Acirc;N CHẤT H&Oacute;A CHẤT</span></span></p>

<p><span style="color:rgb(124, 124, 124); font-family:arial,sans-serif; font-size:10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Hệ thống quản l&yacute; c&acirc;n h&oacute;a chất cho ph&eacute;p nhập c&aacute;c c&ocirc;ng thức h&oacute;a chất v&agrave; trọng lượng vải v&agrave;o m&aacute;y t&iacute;nh để tự động t&iacute;nh to&aacute;n c&aacute;c c&ocirc;ng thức nhuộm. Sau đ&oacute;, hệ thống sẽ hướng dẫn vị tr&iacute; c&acirc;n từng chất cho nh&acirc;n vi&ecirc;n ph&ograve;ng c&acirc;n, chỉ cần thực hiện c&acirc;n đ&uacute;ng số lượng y&ecirc;u cầu theo dung sai cho ph&eacute;p. Trọng lượng c&acirc;n của c&aacute;c h&oacute;a chất n&agrave;y c&oacute; thể in, lưu lại v&agrave; c&oacute; thể ghi lại th&ocirc;ng tin phản hồi cho quản l&yacute; h&agrave;ng tồn kho.</span></p>

<p><span style="color:rgb(124, 124, 124); font-family:arial,sans-serif; font-size:10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Hệ thống n&agrave;y c&oacute; thể cho ph&eacute;p c&aacute;c nh&agrave; m&aacute;y nhuộm để tập trung quản l&yacute; h&oacute;a chất v&agrave; tăng năng suất c&ocirc;ng việc.</span></p>

<p><span style="color:rgb(124, 124, 124); font-family:arial,sans-serif; font-size:10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Hệ thống n&agrave;y cũng l&agrave;m giảm tỷ lệ lỗi của con người v&agrave; g&acirc;y l&atilde;ng ph&iacute; về h&oacute;a chất.</span></p>

<table border="1" cellpadding="1" cellspacing="1" style="height:151px; width:763px">
	<caption><strong><span style="color:#A9A9A9">DANH S&Aacute;CH MỘT SỐ KH&Aacute;CH H&Agrave;NG ĐIỂN H&Igrave;NH ĐANG ỨNG DỤNG HỆ THỐNG PHẦN MỀM QUẢN L&Yacute; H&Oacute;A CHẤT CỦA BẢO T&Iacute;N</span></strong></caption>
	<tbody>
		<tr>
			<td style="text-align:center"><span style="font-size:10px"><span style="font-family:times new roman,times,serif"><strong>ST</strong></span></span></td>
			<td style="text-align:center"><span style="font-size:10px"><span style="font-family:times new roman,times,serif"><strong>ĐƠN VỊ</strong></span></span></td>
			<td style="text-align:center"><span style="font-size:10px"><span style="font-family:times new roman,times,serif"><strong>ĐỊA CHỈ</strong></span></span></td>
			<td style="text-align:center"><span style="font-size:10px"><span style="font-family:times new roman,times,serif"><strong>LI&Ecirc;N HỆ</strong></span></span></td>
		</tr>
		<tr>
			<td><span style="font-size:10px"><span style="font-family:times new roman,times,serif"><strong>1</strong></span></span></td>
			<td>
			<p><span style="font-size:10px"><span style="font-family:times new roman,times,serif">C&Ocirc;NG TY TNHH DỆT NHUỘM HƯNG PH&Aacute;T ĐẠT</span></span></p>
			</td>
			<td>
			<p><span style="font-size:10px"><span style="font-family:times new roman,times,serif">HC 3 ĐƯỜNG SỐ 3 KCN XUY&Ecirc;N &Aacute; X&Atilde; MỸ HẠNH BẮC H.ĐỨC H&Ograve;A T.LONG AN</span></span></p>
			</td>
			<td><span style="font-size:10px"><span style="font-family:times new roman,times,serif">A DUẨN</span></span></td>
		</tr>
		<tr>
			<td><span style="font-size:10px"><span style="font-family:times new roman,times,serif"><strong>2</strong></span></span></td>
			<td><span style="font-size:10px"><span style="font-family:times new roman,times,serif">C&Ocirc;NG TY TNHH SX TM DV SƠN TI&Ecirc;N</span></span></td>
			<td><span style="font-size:10px"><span style="font-family:times new roman,times,serif">ĐƯỜNG SỐ 4 T&Acirc;N TẠO A B&Igrave;NH T&Acirc;N TP.HCM</span></span></td>
			<td><span style="font-size:10px"><span style="font-family:times new roman,times,serif">A.TRUNG</span></span></td>
		</tr>
		<tr>
			<td><span style="font-size:10px"><span style="font-family:times new roman,times,serif"><strong>3</strong></span></span></td>
			<td><span style="font-size:10px"><span style="font-family:times new roman,times,serif">C&Ocirc;NG TY TNHH DỆT NHUỘM SƠN TI&Ecirc;N</span></span></td>
			<td><span style="font-size:10px"><span style="font-family:times new roman,times,serif">L&Ocirc; A09-14 ĐƯỜNG SỐ 9 KCN HẢI SƠN X&Atilde; ĐỨC H&Ograve;A HẠ, HUYỆN ĐỨC H&Ograve;A, LONG AN</span></span></td>
			<td><span style="font-size:10px"><span style="font-family:times new roman,times,serif">A.TRUNG</span></span></td>
		</tr>
		<tr>
			<td><span style="font-size:10px"><span style="font-family:times new roman,times,serif"><strong>4</strong></span></span></td>
			<td><span style="font-size:10px"><span style="font-family:times new roman,times,serif">C&Ocirc;NG TY TNHH PH&Uacute; THUẬN HƯNG</span></span></td>
			<td><span style="font-size:10px"><span style="font-family:times new roman,times,serif">L&Ocirc; 10-12 ĐƯỜNG AN HẠ KCN T&Acirc;N ĐỨC</span></span></td>
			<td><span style="font-size:10px"><span style="font-family:times new roman,times,serif">CHỊ BẢY</span></span></td>
		</tr>
		<tr>
			<td><span style="font-size:10px"><span style="font-family:times new roman,times,serif"><strong>5</strong></span></span></td>
			<td><span style="font-size:10px"><span style="font-family:times new roman,times,serif">C&Ocirc;NG TY TNHH DỆT NHUỘM T&Acirc;N ĐỨC KHANH</span></span></td>
			<td><span style="font-size:10px"><span style="font-family:times new roman,times,serif">L&Ocirc; I22-23-24A ĐƯỜNG SỐ 5 KCN T&Acirc;N ĐỨC LONG AN</span></span></td>
			<td><span style="font-size:10px"><span style="font-family:times new roman,times,serif">A.THỤY</span></span></td>
		</tr>
		<tr>
			<td><span style="font-size:10px"><span style="font-family:times new roman,times,serif"><strong>6</strong></span></span></td>
			<td><span style="font-size:10px"><span style="font-family:times new roman,times,serif">C&Ocirc;NG TY TNHH SX TM TRANG KIỂM</span></span></td>
			<td><span style="font-size:10px"><span style="font-family:times new roman,times,serif">223 M&Atilde; L&Ograve; B&Igrave;NH TRỊ Đ&Ocirc;NG A B&Igrave;NH T&Acirc;N TP.HCM</span></span></td>
			<td><span style="font-size:10px"><span style="font-family:times new roman,times,serif">CHỊ TRANG</span></span></td>
		</tr>
		<tr>
			<td><span style="font-size:10px"><span style="font-family:times new roman,times,serif"><strong>7</strong></span></span></td>
			<td><span style="font-size:10px"><span style="font-family:times new roman,times,serif">C&Ocirc;NG TY TNHH DT SX TM GIA ANH</span></span></td>
			<td><span style="font-size:10px"><span style="font-family:times new roman,times,serif">223 M&Atilde; L&Ograve; B&Igrave;NH TRỊ Đ&Ocirc;NG A B&Igrave;NH T&Acirc;N TP.HCM</span></span></td>
			<td><span style="font-size:10px"><span style="font-family:times new roman,times,serif">CHỊ HƯƠNG</span></span></td>
		</tr>
		<tr>
			<td><span style="font-size:10px"><span style="font-family:times new roman,times,serif"><strong>8</strong></span></span></td>
			<td><span style="font-size:10px"><span style="font-family:times new roman,times,serif">C&Ocirc;NG TY TNHH SX TM &nbsp;THI&Ecirc;N PH&Uacute; THỊNH</span></span></td>
			<td>
			<p><span style="font-size:10px"><span style="font-family:times new roman,times,serif">1/50 B1 KHU PHỐ 5 P.Đ&Ocirc;NG HƯNG THUẬN Q.12</span></span></p>
			</td>
			<td><span style="font-size:10px"><span style="font-family:times new roman,times,serif">A.DUY&Ecirc;N</span></span></td>
		</tr>
		<tr>
			<td><span style="font-size:10px"><span style="font-family:times new roman,times,serif"><strong>9</strong></span></span></td>
			<td><span style="font-size:10px"><span style="font-family:times new roman,times,serif">C&Ocirc;NG TY TNHH LONG VỸ</span></span></td>
			<td><span style="font-size:10px"><span style="font-family:times new roman,times,serif">7 PHAN VĂN HỚN T&Acirc;N THỚI NHẤT Q.12 TP.HCM</span></span></td>
			<td><span style="font-size:10px"><span style="font-family:times new roman,times,serif">A.CẦU</span></span></td>
		</tr>
		<tr>
			<td><span style="font-size:10px"><span style="font-family:times new roman,times,serif"><strong>10</strong></span></span></td>
			<td><span style="font-size:10px"><span style="font-family:times new roman,times,serif">C&Ocirc;NG TY TNHH MTV TM SX DỆT NHUỘM TH&Aacute;I TH&Agrave;NH</span></span></td>
			<td>
			<p><span style="font-size:10px"><span style="font-family:times new roman,times,serif">ẤP 3 X&Atilde; VĨNH LỘC A B&Igrave;NH CH&Aacute;NH TP.HCM</span></span></p>
			</td>
			<td><span style="font-size:10px"><span style="font-family:times new roman,times,serif">A.H&Ugrave;NG</span></span></td>
		</tr>
	</tbody>
</table>

<p>&nbsp;</p>

<p><span style="color:#FF8C00">►TỔNG QUAN VỀ PHẦN MỀM</span></p>

<p><span style="color:#FF8C00"><span style="font-family:arial,sans-serif; font-size:10pt">1.) KHO H&Oacute;A CHẤT</span></span></p>

<p><span style="color:#7C7C7C; font-family:arial,sans-serif; font-size:10.0pt">- Quản l&yacute; nhập kho h&oacute;a chất của từng nh&agrave; cung cấp.</span></p>

<p><span style="color:#FF8C00"><span style="font-family:arial,sans-serif; font-size:10pt">2.) PH&Ograve;NG TH&Iacute; NGHIỆM</span></span></p>

<p><span style="color:#7C7C7C; font-family:arial,sans-serif; font-size:10.0pt">- Quản l&yacute; c&ocirc;ng thức m&agrave;u của từng kh&aacute;ch h&agrave;ng</span></p>

<p><span style="color:#7C7C7C; font-family:arial,sans-serif; font-size:10.0pt">-T&iacute;nh chi ph&iacute; gi&aacute; gốc thực của từng c&ocirc;ng thức m&agrave;u</span></p>

<p><span style="color:#7C7C7C; font-family:arial,sans-serif; font-size:10.0pt">- Theo d&otilde;i năng suất l&agrave;m việc của từng nh&acirc;n vi&ecirc;n ph&ograve;ng th&iacute; nghiệm, mỗi nh&acirc;n vi&ecirc;n ph&ograve;ng th&iacute; nghiệm đều được cấp một t&agrave;i khoản l&agrave;m vi&ecirc;c hệ thống sẽ ghi nhận lại năng suất từng nh&acirc;n vi&ecirc;n th&ocirc;ng qua mẫu test v&agrave; qu&aacute; tr&igrave;nh nhuộm c&oacute; đạt y&ecirc;u cầu hay kh&ocirc;ng.</span></p>

<p><span style="color:#FF8C00"><span style="font-family:arial,sans-serif; font-size:10pt">3.) C&Ocirc;NG NGHỆ</span></span></p>

<p><span style="color:#7C7C7C; font-family:arial,sans-serif; font-size:10.0pt">- Tạo danh s&aacute;ch mẻ c&acirc;n thuốc của từng kh&aacute;ch h&agrave;ng.</span></p>

<p><span style="color:#7C7C7C; font-family:arial,sans-serif; font-size:10.0pt">-Theo d&otilde;i nhật k&yacute; c&acirc;n thuốc của từng nh&acirc;n vi&ecirc;n c&acirc;n số lượng thực tế bao nhi&ecirc;u, v&agrave;o thời điểm n&agrave;o hệ thống đều ghi nhận lại.</span></p>

<p><span style="color:#7C7C7C; font-family:arial,sans-serif; font-size:10.0pt">- Kiểm so&aacute;t mẻ n&agrave;o chưa c&acirc;n ho&agrave;n chỉnh đều được cảnh b&aacute;o tr&ecirc;n hệ thống phần mềm.</span></p>

<p><span style="color:#7C7C7C; font-family:arial,sans-serif; font-size:10.0pt">- Kiểm so&aacute;t phiếu ch&acirc;m chỉnh của từng mẻ</span></p>

<p><span style="color:#FF8C00"><span style="font-family:arial,sans-serif; font-size:10pt">4.) PH&Ograve;NG C&Acirc;N THUỐC</span></span></p>

<p><span style="color:#7C7C7C; font-family:arial,sans-serif; font-size:10.0pt">- Mỗi nh&acirc;n vi&ecirc;n ph&ograve;ng c&acirc;n thuốc được cấp một t&agrave;i khoản để đăng nhập v&agrave;o hệ thống c&acirc;n thuốc. Mẻ n&agrave;o nh&acirc;n vi&ecirc;n ca n&agrave;o c&acirc;n đều được ghi nhận lại tr&ecirc;n hệ thống, gi&uacute;p cho người qu&aacute;n l&yacute; c&oacute; cơ sở để nằm bắt qu&aacute; tr&igrave;nh c&acirc;n v&agrave; ghi nhận sai s&oacute;t của nh&acirc;n vi&ecirc;n.</span></p>

<p><span style="color:#7C7C7C; font-family:arial,sans-serif; font-size:10.0pt">- Hệ thống phần mềm hướng dẫn chi tiết cho nh&acirc;n vi&ecirc;n c&acirc;n thực hiện theo đ&uacute;ng số lượng y&ecirc;u cầu v&agrave; chỉ c&acirc;n số lượng trong phạm vi sai số cho ph&eacute;p theo qui định của ph&ograve;ng th&iacute; nghiệm.</span></p>

<p><span style="color:#FF8C00"><span style="font-family:arial,sans-serif; font-size:10pt">5.) KẾ TO&Aacute;N KHO</span></span></p>

<p><strong><span style="color:#7C7C7C">a.) T&iacute;nh năng</span></strong></p>

<p><span style="color:#7C7C7C; font-family:arial,sans-serif; font-size:10.0pt">- Theo d&otilde;i lượng nhập xuất tồn nhập kho h&oacute;a chất.</span></p>

<p><span style="color:#7C7C7C; font-family:arial,sans-serif; font-size:10.0pt">- Tổng kết chi ph&iacute; h&oacute;a chất sử dụng.</span></p>

<p><span style="color:#7C7C7C; font-family:arial,sans-serif; font-size:10.0pt">- Theo d&otilde;i c&ocirc;ng nợ c&aacute;c NCC</span></p>

<p><img alt="" src="/Upload/images/Icons/PDF_downlaod-2.png" style="height:24px; line-height:20.8px; width:24px" /><span style="color:rgb(169, 169, 169)">Download T&agrave;i Liệu Về Sản Phẩm</span></p>

<p><iframe frameborder="0" height="292" scrolling="no" src="https://www.facebook.com/plugins/page.php?href=https%3A%2F%2Fwww.facebook.com%2FBaoTinSoft%2F&amp;tabs=timeline&amp;width=340&amp;height=292&amp;small_header=false&amp;adapt_container_width=true&amp;hide_cover=false&amp;show_facepile=true&amp;appId" style="border:none;overflow:hidden" width="340"></iframe></p>

<hr />
<p><em><span style="color:rgb(69, 129, 142); font-family:arial,sans-serif; font-size:9pt">Rất mong được phục vụ qu&yacute; kh&aacute;ch h&agrave;ng !</span></em></p>

<p><span style="font-family:arial,sans-serif; font-size:9pt"><a href="http://baotinsoftware.com/lien-he.html" style="box-sizing: border-box; transition: 300ms;"><em><span style="color:rgb(69, 129, 142)">►Vui l&ograve;ng li&ecirc;n hệ với ch&uacute;ng t&ocirc;i&nbsp;</span></em></a></span></p>

<p><em><span style="color:rgb(69, 129, 142); font-family:arial,sans-serif; font-size:9pt">Tham khảo web:&nbsp;</span></em><span style="color:rgb(0, 153, 0); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span><em><span style="color:rgb(34, 34, 34); font-family:arial,sans-serif; font-size:9pt"><a href="http://baotinsoftware.com/" style="box-sizing: border-box; transition: 300ms;" target="_blank"><span style="color:rgb(246, 178, 107)">Http://baotinsoftware.com</span></a></span></em><span style="color:rgb(246, 178, 107); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span></p>

<p><em><span style="color:rgb(69, 129, 142); font-family:arial,sans-serif; font-size:9pt">Hoặc</span></em><span style="color:rgb(246, 178, 107); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span><em><span style="color:rgb(34, 34, 34); font-family:arial,sans-serif; font-size:9pt"><a href="http://baotinsoftware.com/" style="box-sizing: border-box; transition: 300ms;" target="_blank"><span style="color:rgb(246, 178, 107)">Http://baotinsoftware.com.vn</span></a></span></em></p>

<p><em><span style="color:rgb(69, 129, 142); font-family:arial,sans-serif; font-size:9pt">Email:</span></em><span style="color:rgb(0, 153, 0); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span><span style="color:rgb(204, 0, 0); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span><em><span style="color:rgb(61, 133, 198); font-family:arial,sans-serif; font-size:9pt"><a href="http://baotinsoftware.com/" style="box-sizing: border-box; transition: 300ms;" target="_blank"><span style="color:rgb(51, 122, 183)">baotinsoftware@gmail.com</span></a></span></em></p>

<p><em><span style="color:rgb(69, 129, 142); font-family:arial,sans-serif; font-size:9pt">Fanpage: </span><a href="https://www.facebook.com/search/top/?q=ph%E1%BA%A7n%20m%E1%BB%81m%20qu%E1%BA%A3n%20l%C3%BD%20nh%C3%A0%20m%C3%A1y%20d%E1%BB%87t%20-%20nhu%E1%BB%99m%20-%20s%E1%BB%A3i" target="_blank"><span style="color:rgb(61, 133, 198); font-family:arial,sans-serif; font-size:9pt"><span style="color:rgb(51, 122, 183)">fb.com/</span></span>phần mềm quản l&yacute; nh&agrave; m&aacute;y dệt - nhuộm - sợi</a></em></p>

<p><em><span style="color:rgb(11, 83, 148); font-family:arial,sans-serif; font-size:9pt">Phone / Zalo :&nbsp;</span>&nbsp;<span style="color:rgb(11, 83, 148); font-family:arial,sans-serif; font-size:9pt">0988 898996 Lộc</span></em></p>
', CAST(5000000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 5, CAST(N'2017-11-18 14:54:28.863' AS DateTime), 466, 0, 1, 1, 1, N'')
INSERT [dbo].[PRODUCTS] ([ID], [Code], [Name], [Tag], [Image], [Sapo], [Content], [Price], [PriceOld], [ID_GroupProduct], [DatePublish], [CountView], [CountBuy], [StatusID], [IsActive], [IsHot], [LinkY]) VALUES (18, N'SX170', N'Phần mềm quản lý mộc - Nhà máy nhuộm ( Full Option)', N'phan-mem-quan-ly-moc-nha-may-nhuom-full-option', N'/Upload/images/PM- QLMOC.jpg', N'', N'<table align="left" border="0.5" cellpadding="0.5" cellspacing="1" style="height:365px; width:763px">
	<caption>
	<p><img alt="" src="/Upload/images/Products/img_7-600x380.jpg" style="height:380px; width:600px" /></p>

	<p><span style="color:#FF8C00"><em>NHỮNG VẤN ĐỀ BẤT CẬP VẬN H&Agrave;NH QUẢN L&Yacute; CHO NH&Agrave; M&Aacute;Y NHUỘM:</em></span></p>

	<p style="text-align:left"><em>1.) Bạn quan t&acirc;m t&igrave;nh trạng nhập xuất kho mộc v&agrave; kho th&agrave;nh phẩm số liệu ch&iacute;nh x&aacute;c hay kh&ocirc;ng ? Thời gian đ&aacute;p ứng cho c&aacute;o nhập xuất tồn mất nhiều thời gian v&agrave; nh&acirc;n sự ?</em></p>

	<p style="text-align:left"><em>2.) Bạn cần quản l&yacute; t&igrave;nh trạng đơn đặt h&agrave;ng đ&aacute;p ứng cho kh&aacute;ch h&agrave;ng đ&uacute;ng tiến độ giao h&agrave;ng hoặc sai tiến độ như thế n&agrave;o ? H&agrave;ng h&oacute;a c&oacute; đủ đ&aacute;p ứng cho đơn đặt h&agrave;ng hay kh&ocirc;ng ?</em></p>

	<p style="text-align:left"><em>3.) Bạn cần theo d&otilde;i t&igrave;nh trạng h&agrave;ng h&oacute;a cụ thể như: đ&atilde; ph&acirc;n mẻ, sơ bộ, nhuộm, định h&igrave;nh&hellip; đang trong trạng th&aacute;i n&agrave;o ?</em></p>

	<p style="text-align:left"><em>4.) C&ocirc;ng nợ kh&aacute;ch h&agrave;ng bạn cần theo d&otilde;i hằng th&aacute;ng, qu&iacute;, năm, kết toa theo y&ecirc;u cầu của từng kh&aacute;ch ?</em></p>

	<p style="text-align:left"><em>5.) Bạn cần theo d&otilde;i v&agrave; nắm bắt lịch thanh to&aacute;n của từng kh&aacute;ch h&agrave;ng ?</em></p>

	<p style="text-align:left"><em>Ngo&agrave;i ra, c&ograve;n c&aacute;c yếu tố kh&aacute;ch quan kh&aacute;c nhau. H&atilde;y li&ecirc;n hệ ch&uacute;ng để được tư vấn g&oacute;i sản phẩm quản l&yacute; mộc, ch&uacute;ng t&ocirc;i gi&uacute;p bạn quản l&yacute; v&agrave; vận h&agrave;nh hệ thống một c&aacute;ch khoa học v&agrave; &aacute;p dụng qui tr&igrave;nh quản l&yacute; chặt chẽ v&agrave; hiệu quả bằng hệ thống phần mềm&hellip;.</em></p>

	<p><em><span style="color:#FFA500">DANH S&Aacute;CH MỘT SỐ KH&Aacute;CH H&Agrave;NG ĐIỂN H&Igrave;NH ĐANG ỨNG DỤNG HỆ THỐNG PHẦN MỀM QUẢN L&Yacute; MỘC CỦA BẢO T&Iacute;N</span></em></p>
	</caption>
	<tbody>
		<tr>
			<td style="text-align:center"><span style="color:#FF8C00"><span style="font-size:11px"><span style="font-family:georgia,serif">ST</span></span></span></td>
			<td style="text-align:center"><span style="color:#FF8C00"><span style="font-size:11px"><span style="font-family:georgia,serif">ĐƠN VỊ</span></span></span></td>
			<td style="text-align:center"><span style="color:#FF8C00"><span style="font-size:11px"><span style="font-family:georgia,serif">ĐỊA CHỈ</span></span></span></td>
			<td style="text-align:center"><span style="color:#FF8C00"><span style="font-size:11px"><span style="font-family:georgia,serif">LI&Ecirc;N HỆ</span></span></span></td>
		</tr>
		<tr>
			<td style="text-align:center"><span style="font-size:11px"><span style="color:rgb(218, 165, 32)"><span style="font-family:georgia,serif">1</span></span></span></td>
			<td>
			<p><span style="font-size:11px"><span style="font-family:tahoma,geneva,sans-serif">C&Ocirc;NG TY TNHH DỆT NHUỘM HƯNG PH&Aacute;T ĐẠT</span></span></p>
			</td>
			<td>
			<p><span style="font-size:11px"><span style="font-family:tahoma,geneva,sans-serif">HC 3 ĐƯỜNG SỐ 3 KCN XUY&Ecirc;N &Aacute; X&Atilde; MỸ HẠNH BẮC H.ĐỨC H&Ograve;A T.LONG AN</span></span></p>
			</td>
			<td><span style="font-size:11px"><span style="font-family:tahoma,geneva,sans-serif">A DUẨN</span></span></td>
		</tr>
		<tr>
			<td style="text-align:center"><span style="font-size:11px"><span style="color:rgb(218, 165, 32)"><span style="font-family:georgia,serif">2</span></span></span></td>
			<td><span style="font-size:11px"><span style="font-family:tahoma,geneva,sans-serif">C&Ocirc;NG TY TNHH SX TM DV SƠN TI&Ecirc;N</span></span></td>
			<td><span style="font-size:11px"><span style="font-family:tahoma,geneva,sans-serif">ĐƯỜNG SỐ 4 T&Acirc;N TẠO A B&Igrave;NH T&Acirc;N TP.HCM</span></span></td>
			<td><span style="font-size:11px"><span style="font-family:tahoma,geneva,sans-serif">A.TRUNG</span></span></td>
		</tr>
		<tr>
			<td style="text-align:center"><span style="font-size:11px"><span style="color:rgb(218, 165, 32)"><span style="font-family:georgia,serif">3</span></span></span></td>
			<td><span style="font-size:11px"><span style="font-family:tahoma,geneva,sans-serif">C&Ocirc;NG TY TNHH DỆT NHUỘM SƠN TI&Ecirc;N</span></span></td>
			<td><span style="font-size:11px"><span style="font-family:tahoma,geneva,sans-serif">L&Ocirc; A09-14 ĐƯỜNG SỐ 9 KCN HẢI SƠN X&Atilde; ĐỨC H&Ograve;A HẠ, HUYỆN ĐỨC H&Ograve;A, LONG AN</span></span></td>
			<td><span style="font-size:11px"><span style="font-family:tahoma,geneva,sans-serif">A.TRUNG</span></span></td>
		</tr>
		<tr>
			<td style="text-align:center"><span style="font-size:11px"><span style="color:rgb(218, 165, 32)"><span style="font-family:georgia,serif">4</span></span></span></td>
			<td><span style="font-size:11px"><span style="font-family:tahoma,geneva,sans-serif">C&Ocirc;NG TY TNHH PH&Uacute; THUẬN HƯNG</span></span></td>
			<td><span style="font-size:11px"><span style="font-family:tahoma,geneva,sans-serif">L&Ocirc; 10-12 ĐƯỜNG AN HẠ KCN T&Acirc;N ĐỨC</span></span></td>
			<td><span style="font-size:11px"><span style="font-family:tahoma,geneva,sans-serif">CHỊ BẢY</span></span></td>
		</tr>
		<tr>
			<td style="text-align:center"><span style="font-size:11px"><span style="color:rgb(218, 165, 32)"><span style="font-family:georgia,serif">5</span></span></span></td>
			<td><span style="font-size:11px"><span style="font-family:tahoma,geneva,sans-serif">C&Ocirc;NG TY TNHH DỆT NHUỘM T&Acirc;N ĐỨC KHANH</span></span></td>
			<td><span style="font-size:11px"><span style="font-family:tahoma,geneva,sans-serif">L&Ocirc; I22-23-24A ĐƯỜNG SỐ 5 KCN T&Acirc;N ĐỨC LONG AN</span></span></td>
			<td><span style="font-size:11px"><span style="font-family:tahoma,geneva,sans-serif">A.THỤY</span></span></td>
		</tr>
		<tr>
			<td style="text-align:center"><span style="font-size:11px"><span style="color:rgb(218, 165, 32)"><span style="font-family:georgia,serif">6</span></span></span></td>
			<td><span style="font-size:11px"><span style="font-family:tahoma,geneva,sans-serif">C&Ocirc;NG TY TNHH SX TM TRANG KIỂM</span></span></td>
			<td><span style="font-size:11px"><span style="font-family:tahoma,geneva,sans-serif">223 M&Atilde; L&Ograve; B&Igrave;NH TRỊ Đ&Ocirc;NG A B&Igrave;NH T&Acirc;N TP.HCM</span></span></td>
			<td><span style="font-size:11px"><span style="font-family:tahoma,geneva,sans-serif">CHỊ TRANG</span></span></td>
		</tr>
		<tr>
			<td style="text-align:center"><span style="font-size:11px"><span style="color:rgb(218, 165, 32)"><span style="font-family:georgia,serif">7</span></span></span></td>
			<td><span style="font-size:11px"><span style="font-family:tahoma,geneva,sans-serif">C&Ocirc;NG TY TNHH DT SX TM GIA ANH</span></span></td>
			<td><span style="font-size:11px"><span style="font-family:tahoma,geneva,sans-serif">223 M&Atilde; L&Ograve; B&Igrave;NH TRỊ Đ&Ocirc;NG A B&Igrave;NH T&Acirc;N TP.HCM</span></span></td>
			<td><span style="font-size:11px"><span style="font-family:tahoma,geneva,sans-serif">CHỊ HƯƠNG</span></span></td>
		</tr>
		<tr>
			<td style="text-align:center"><span style="font-size:11px"><span style="color:rgb(218, 165, 32)"><span style="font-family:georgia,serif">8</span></span></span></td>
			<td><span style="font-size:11px"><span style="font-family:tahoma,geneva,sans-serif">C&Ocirc;NG TY TNHH SX TM &nbsp;THI&Ecirc;N PH&Uacute; THỊNH</span></span></td>
			<td>
			<p><span style="font-size:11px"><span style="font-family:tahoma,geneva,sans-serif">1/50 B1 KHU PHỐ 5 P.Đ&Ocirc;NG HƯNG THUẬN Q.12</span></span></p>
			</td>
			<td><span style="font-size:11px"><span style="font-family:tahoma,geneva,sans-serif">A.DUY&Ecirc;N</span></span></td>
		</tr>
		<tr>
			<td style="text-align:center"><span style="font-size:11px"><span style="color:rgb(218, 165, 32)"><span style="font-family:georgia,serif">9</span></span></span></td>
			<td><span style="font-size:11px"><span style="font-family:tahoma,geneva,sans-serif">C&Ocirc;NG TY TNHH LONG VỸ</span></span></td>
			<td><span style="font-size:11px"><span style="font-family:tahoma,geneva,sans-serif">7 PHAN VĂN HỚN T&Acirc;N THỚI NHẤT Q.12 TP.HCM</span></span></td>
			<td><span style="font-size:11px"><span style="font-family:tahoma,geneva,sans-serif">A.CẦU</span></span></td>
		</tr>
		<tr>
			<td style="text-align:center"><span style="font-size:11px"><span style="color:rgb(218, 165, 32)"><span style="font-family:georgia,serif">10</span></span></span></td>
			<td><span style="font-size:11px"><span style="font-family:tahoma,geneva,sans-serif">C&Ocirc;NG TY TNHH MTV TM SX DỆT NHUỘM TH&Aacute;I TH&Agrave;NH</span></span></td>
			<td>
			<p><span style="font-size:11px"><span style="font-family:tahoma,geneva,sans-serif">ẤP 3 X&Atilde; VĨNH LỘC A B&Igrave;NH CH&Aacute;NH TP.HCM</span></span></p>
			</td>
			<td><span style="font-size:11px"><span style="font-family:tahoma,geneva,sans-serif">A.H&Ugrave;NG</span></span></td>
		</tr>
	</tbody>
</table>

<p>Phần mềm quản l&yacute; mộc được thiết kế phục vụ cho các doanh nghiệp nhuộm vải với mục ti&ecirc;u gi&uacute;p cho doanh nghiệp tiết kiệm chi ph&iacute;, hạn chế sai s&oacute;t, vận h&agrave;nh hệ thống một c&aacute;ch khoa học v&agrave; hiệu quả. Nh&acirc;n vi&ecirc;n kh&ocirc;ng cần am hi&ecirc;̉u nhiều về tin học m&agrave; vẫn c&oacute; thể sử dụng l&agrave;m chủ c&aacute;c c&ocirc;ng đoạn trong nh&agrave; m&aacute;y.</p>

<p><strong>5 ưu điểm của phần mềm gồm : </strong></p>

<p>&diams; Dễ sử dụng</p>

<p>&diams; Tiết kiệm nh&acirc;n sự</p>

<p>&diams; Hiệu quả c&ocirc;ng việc cao</p>

<p>&diams; T&iacute;nh năng bảo mật</p>

<p>&diams; T&iacute;nh năng mạnh mẻ.</p>

<p><strong>Ngo&agrave;i ra, ch&uacute;ng tối sẽ gi&uacute;p bạn kiểm so&aacute;t c&aacute;c bộ phận : </strong></p>

<p>► Kho mộc</p>

<p>► Đơn h&agrave;ng</p>

<p>► Quản l&yacute; sản xuất</p>

<p>► Kho th&agrave;nh phẩm</p>

<p>► Xuất h&agrave;ng</p>

<p><em><span style="color:#A9A9A9">Đ&Acirc;Y L&Agrave; SẢN PHẨM PHẦN MỀM CHUY&Ecirc;N DỤNG CHO NG&Agrave;NH NHUỘM VẢI VUI L&Ograve;NG LI&Ecirc;N HỆ VỚI CH&Uacute;NG T&Ocirc;I ĐỂ ĐƯỢC TƯ VẤN CHI TIẾT HƠN.</span></em></p>

<p><img alt="" src="/Upload/images/Icons/PDF_downlaod-2.png" style="height:24px; line-height:20.8px; width:24px" /><span style="color:rgb(169, 169, 169)">Download T&agrave;i Liệu Về Sản Phẩm</span></p>

<hr />
<p><em><span style="color:rgb(69, 129, 142); font-family:arial,sans-serif; font-size:9pt">Rất mong được phục vụ qu&yacute; kh&aacute;ch h&agrave;ng !</span></em></p>

<p><iframe frameborder="0" height="292" scrolling="no" src="https://www.facebook.com/plugins/page.php?href=https%3A%2F%2Fwww.facebook.com%2FBaoTinSoft%2F&amp;tabs=timeline&amp;width=340&amp;height=292&amp;small_header=false&amp;adapt_container_width=true&amp;hide_cover=false&amp;show_facepile=true&amp;appId" style="border:none;overflow:hidden" width="340"></iframe></p>

<p><span style="font-family:arial,sans-serif; font-size:9pt"><a href="http://baotinsoftware.com/lien-he.html" style="box-sizing: border-box; transition: 300ms;"><em><span style="color:rgb(69, 129, 142)">►Vui l&ograve;ng li&ecirc;n hệ với ch&uacute;ng t&ocirc;i&nbsp;</span></em></a></span></p>

<p><em><span style="color:rgb(69, 129, 142); font-family:arial,sans-serif; font-size:9pt">Tham khảo web:&nbsp;</span></em><span style="color:rgb(0, 153, 0); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span><em><span style="color:rgb(34, 34, 34); font-family:arial,sans-serif; font-size:9pt"><a href="http://baotinsoftware.com/" style="box-sizing: border-box; transition: 300ms;" target="_blank"><span style="color:rgb(246, 178, 107)">Http://baotinsoftware.com</span></a></span></em><span style="color:rgb(246, 178, 107); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span></p>

<p><em><span style="color:rgb(69, 129, 142); font-family:arial,sans-serif; font-size:9pt">Hoặc</span></em><span style="color:rgb(246, 178, 107); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span><em><span style="color:rgb(34, 34, 34); font-family:arial,sans-serif; font-size:9pt"><a href="http://baotinsoftware.com/" style="box-sizing: border-box; transition: 300ms;" target="_blank"><span style="color:rgb(246, 178, 107)">Http://baotinsoftware.com.vn</span></a></span></em></p>

<p><em><span style="color:rgb(69, 129, 142); font-family:arial,sans-serif; font-size:9pt">Email:</span></em><span style="color:rgb(0, 153, 0); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span><span style="color:rgb(204, 0, 0); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span><em><span style="color:rgb(61, 133, 198); font-family:arial,sans-serif; font-size:9pt"><a href="http://baotinsoftware.com/" style="box-sizing: border-box; transition: 300ms;" target="_blank"><span style="color:rgb(51, 122, 183)">baotinsoftware@gmail.com</span></a></span></em></p>

<p><em><span style="color:rgb(11, 83, 148); font-family:arial,sans-serif; font-size:9pt">Phone / Zalo :&nbsp;</span></em><em><span style="font-family:arial,sans-serif; font-size:10pt">&nbsp;</span><span style="color:rgb(11, 83, 148); font-family:arial,sans-serif; font-size:9pt">0988 898996 Lộc</span></em></p>
', CAST(5000000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 5, CAST(N'2017-11-18 14:55:51.547' AS DateTime), 586, 0, 1, 1, 1, N'')
INSERT [dbo].[PRODUCTS] ([ID], [Code], [Name], [Tag], [Image], [Sapo], [Content], [Price], [PriceOld], [ID_GroupProduct], [DatePublish], [CountView], [CountBuy], [StatusID], [IsActive], [IsHot], [LinkY]) VALUES (19, N'SX170', N'Hệ thống cân chất lỏng tự động - NoPump', N'he-thong-can-chat-long-tu-dong-nopump', N'/Upload/images/CWAUTO-3.jpg', N'<p>C&oacute; những thay đổi trong cuộc đời kh&ocirc;ng phải ai cũng sẽ nhận biết hết được. Bạn v&agrave; t&ocirc;i hoặc ai đ&oacute;, giữa ch&uacute;ng ta lu&ocirc;n c&oacute; một mối li&ecirc;n kết v&ocirc; h&igrave;nh đầy k&igrave; diệu khiến cho cuộc sống của mỗi người thật nhiều &yacute; nghĩa hơn.&nbsp;</p>
', N'<p><span style="color:#FF8C00">►T&Iacute;NH NĂNG SỬ DỤNG</span></p>

<p>-&nbsp;D&atilde;y h&oacute;a chất nằm gần nhau tiết kiệm kh&ocirc;ng gian mỗi th&ugrave;ng chứa khoảng 400~500lit h&oacute;a chất.<br />
- C&acirc;n ho&agrave;n to&agrave;n tự động li&ecirc;n tục v&agrave; đ&uacute;ng số lượng h&oacute;a chất được sử dụng, l&agrave;m giảm lỗi của con người v&agrave; l&atilde;nh ph&iacute; qu&aacute; mức.<br />
- Hệ thống phần mềm th&ocirc;ng b&aacute;o đầy đủ, nền tảng quản l&yacute; dễ d&agrave;ng v&agrave; tự động t&iacute;nh to&aacute;n c&ocirc;ng thức c&acirc;n.<br />
- Dễ d&agrave;ng hoạt động hệ thống c&oacute; t&iacute;ch hợp đầu đọc m&atilde; vạch, hoặc c&oacute; thể được nhập bằng phần mềm hỗ trợ con người trước khi về liều lượng.<br />
- Tủ điện ch&iacute;nh được l&agrave;m bằng Inox kh&ocirc;ng gỉ v&agrave; c&oacute; thể rửa được bằng nước.</p>

<p><span style="color:#FF8C00">►TH&Ocirc;NG SỐ KỸ THUẬT&nbsp;</span></p>

<table border="1" cellpadding="0" cellspacing="0">
	<tbody>
		<tr>
			<td style="width:33px">
			<p style="text-align:center"><strong>Stt</strong></p>
			</td>
			<td style="width:129px">
			<p style="text-align:center"><strong>T&ecirc;n thiết bị</strong></p>
			</td>
			<td style="width:59px">
			<p style="text-align:center"><strong>8 Th&ugrave;ng</strong></p>
			</td>
			<td style="width:72px">
			<p style="text-align:center"><strong>12 Th&ugrave;ng</strong></p>
			</td>
			<td style="width:78px">
			<p style="text-align:center"><strong>16 Th&ugrave;ng</strong></p>
			</td>
		</tr>
		<tr>
			<td style="width:33px">
			<p style="text-align:center">01</p>
			</td>
			<td style="width:129px">
			<p>Tủ điện ch&iacute;nh</p>
			</td>
			<td style="width:59px">
			<p style="text-align:center">1</p>
			</td>
			<td style="width:72px">
			<p style="text-align:center">1</p>
			</td>
			<td style="width:78px">
			<p style="text-align:center">1</p>
			</td>
		</tr>
		<tr>
			<td style="width:33px">
			<p style="text-align:center">02</p>
			</td>
			<td style="width:129px">
			<p>C&acirc;n điện tử</p>
			</td>
			<td style="width:59px">
			<p style="text-align:center">1</p>
			</td>
			<td style="width:72px">
			<p style="text-align:center">2</p>
			</td>
			<td style="width:78px">
			<p style="text-align:center">2</p>
			</td>
		</tr>
		<tr>
			<td style="width:33px">
			<p style="text-align:center">03</p>
			</td>
			<td style="width:129px">
			<p>Bước nhảy</p>
			</td>
			<td style="width:59px">
			<p style="text-align:center">&plusmn; 10g</p>
			</td>
			<td style="width:72px">
			<p style="text-align:center">&plusmn; 10g</p>
			</td>
			<td style="width:78px">
			<p style="text-align:center">&plusmn; 10g</p>
			</td>
		</tr>
		<tr>
			<td style="width:33px">
			<p style="text-align:center">04</p>
			</td>
			<td style="width:129px">
			<p>Tải c&acirc;n</p>
			</td>
			<td style="width:59px">
			<p style="text-align:center">60 kg</p>
			</td>
			<td style="width:72px">
			<p style="text-align:center">60 kg</p>
			</td>
			<td style="width:78px">
			<p style="text-align:center">60 kg</p>
			</td>
		</tr>
		<tr>
			<td style="width:33px">
			<p style="text-align:center">05</p>
			</td>
			<td style="width:129px">
			<p>Valve gi&oacute;</p>
			</td>
			<td style="width:59px">
			<p style="text-align:center">8</p>
			</td>
			<td style="width:72px">
			<p style="text-align:center">12</p>
			</td>
			<td style="width:78px">
			<p style="text-align:center">16</p>
			</td>
		</tr>
		<tr>
			<td style="width:33px">
			<p style="text-align:center">06</p>
			</td>
			<td style="width:129px">
			<p>Bơm m&agrave;ng</p>
			</td>
			<td style="width:59px">
			<p style="text-align:center">1</p>
			</td>
			<td style="width:72px">
			<p style="text-align:center">1</p>
			</td>
			<td style="width:78px">
			<p style="text-align:center">1</p>
			</td>
		</tr>
		<tr>
			<td style="width:33px">
			<p style="text-align:center">07</p>
			</td>
			<td style="width:129px">
			<p style="text-align:center">M&aacute;y t&iacute;nh c&ocirc;ng nghiệp</p>
			</td>
			<td style="width:59px">
			<p style="text-align:center">1</p>
			</td>
			<td style="width:72px">
			<p style="text-align:center">1</p>
			</td>
			<td style="width:78px">
			<p style="text-align:center">1</p>
			</td>
		</tr>
		<tr>
			<td style="width:33px">
			<p style="text-align:center">08</p>
			</td>
			<td style="width:129px">
			<p style="text-align:center">M&agrave;n h&igrave;nh P.O.S 15&rsquo;&rsquo;</p>
			</td>
			<td style="width:59px">
			<p style="text-align:center">1</p>
			</td>
			<td style="width:72px">
			<p style="text-align:center">1</p>
			</td>
			<td style="width:78px">
			<p style="text-align:center">1</p>
			</td>
		</tr>
		<tr>
			<td style="width:33px">
			<p style="text-align:center">09</p>
			</td>
			<td style="width:129px">
			<p>Printer</p>
			</td>
			<td style="width:59px">
			<p style="text-align:center">1</p>
			</td>
			<td style="width:72px">
			<p style="text-align:center">1</p>
			</td>
			<td style="width:78px">
			<p style="text-align:center">1</p>
			</td>
		</tr>
		<tr>
			<td style="width:33px">
			<p style="text-align:center">10</p>
			</td>
			<td style="width:129px">
			<p>M&aacute;y qu&eacute;t m&atilde; vạch</p>
			</td>
			<td style="width:59px">
			<p style="text-align:center">1</p>
			</td>
			<td style="width:72px">
			<p style="text-align:center">1</p>
			</td>
			<td style="width:78px">
			<p style="text-align:center">1</p>
			</td>
		</tr>
		<tr>
			<td style="width:33px">
			<p style="text-align:center">11</p>
			</td>
			<td style="width:129px">
			<p>&Aacute;p suất gi&oacute;</p>
			</td>
			<td colspan="3" style="width:209px">
			<p>&nbsp;Từ 4 ~ 6 kg/cm2</p>
			</td>
		</tr>
		<tr>
			<td style="width:33px">
			<p style="text-align:center">12</p>
			</td>
			<td style="width:129px">
			<p>Nguồn điện</p>
			</td>
			<td colspan="3" style="width:209px">
			<p>AC 220V 50/60Hz</p>
			</td>
		</tr>
		<tr>
			<td style="height:10px; width:33px">
			<p style="text-align:center">13</p>
			</td>
			<td style="height:10px; width:129px">
			<p>Trạm cấp h&oacute;a chất</p>
			</td>
			<td colspan="3" style="height:10px; width:209px">
			<p>Cao 3 met gi&agrave;n khung sắt, c&oacute; lang cang h&agrave;nh lang đi lại.</p>
			</td>
		</tr>
		<tr>
			<td style="width:33px">
			<p style="text-align:center">14</p>
			</td>
			<td style="width:129px">
			<p>Diện t&iacute;ch lắp đặt</p>
			</td>
			<td colspan="3" style="width:209px">
			<p>Lắp đặt 16 th&ugrave;ng diện t&iacute;ch 4 x 5 met</p>
			</td>
		</tr>
	</tbody>
</table>

<p>&nbsp;</p>

<p><span style="color:#FF8C00">►SO S&Aacute;NH HT C&Acirc;N CHẤT LỎNG SỬ DỤNG PUMP V&Agrave; KH&Ocirc;NG SỬ DỤNG PUMP</span></p>

<table border="1" cellpadding="0" cellspacing="0" style="width:500px">
	<tbody>
		<tr>
			<td style="height:24px; width:30px">
			<p style="text-align:center"><strong>Stt</strong></p>
			</td>
			<td style="height:24px; width:138px">
			<p style="text-align:center"><strong>Th&agrave;nh phần</strong></p>
			</td>
			<td style="height:24px; width:288px">
			<p style="text-align:center"><span style="color:rgb(255, 140, 0)">►Sử dụng Bơm</span></p>
			</td>
			<td style="height:24px; width:312px">
			<p style="text-align:center"><span style="color:#FF8C00">►Kh&ocirc;ng sử dụng Bơm</span></p>
			</td>
		</tr>
		<tr>
			<td style="height:24px; width:30px">
			<p style="text-align:center">01</p>
			</td>
			<td style="height:24px; width:138px">
			<p>Gi&aacute; th&agrave;nh</p>
			</td>
			<td style="height:24px; width:288px">
			<p>Chi ph&iacute; cao</p>
			</td>
			<td style="height:24px; width:312px">
			<p>Tiết kiệm hơn 30% chi ph&iacute;</p>
			</td>
		</tr>
		<tr>
			<td style="height:24px; width:30px">
			<p style="text-align:center">02</p>
			</td>
			<td style="height:24px; width:138px">
			<p>Ch&iacute;nh x&aacute;c</p>
			</td>
			<td style="height:24px; width:288px">
			<p>Sai số 1% đến 3% cho ph&eacute;p</p>
			</td>
			<td style="height:24px; width:312px">
			<p>Sai số 1% đến 3% cho ph&eacute;p</p>
			</td>
		</tr>
		<tr>
			<td style="height:24px; width:30px">
			<p style="text-align:center">03</p>
			</td>
			<td style="height:24px; width:138px">
			<p>Thời gian c&acirc;n</p>
			</td>
			<td style="height:24px; width:288px">
			<p style="text-align:center">Nhanh:</p>

			<p>C&acirc;n 2kg h&oacute;a chất mất 10 gi&acirc;y</p>
			</td>
			<td style="height:24px; width:312px">
			<p style="text-align:center">Tương đối:</p>

			<p>C&acirc;n 2 kg h&oacute;a chất mất 15 gi&acirc;y.</p>
			</td>
		</tr>
		<tr>
			<td style="height:24px; width:30px">
			<p style="text-align:center">04</p>
			</td>
			<td style="height:24px; width:138px">
			<p>Năng động</p>
			</td>
			<td style="height:24px; width:288px">
			<p>Sử dụng th&ugrave;ng chứa mặc định của nh&agrave; sản, c&oacute; thể thay thế liền th&ugrave;ng mới khi hết h&oacute;a chất.</p>
			</td>
			<td style="height:24px; width:312px">
			<p>Sử dụng th&ugrave;ng lớn từ 500lit v&agrave; đặt cố định. Tốn kh&ocirc;ng gian lắp đặt</p>
			</td>
		</tr>
		<tr>
			<td style="height:24px; width:30px">
			<p style="text-align:center">05</p>
			</td>
			<td style="height:24px; width:138px">
			<p>Mặt bằng</p>
			</td>
			<td style="height:24px; width:288px">
			<p>Mặt bằng 3 x 5 met sử dụng được 16 loại h&oacute;a chất kh&aacute;c nhau.</p>
			</td>
			<td style="height:24px; width:312px">
			<p>Mặt bằng lắp đặt&nbsp;4 x 5 met v&agrave; cao tối thiểu 3 met so với mặt</p>

			<p>đất.</p>
			</td>
		</tr>
		<tr>
			<td style="height:24px; width:30px">
			<p style="text-align:center">06</p>
			</td>
			<td style="height:24px; width:138px">
			<p>Phần mềm</p>
			</td>
			<td style="height:24px; width:288px">
			<p>Giao tiếp với PLC v&agrave; Bơm</p>
			</td>
			<td style="height:24px; width:312px">
			<p>Giao tiếp với PLC.</p>
			</td>
		</tr>
	</tbody>
</table>

<p><strong><em>►&nbsp;</em></strong>G&oacute;i sản phẩm li&ecirc;n kết :</p>

<p><em>&rArr;</em><em>&nbsp;&nbsp;<a href="http://baotinsoftware.com/san-pham/chuyen-dung-cho-nha-may-nhuom-5/phan-mem-quan-ly-moc-nha-may-nhuom-18.html" style="box-sizing: border-box; color: rgb(51, 122, 183); text-decoration: none; transition: 300ms; background-color: transparent;">Phần mềm quản l&yacute; mộc</a></em></p>

<p><em>&rArr;</em><em>&nbsp;&nbsp;<a href="http://baotinsoftware.com/san-pham/chuyen-dung-cho-nha-may-det-7/phan-mem-quan-ly-det-nha-may-det-14.html" style="box-sizing: border-box; color: rgb(51, 122, 183); text-decoration: none; transition: 300ms; background-color: transparent;">Phần mềm quản l&yacute; dệt</a></em></p>

<p><img alt="" src="/Upload/images/Icons/PDF_downlaod-2.png" style="height:24px; line-height:20.8px; width:24px" /><span style="color:rgb(169, 169, 169)">Download T&agrave;i Liệu Về Sản Phẩm</span></p>

<hr />
<p><em><span style="color:rgb(69, 129, 142); font-family:arial,sans-serif; font-size:9pt">Rất mong được phục vụ qu&yacute; kh&aacute;ch h&agrave;ng !</span></em></p>

<p><iframe frameborder="0" height="292" scrolling="no" src="https://www.facebook.com/plugins/page.php?href=https%3A%2F%2Fwww.facebook.com%2FBaoTinSoft%2F&amp;tabs=timeline&amp;width=340&amp;height=292&amp;small_header=false&amp;adapt_container_width=true&amp;hide_cover=false&amp;show_facepile=true&amp;appId" style="border:none;overflow:hidden" width="340"></iframe></p>

<p><span style="font-family:arial,sans-serif; font-size:9pt"><a href="http://baotinsoftware.com/lien-he.html" style="box-sizing: border-box; transition: 300ms;"><em><span style="color:rgb(69, 129, 142)">►Vui l&ograve;ng li&ecirc;n hệ với ch&uacute;ng t&ocirc;i&nbsp;</span></em></a></span></p>

<p><em><span style="color:rgb(69, 129, 142); font-family:arial,sans-serif; font-size:9pt">Tham khảo web:&nbsp;</span></em><span style="color:rgb(0, 153, 0); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span><em><span style="color:rgb(34, 34, 34); font-family:arial,sans-serif; font-size:9pt"><a href="http://baotinsoftware.com/" style="box-sizing: border-box; transition: 300ms;" target="_blank"><span style="color:rgb(246, 178, 107)">Http://baotinsoftware.com</span></a></span></em><span style="color:rgb(246, 178, 107); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span></p>

<p><em><span style="color:rgb(69, 129, 142); font-family:arial,sans-serif; font-size:9pt">Hoặc</span></em><span style="color:rgb(246, 178, 107); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span><em><span style="color:rgb(34, 34, 34); font-family:arial,sans-serif; font-size:9pt"><a href="http://baotinsoftware.com/" style="box-sizing: border-box; transition: 300ms;" target="_blank"><span style="color:rgb(246, 178, 107)">Http://baotinsoftware.com.vn</span></a></span></em></p>

<p><em><span style="color:rgb(69, 129, 142); font-family:arial,sans-serif; font-size:9pt">Email:</span></em><span style="color:rgb(0, 153, 0); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span><span style="color:rgb(204, 0, 0); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span><em><span style="color:rgb(61, 133, 198); font-family:arial,sans-serif; font-size:9pt"><a href="http://baotinsoftware.com/" style="box-sizing: border-box; transition: 300ms;" target="_blank"><span style="color:rgb(51, 122, 183)">baotinsoftware@gmail.com</span></a></span></em></p>

<p><em><span style="color:rgb(11, 83, 148); font-family:arial,sans-serif; font-size:9pt">Phone / Zalo :&nbsp;</span>&nbsp;<span style="color:rgb(11, 83, 148); font-family:arial,sans-serif; font-size:9pt">0988 898996 Lộc</span></em></p>
', CAST(5000000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 10, CAST(N'2017-11-18 15:17:40.313' AS DateTime), 384, 0, 1, 1, 1, N'')
INSERT [dbo].[PRODUCTS] ([ID], [Code], [Name], [Tag], [Image], [Sapo], [Content], [Price], [PriceOld], [ID_GroupProduct], [DatePublish], [CountView], [CountBuy], [StatusID], [IsActive], [IsHot], [LinkY]) VALUES (20, N'SX170', N'Hệ thống cân chất lỏng tự động - AutoPump', N'he-thong-can-chat-long-tu-dong-autopump', N'/Upload/images/CWAUTO-3.jpg', N'►Đ&Ocirc;I N&Eacute;T VỀ HỆ THỐNG C&Acirc;N CHẤT LỎNG TỰ ĐỘNG

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Hệ thống c&acirc;n chất lỏng tự động cho ph&eacute;p nhập c&aacute;c c&ocirc;ng thức v&agrave; dung tỷ v&agrave;o m&aacute;y t&iacute;nh để tự động t&iacute;nh to&aacute;n c&aacute;c c&ocirc;ng thức c&acirc;n cho từng mẻ nhuộm. Sau đ&oacute;, hệ thống sẽ k&iacute;ch hoạt c&aacute;c m&aacute;y bơm m&agrave;ng để chuyển h&oacute;a chất v&agrave;o c&aacute;c th&ugrave;ng chứa h&oacute;a chất th&ocirc;ng qua c&aacute;c m&aacute;y t&iacute;nh v&agrave; PLC điều khiển sử dụng c&acirc;n điện tử điều chỉnh về liều lượng chất lỏng ch&iacute;nh x&aacute;c. Trọng lượng của c&aacute;c h&oacute;a chất n&agrave;y c&oacute; thể in v&agrave; c&oacute;&nbsp; ghi lại th&ocirc;ng tin phản hồi cho quản l&yacute; h&agrave;ng tồn kho.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Hệ thống n&agrave;y c&oacute; thể cho ph&eacute;p c&aacute;c nh&agrave; m&aacute;y nhuộm để tập trung quản l&yacute; h&oacute;a chất v&agrave; tăng năng suất c&ocirc;ng việc.', N'<p><span style="color:rgb(255, 140, 0)">►Đ&Ocirc;I N&Eacute;T VỀ HỆ THỐNG C&Acirc;N CHẤT LỎNG TỰ ĐỘNG</span></p>

<p>&nbsp; &nbsp; &nbsp;<span style="font-family:arial,sans-serif; font-size:10pt">&nbsp;&nbsp;</span><span style="color:rgb(124, 124, 124); font-family:arial,sans-serif; font-size:9pt">- Hệ thống c&acirc;n chất lỏng tự động cho ph&eacute;p nhập c&aacute;c c&ocirc;ng thức v&agrave; dung tỷ v&agrave;o m&aacute;y t&iacute;nh để tự động t&iacute;nh to&aacute;n c&aacute;c c&ocirc;ng thức c&acirc;n cho từng mẻ nhuộm. Sau đ&oacute;, hệ thống sẽ k&iacute;ch hoạt c&aacute;c m&aacute;y bơm m&agrave;ng để chuyển h&oacute;a chất v&agrave;o c&aacute;c th&ugrave;ng chứa h&oacute;a chất th&ocirc;ng qua c&aacute;c m&aacute;y t&iacute;nh v&agrave; PLC điều khiển sử dụng c&acirc;n điện tử điều chỉnh về liều lượng chất lỏng ch&iacute;nh x&aacute;c. Trọng lượng của c&aacute;c h&oacute;a chất n&agrave;y c&oacute; thể in v&agrave; c&oacute;&nbsp; ghi lại th&ocirc;ng tin phản hồi cho quản l&yacute; h&agrave;ng tồn kho.</span></p>

<p><span style="color:rgb(124, 124, 124); font-family:arial,sans-serif; font-size:9pt">&nbsp; &nbsp; &nbsp; - Hệ thống n&agrave;y c&oacute; thể cho ph&eacute;p c&aacute;c nh&agrave; m&aacute;y nhuộm để tập trung quản l&yacute; h&oacute;a chất v&agrave; tăng năng suất c&ocirc;ng việc.</span></p>

<p><img alt="" src="/Upload/images/CWAUTO-1.jpg" style="height:150px; width:300px" /></p>

<p><span style="color:#FF8C00">►C&Aacute;C T&Iacute;NH NĂNG CH&Iacute;NH</span></p>

<p><span style="color:rgb(124, 124, 124); font-size:9pt">&nbsp;</span><span style="color:rgb(124, 124, 124); font-family:arial,sans-serif; font-size:9pt">- Sử dụng c&acirc;n điện tử để tăng độ ch&iacute;nh x&aacute;c liều lượng h&oacute;a chất, sai số cho ph&eacute;p của từng chất&nbsp; trong khoảng 1~3 %.</span></p>

<p><span style="color:rgb(124, 124, 124); font-family:arial,sans-serif; font-size:9pt">&nbsp;- D&atilde;y h&oacute;a chất nằm gần nhau tiết kiệm kh&ocirc;ng gian v&agrave; dễ d&agrave;ng thay thế.</span></p>

<p><span style="color:rgb(124, 124, 124); font-family:arial,sans-serif; font-size:9pt">&nbsp;- Mỗi d&atilde;i h&oacute;a chất duy nhất c&oacute; thể kiểm so&aacute;t 6 - 8 loại h&oacute;a chất.</span></p>

<p><span style="color:rgb(124, 124, 124); font-family:arial,sans-serif; font-size:9pt">&nbsp;- C&acirc;n ho&agrave;n to&agrave;n tự động li&ecirc;n tục v&agrave; đ&uacute;ng số lượng h&oacute;a chất được sử dụng, l&agrave;m giảm lỗi của con người v&agrave; l&atilde;nh ph&iacute; qu&aacute; mức.</span></p>

<p><span style="color:rgb(124, 124, 124); font-family:arial,sans-serif; font-size:9pt">&nbsp;- Hệ thống th&ocirc;ng b&aacute;o đầy đủ, nền tảng quản l&yacute; dễ d&agrave;ng v&agrave; tự động t&iacute;nh to&aacute;n c&ocirc;ng thức .</span></p>

<p><span style="color:rgb(124, 124, 124); font-family:arial,sans-serif; font-size:9pt">&nbsp;- Tủ điện ch&iacute;nh được l&agrave;m bằng Inox&nbsp; 304 kh&ocirc;ng rỉ v&agrave; c&oacute; thể rửa được bằng nước.</span></p>

<p><span style="color:rgb(124, 124, 124); font-family:arial,sans-serif; font-size:9pt">&nbsp;- Xử dụng m&agrave;n h&igrave;nh cảm ứng gi&uacute;p c&ocirc;ng nh&acirc;n thao t&aacute;c dễ d&agrave;ng.</span></p>

<p><span style="color:#FF8C00">►PHẦN MỀM</span></p>

<p><span style="color:rgb(124, 124, 124); font-family:arial,sans-serif; font-size:9pt">- Giao diện người d&ugrave;ng th&acirc;n thiện về đồ họa cho hoạt động dễ d&agrave;ng, sử dụng m&agrave;n h&igrave;nh cảm ứng gi&uacute;p thao t&aacute;c đơn giản tr&ecirc;n phần mềm.</span></p>

<p><span style="color:rgb(124, 124, 124); font-family:arial,sans-serif; font-size:9pt">- Phần mềm được t&iacute;ch hợp với hệ thống đầu đọc m&atilde; vạch.</span></p>

<p><span style="color:rgb(124, 124, 124); font-family:arial,sans-serif; font-size:9pt">- C&oacute; thể t&ugrave;y chọn li&ecirc;n kết với hệ thống quản l&yacute; c&ocirc;ng việc đang hiện h&agrave;nh tại nh&agrave; m&aacute;y.</span></p>

<p><span style="color:rgb(124, 124, 124); font-family:arial,sans-serif; font-size:9pt">- Lịch sử c&acirc;n được ghi lại tr&ecirc;n hệ thống m&aacute;y chủ, gi&uacute;p cho người quản l&yacute; nắm bắt th&ocirc;ng tin chi tiết từng phiếu c&acirc;n.</span></p>

<p><span style="color:rgb(124, 124, 124); font-family:arial,sans-serif; font-size:9pt">- H&oacute;a chất đầu v&agrave;o ngay được kiểm so&aacute;t bằng hệ thống nhập kho phần mềm.</span></p>

<p><span style="color:rgb(124, 124, 124); font-family:arial,sans-serif; font-size:9pt">- Phần mềm hỗ trợ người quản l&yacute; kiểm so&aacute;t danh s&aacute;ch phiếu chưa c&acirc;n ho&agrave;n chỉnh của từng mẻ.</span></p>

<table border="1" cellpadding="1" cellspacing="1" style="width:400px">
	<caption><span style="color:#FF8C00">►ĐẶT T&Iacute;NH KỸ THUẬT</span></caption>
	<tbody>
		<tr>
			<td><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif"><strong>Stt</strong></span></span></td>
			<td><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif"><strong>T&ecirc;n thiết bị</strong></span></span></td>
			<td style="text-align:center"><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif"><strong>8 Th&ugrave;ng</strong></span></span></td>
			<td style="text-align:center"><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif"><strong>12 Th&ugrave;ng</strong></span></span></td>
			<td style="text-align:center"><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif"><strong>16 Th&ugrave;ng</strong></span></span></td>
		</tr>
		<tr>
			<td><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">01</span></span></td>
			<td><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">Tủ điện ch&iacute;nh</span></span></td>
			<td style="text-align:center"><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">1</span></span></td>
			<td style="text-align:center"><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">1</span></span></td>
			<td style="text-align:center"><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">1</span></span></td>
		</tr>
		<tr>
			<td><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">02</span></span></td>
			<td><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">C&acirc;n điện tử</span></span></td>
			<td style="text-align:center"><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">1</span></span></td>
			<td style="text-align:center"><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">2</span></span></td>
			<td style="text-align:center"><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">2</span></span></td>
		</tr>
		<tr>
			<td><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">03</span></span></td>
			<td><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">Bước nhảy c&acirc;n</span></span></td>
			<td style="text-align:center"><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">5 gram</span></span></td>
			<td style="text-align:center"><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">5 gram</span></span></td>
			<td style="text-align:center"><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">5 gram</span></span></td>
		</tr>
		<tr>
			<td><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">04</span></span></td>
			<td><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">Tải c&acirc;n</span></span></td>
			<td style="text-align:center"><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">30 kg</span></span></td>
			<td style="text-align:center"><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">30 kg</span></span></td>
			<td style="text-align:center"><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">30 kg</span></span></td>
		</tr>
		<tr>
			<td><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">05</span></span></td>
			<td><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">Valve gi&oacute;</span></span></td>
			<td style="text-align:center"><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">8</span></span></td>
			<td style="text-align:center"><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">12</span></span></td>
			<td style="text-align:center"><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">16</span></span></td>
		</tr>
		<tr>
			<td><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">06</span></span></td>
			<td><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">Bơm m&agrave;n</span></span></td>
			<td style="text-align:center"><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">8</span></span></td>
			<td style="text-align:center"><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">12</span></span></td>
			<td style="text-align:center"><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">16</span></span></td>
		</tr>
		<tr>
			<td><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">07</span></span></td>
			<td><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">M&aacute;y t&iacute;nh c&ocirc;ng nghiệp</span></span></td>
			<td style="text-align:center"><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">1</span></span></td>
			<td style="text-align:center"><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">1</span></span></td>
			<td style="text-align:center"><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">1</span></span></td>
		</tr>
		<tr>
			<td><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">08</span></span></td>
			<td><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">M&agrave;n h&igrave;nh cảm ứng</span></span></td>
			<td style="text-align:center"><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">1</span></span></td>
			<td style="text-align:center"><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">1</span></span></td>
			<td style="text-align:center"><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">1</span></span></td>
		</tr>
		<tr>
			<td><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">09</span></span></td>
			<td><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">Thiết bị đọc m&atilde; vạch</span></span></td>
			<td style="text-align:center"><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">1</span></span></td>
			<td style="text-align:center"><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">1</span></span></td>
			<td style="text-align:center"><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">1</span></span></td>
		</tr>
		<tr>
			<td><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">10</span></span></td>
			<td><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">Khối lượng c&acirc;n&nbsp;</span></span></td>
			<td colspan="3" rowspan="1" style="text-align:center">
			<p><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">C&acirc;n tối thiểu : 250 gram</span></span></p>

			<p><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">C&acirc;n tối đa : 20 kg đến 60 kg</span></span></p>
			</td>
		</tr>
		<tr>
			<td><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">11</span></span></td>
			<td><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">Sai số đ&aacute;p ứng</span></span></td>
			<td colspan="3" rowspan="1" style="text-align:center"><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">1% ~ 3 %</span></span></td>
		</tr>
		<tr>
			<td><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">12</span></span></td>
			<td><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">&Aacute;p suất gi&oacute;</span></span></td>
			<td><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">4 ~ 6 kg/cm2</span></span></td>
			<td><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">4 ~ 6 kg/cm2</span></span></td>
			<td><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">4 ~ 6 kg/cm2</span></span></td>
		</tr>
		<tr>
			<td><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">13</span></span></td>
			<td><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">Nguồn điện ch&iacute;nh</span></span></td>
			<td colspan="3" rowspan="1"><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">AC 220V 50/60Hz</span></span></td>
		</tr>
		<tr>
			<td><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">14</span></span></td>
			<td><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">Diện t&iacute;ch lắp đặt</span></span></td>
			<td colspan="3" rowspan="1"><span style="font-size:10px"><span style="font-family:tahoma,geneva,sans-serif">Diện t&iacute;ch lắp đặt 2 x 5 met</span></span></td>
		</tr>
	</tbody>
</table>

<p><strong><em>►&nbsp;</em></strong>G&oacute;i sản phẩm li&ecirc;n kết :</p>

<p><em>&rArr;</em><em>&nbsp;&nbsp;<a href="http://baotinsoftware.com/san-pham/chuyen-dung-cho-nha-may-nhuom-5/phan-mem-quan-ly-moc-nha-may-nhuom-18.html" style="box-sizing: border-box; color: rgb(51, 122, 183); text-decoration: none; transition: 300ms; background-color: transparent;">Phần mềm quản l&yacute; mộc</a></em></p>

<p><em>&rArr;</em><em>&nbsp;&nbsp;<a href="http://baotinsoftware.com/san-pham/chuyen-dung-cho-nha-may-det-7/phan-mem-quan-ly-det-nha-may-det-14.html" style="box-sizing: border-box; color: rgb(51, 122, 183); text-decoration: none; transition: 300ms; background-color: transparent;">Phần mềm quản l&yacute; dệt</a></em></p>

<p><a href="/Upload/images/Documents/CWAuto-Pump.pdf" style="line-height: 1.6;"><span style="font-size:15.3333px"><img alt="" src="/Upload/images/Icons/PDF_downlaod-2.png" style="height:24px; width:24px" />Donwload t&agrave;i liệu về sản phẩm</span></a></p>

<hr />
<p><em><span style="color:rgb(69, 129, 142); font-family:arial,sans-serif; font-size:9pt">Rất mong được phục vụ qu&yacute; kh&aacute;ch h&agrave;ng !</span></em></p>

<p><iframe frameborder="0" height="292" scrolling="no" src="https://www.facebook.com/plugins/page.php?href=https%3A%2F%2Fwww.facebook.com%2FBaoTinSoft%2F&amp;tabs=timeline&amp;width=340&amp;height=292&amp;small_header=false&amp;adapt_container_width=true&amp;hide_cover=false&amp;show_facepile=true&amp;appId" style="border:none;overflow:hidden" width="340"></iframe></p>

<p><span style="font-family:arial,sans-serif; font-size:9pt"><a href="http://baotinsoftware.com/lien-he.html" style="box-sizing: border-box; transition: 300ms;"><em><span style="color:rgb(69, 129, 142)">►Vui l&ograve;ng li&ecirc;n hệ với ch&uacute;ng t&ocirc;i&nbsp;</span></em></a></span></p>

<p><em><span style="color:rgb(69, 129, 142); font-family:arial,sans-serif; font-size:9pt">Tham khảo web:&nbsp;</span></em><span style="color:rgb(0, 153, 0); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span><em><span style="color:rgb(34, 34, 34); font-family:arial,sans-serif; font-size:9pt"><a href="http://baotinsoftware.com/" style="box-sizing: border-box; transition: 300ms;" target="_blank"><span style="color:rgb(246, 178, 107)">Http://baotinsoftware.com</span></a></span></em><span style="color:rgb(246, 178, 107); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span></p>

<p><em><span style="color:rgb(69, 129, 142); font-family:arial,sans-serif; font-size:9pt">Hoặc</span></em><span style="color:rgb(246, 178, 107); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span><em><span style="color:rgb(34, 34, 34); font-family:arial,sans-serif; font-size:9pt"><a href="http://baotinsoftware.com/" style="box-sizing: border-box; transition: 300ms;" target="_blank"><span style="color:rgb(246, 178, 107)">Http://baotinsoftware.com.vn</span></a></span></em></p>

<p><em><span style="color:rgb(69, 129, 142); font-family:arial,sans-serif; font-size:9pt">Email:</span></em><span style="color:rgb(0, 153, 0); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span><span style="color:rgb(204, 0, 0); font-family:arial,sans-serif; font-size:9pt">&nbsp;</span><em><span style="color:rgb(61, 133, 198); font-family:arial,sans-serif; font-size:9pt"><a href="http://baotinsoftware.com/" style="box-sizing: border-box; transition: 300ms;" target="_blank"><span style="color:rgb(51, 122, 183)">baotinsoftware@gmail.com</span></a></span></em></p>

<p><em><span style="color:rgb(11, 83, 148); font-family:arial,sans-serif; font-size:9pt">Phone / Zalo :&nbsp;</span></em><em><span style="font-family:arial,sans-serif; font-size:10pt">&nbsp;</span><span style="color:#0B5394; font-family:arial,sans-serif; font-size:9.0pt">0988 898996 Lộc</span></em></p>
', CAST(5000000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 8, CAST(N'2017-11-18 15:14:42.597' AS DateTime), 468, 0, 1, 1, 1, N'https://www.youtube.com/embed/fb5xSzuEEsg')
INSERT [dbo].[PRODUCTS] ([ID], [Code], [Name], [Tag], [Image], [Sapo], [Content], [Price], [PriceOld], [ID_GroupProduct], [DatePublish], [CountView], [CountBuy], [StatusID], [IsActive], [IsHot], [LinkY]) VALUES (21, N'ABC XYZ', N'Abc NAPAS', N'abc-napas', N'', N'Abcyxz', N'<p>Abcyxz</p>
', CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 5, CAST(N'2017-11-26 22:45:31.433' AS DateTime), 1, 0, 2, 0, 0, N'#')
SET IDENTITY_INSERT [dbo].[PRODUCTS] OFF
SET IDENTITY_INSERT [dbo].[SERVICES] ON 

INSERT [dbo].[SERVICES] ([ID], [Title], [Tag], [Sub], [Image], [Content], [IsHot], [TotalView], [Date], [ID_UserPost], [Active], [ID_GroupServices]) VALUES (2, N'Feasibility Studies & Investment Decision-Making', N'feasibility-studies-investment-decisionmaking', N'<p>NSO will work with you to provide all the necessary assistance and resources you need to do the best and most realistic feasibility studies with access to the best sources of data and information available.</p>
', N'/Upload/images/Services/fast-1.jpg', N'<p style="text-align: center;"><img alt="" class="border-image" src="/Upload/images/Services/f1_600x380.jpg" /></p>

<p>NSO will work with you to provide all the necessary assistance and resources you need to do the best and most realistic feasibility studies with access to the best sources of data and information available.&nbsp; We can assist you in setting up meetings with relevant people, authorities, institutions, associations or companies of your choice that you feel are necessary to obtain the best possible tangible and intangible inputs.&nbsp; In addition, NSO premises are available for your feasibility study teams and your project teams to avail of all the resources and convenience of a fully-set up office on short-term or temporary basis.</p>
', 0, 1, CAST(N'2015-09-13 00:00:00.000' AS DateTime), 2, 1, 2)
INSERT [dbo].[SERVICES] ([ID], [Title], [Tag], [Sub], [Image], [Content], [IsHot], [TotalView], [Date], [ID_UserPost], [Active], [ID_GroupServices]) VALUES (3, N'Site and Property Selection', N'site-and-property-selection', N'<p>In any investment or expansion decision requiring new facilities, one of the most crucial decisions is about the choice of location.</p>
', N'/Upload/images/Services/fast-2.jpg', N'<p style="text-align: center;"><img alt="Site and Property Selection" class="border-image" src="/Upload/images/Services/f2_600x380.jpg" /></p>

<p>In any investment or expansion decision requiring new facilities, one of the most crucial decisions is about the choice of location.&nbsp; Here, NSO has the hands-on experience, having worked with many MNCs and SMEs in this regard, and the deep local knowledge to assist you to make the right choice because we understand the local geography, demographics, and infrastructure to fit the specific needs of the business.&nbsp; We can help you to:</p>

<ul>
	<li>
	<p>select the right land plots (whether raw or prepared) to develop</p>
	</li>
	<li>
	<p>select an existing facility (if available) for modification and retrofitting to your specifications if this is your preferred option</p>
	</li>
	<li>
	<p>select the right office to complement your business operations. In case you need temporary facilities, we have a fully-equipped shared business centre offering various office sizes and meeting facilities, with professionally-trained English-speaking staff</p>
	</li>
	<li>
	<p>set up virtual offices (having a virtual site in Vietnam without the unnecessary overheads associated with keeping an overseas office). Such a virtual office can also be a platform to monitor, reach out to, and develop the regional markets in Indo-China and even beyond</p>
	</li>
	<li>
	<p>display your products and brochures in NSO&rsquo; s showrooms</p>
	</li>
</ul>
', 0, 1, CAST(N'2015-09-13 00:05:00.000' AS DateTime), 2, 1, 2)
INSERT [dbo].[SERVICES] ([ID], [Title], [Tag], [Sub], [Image], [Content], [IsHot], [TotalView], [Date], [ID_UserPost], [Active], [ID_GroupServices]) VALUES (5, N'Legal and Permitting Services', N'legal-and-permitting-services', N'<p>We have a dedicated team to help secure necessary legal documents, permits, and approvals for any type of operations or legal requirements for your business.</p>
', N'/Upload/images/Services/fast-3.jpg', N'<p style="text-align: center;"><img alt="Legal and Permitting Services" class="border-image" src="/Upload/images/Services/f3_600x380.jpg" /></p>

<p>We have a dedicated team to help secure necessary legal documents, permits, and approvals for any type of operations or legal requirements for your business.</p>

<p>New business set-up &amp; licensing procedures</p>

<p>Amendment of Investment certificate and special permits</p>

<p>Advisory on investment incentives and procedures</p>

<p>Advisory on tax incentives and compliances</p>
', 0, 1, CAST(N'2015-09-13 00:10:00.000' AS DateTime), 2, 1, 2)
INSERT [dbo].[SERVICES] ([ID], [Title], [Tag], [Sub], [Image], [Content], [IsHot], [TotalView], [Date], [ID_UserPost], [Active], [ID_GroupServices]) VALUES (6, N'Design and Construction Management', N'design-and-construction-management', N'<p>NSO has a strong, experienced and highly professional team of architects and engineers to provide international-standard factory and building designs.</p>
', N'/Upload/images/Services/fast-4.jpg', N'<p>NSO has a strong, experienced and highly professional team of architects and engineers to provide international-standard factory and building designs. Our team has extensive experience of planning, designing and project-managing a wide range of factory types and manufacturing environments, in compliance with full international design, construction and manufacturing standards for all sectors, ranging from food to pharmaceuticals to general as well as specialized manufacturing.</p>

<p style="text-align: center;"><img alt="Design and Construction Management" class="border-image" src="/Upload/images/Services/f4_600x380.jpg" /></p>

<p>NSO&rsquo;s project management and owner supervision of the construction projects is to ensure good quality implementation of the constructions with optimal costs pursuant to the contract agreement, technical standards, budgets and schedules.</p>
', 0, 1, CAST(N'2015-09-13 16:10:02.140' AS DateTime), 2, 1, 2)
INSERT [dbo].[SERVICES] ([ID], [Title], [Tag], [Sub], [Image], [Content], [IsHot], [TotalView], [Date], [ID_UserPost], [Active], [ID_GroupServices]) VALUES (7, N'Interior Design, Fitting-Out Renovation & Decoration', N'interior-design-fittingout-renovation-decoration', N'<p>In addition to design and construction management, we also provide solutions for interior design, fitting-out and decoration for the offices, showrooms or commercial and residential projects.</p>
', N'/Upload/images/Services/fast-5.jpg', N'<p style="text-align: center;"><img alt="Interior Design, Fitting-Out Renovation &amp; Decoration" class="border-image" src="/Upload/images/Services/f5_600x380.jpg" /></p>

<p>In addition to design and construction management, we also provide solutions for interior design, fitting-out and decoration for the offices, showrooms or commercial and residential projects.&nbsp; We can offer turn-key &ldquo;design, complete and hand-over&rdquo; packages, not just for the physical fitting-out and renovation works, but also complete the entire office or showroom for you including arranging the displays and hiring and pre-training the customer-facing staff for you if you require.</p>

<p>In short, we literally provide you with &ldquo;plug-and-play&rdquo; solutions for your office needs.</p>
', 0, 1, CAST(N'2015-09-17 18:11:18.137' AS DateTime), 2, 1, 2)
INSERT [dbo].[SERVICES] ([ID], [Title], [Tag], [Sub], [Image], [Content], [IsHot], [TotalView], [Date], [ID_UserPost], [Active], [ID_GroupServices]) VALUES (8, N'Building and Facility Maintenance', N'building-and-facility-maintenance', N'<p>As a full-service provider for new facilities as well as existing operations, NSO provides facility and building maintenance and repair services to keep the facilities in good conditions by offering reliable services, reduced costs and operational efficiencies.</p>
', N'/Upload/images/Services/fast-6.jpg', N'<p style="text-align: center;"><img alt="Building and Facility Maintenance" class="border-image" src="/Upload/images/Services/f6_600x380.jpg" /></p>

<p>As a full-service provider for new facilities as well as existing operations, NSO provides facility and building maintenance and repair services to keep the facilities in good conditions by offering reliable services, reduced costs and operational efficiencies. &nbsp;We have the 20-year experience and track-record of having served MNCs and FDI investment projects as these operations are first established, then upgraded, then modified, expanded or replaced with the latest equipment and processed.&nbsp; We are familiar with the latest international standards and best practices in Facilities Maintenance, and we offer this exceptional standard of service to you.</p>
', 0, 1, CAST(N'2015-09-17 18:13:31.950' AS DateTime), 2, 1, 2)
INSERT [dbo].[SERVICES] ([ID], [Title], [Tag], [Sub], [Image], [Content], [IsHot], [TotalView], [Date], [ID_UserPost], [Active], [ID_GroupServices]) VALUES (9, N'Logistics services (Transport of materials and finished goods)', N'logistics-services-transport-of-materials-and-finished-goods', N'<p>Through our full partnership with established logistics service providers, ICD and port operators and especially our team&rsquo;s experience working with customs and tax authorities</p>
', N'/Upload/images/Services/fast-7.jpg', N'<p style="text-align: center;"><img alt="Logistics services (Transport of materials and finished goods)" class="border-image" src="/Upload/images/Services/f7_600x380.jpg" /></p>

<p>Through our full partnership with established logistics service providers, ICD and port operators and especially our team&rsquo;s experience working with customs and tax authorities, we optimize transport plans with operational implementation to provide the most efficient logistics solutions for all aspects of manufacturer&rsquo;s supply chain and in reducing logistics costs and meeting time schedules.</p>
', 0, 1, CAST(N'2015-09-17 18:13:59.067' AS DateTime), 2, 1, 2)
INSERT [dbo].[SERVICES] ([ID], [Title], [Tag], [Sub], [Image], [Content], [IsHot], [TotalView], [Date], [ID_UserPost], [Active], [ID_GroupServices]) VALUES (10, N'Communications, Media and Marketing Consultancy Services', N'communications-media-and-marketing-consultancy-services', N'<p>In an expanding, competitive and increasingly sophisticated market like Vietnam, SMEs and MNCs are now recognizing that branding and marketing communications are becoming more</p>
', N'/Upload/images/Services/fast-8.jpg', N'<p style="text-align: center;"><img alt="Communications, Media and Marketing Consultancy Services" class="border-image" src="/Upload/images/Services/f8_600x380.jpg" /></p>

<p>In an expanding, competitive and increasingly sophisticated market like Vietnam, SMEs and MNCs are now recognizing that branding and marketing communications are becoming more and more important tools to differentiate from the competition, create competitive advantage, foster loyalty and connect the company and customer even closer.&nbsp; At NSO, we have partnered with experienced and renowned media &amp; communications agencies to offer you a complete suite of marketing, branding, advertising and corporate communications services.</p>
', 0, 1, CAST(N'2015-09-17 18:14:26.490' AS DateTime), 2, 1, 2)
INSERT [dbo].[SERVICES] ([ID], [Title], [Tag], [Sub], [Image], [Content], [IsHot], [TotalView], [Date], [ID_UserPost], [Active], [ID_GroupServices]) VALUES (11, N'Corporate Travel and Accommodation Services', N'corporate-travel-and-accommodation-services', N'<p>For all your travel needs, whether for your staff, your customers or for your guests, we can save you time, effort, and cost when you book through our fully equipped agency.</p>
', N'/Upload/images/Services/fast-9.png', N'<p style="text-align: center;"><img alt="Corporate Travel and Accommodation Services" class="border-image" src="/Upload/images/Services/f9_600x380.jpg" /></p>

<p>For all your travel needs, whether for your staff, your customers or for your guests, we can save you time, effort, and cost when you book through our fully equipped agency. &nbsp;We provide an excellent and wide range of flight bookings, hotel choices and related travel needs including car rentals, travel insurance, and visa applications at highly competitive rates and in quick response time.</p>

<p>Fast visa approval within 24 hours (with photo or icon&hellip;..)</p>

<p>Fast-track and VIP immigrations</p>

<p>Fast approval of working permits for foreigners</p>

<p>Car rental (photo of a car&hellip;)</p>

<p>Ticketing</p>

<p>Corporate Travel</p>

<p>Hotel corporate rates&hellip;(photos of a hotel&hellip;)</p>
', 0, 1, CAST(N'2015-09-17 18:14:57.743' AS DateTime), 2, 1, 2)
INSERT [dbo].[SERVICES] ([ID], [Title], [Tag], [Sub], [Image], [Content], [IsHot], [TotalView], [Date], [ID_UserPost], [Active], [ID_GroupServices]) VALUES (12, N'Innovation & New Technology Introduction', N'innovation-new-technology-introduction', N'<p>NSO is unique in Vietnam in offering this platform of connecting with leading technology providers, especially those which are outside of Vietnam but whose expertise, services and products are relevant and suitable for Vietnam-based companies.</p>
', N'/Upload/images/Services/tap-1.jpg', N'<p>Through partnership with some of the world&rsquo;s leading firms in manufacturing processes, mechanization and automation vendors, NSO and its technology partners provide the means for Vietnam-based companies to upgrade its operations, increase output and efficiency, and enable themselves to utilize new technologies as well as position for new markets through meeting higher international standards.</p>

<p style="text-align: center;"><img alt="Innovation &amp; New Technology Introduction" class="border-image" src="/Upload/images/Services/f10_600x380.jpg" /></p>

<p>Apart from the development of human resources and talent, this ability to receive and utilize new technologies and innovations, thereby achieving continuous improvement and competitive advantage, is the key to any company&rsquo;s success, leadership and continued domination of its customer base and market segments.</p>

<p>NSO is unique in Vietnam in offering this platform of connecting with leading technology providers, especially those which are outside of Vietnam but whose expertise, services and products are relevant and suitable for Vietnam-based companies.</p>
', 0, 1, CAST(N'2015-09-17 18:16:57.777' AS DateTime), 2, 1, 3)
INSERT [dbo].[SERVICES] ([ID], [Title], [Tag], [Sub], [Image], [Content], [IsHot], [TotalView], [Date], [ID_UserPost], [Active], [ID_GroupServices]) VALUES (13, N'HR consultancy, training and recruitment', N'hr-consultancy-training-and-recruitment', N'<p>Within Vietnam, NSO works with universities, colleges, technical training centers to provide our customers with trained workforce as well as training courses.</p>
', N'/Upload/images/Services/tap-2.jpg', N'<p>As a strategic and full-service partner with businesses in Vietnam, NSO is unique in recognizing that training and developing human resources is absolutely crucial to any company&rsquo;s competitiveness, sustainability and continued growth and expansion.</p>

<p>NSO therefore has placed special emphasis to create and provide a platform whereby companies in Vietnam can access and avail of the necessary experts, trainers, and sources of technical, professional and personal upgrading for all staff and for all aspects of their business &ndash; whether in the manufacturing environment, in the commercial customer-facing situations, or in equipping managers with the latest management tools and knowledge.</p>

<p style="text-align: center;"><img alt="HR consultancy, training and recruitment" class="border-image" src="/Upload/images/Services/f11_600x380.jpg" /></p>

<p>Within Vietnam, NSO works with universities, colleges, technical training centers to provide our customers with trained workforce as well as training courses. We help companies to build talent for innovation and better manufacturing practices.&nbsp; We also help companies to train and upgrade all other aspects of staff&rsquo;s professional development &ndash; customer-facing skills, communications abilities, best management practices, service culture, and service excellence &ndash; so that your business as a whole stands out amongst the competition.</p>
', 0, 1, CAST(N'2015-09-17 18:17:56.967' AS DateTime), 2, 1, 3)
INSERT [dbo].[SERVICES] ([ID], [Title], [Tag], [Sub], [Image], [Content], [IsHot], [TotalView], [Date], [ID_UserPost], [Active], [ID_GroupServices]) VALUES (14, N'Office and Industrial Supplies', N'office-and-industrial-supplies', N'<p>NSO has secured distribution rights for many office supplies and products, as well as industrial disposables and other supplies for the factory floor.</p>
', N'/Upload/images/Services/office-0.jpg', N'<p style="text-align: center;"><img alt="Office and Industrial Supplies" class="border-image" src="/Upload/images/Services/f12_600x380.jpg" /></p>

<p>NSO has secured distribution rights for many office supplies and products, as well as industrial disposables and other supplies for the factory floor.&nbsp; In effect, NSO has established, through its e-Platform, a virtual office stationery, hardware and production material store, ready to supply you immediately and in the quantities you need, thereby reducing your inventory and manpower, and increasing your efficiency and cost effectiveness.</p>
', 0, 1, CAST(N'2015-09-17 18:18:28.903' AS DateTime), 2, 1, 4)
INSERT [dbo].[SERVICES] ([ID], [Title], [Tag], [Sub], [Image], [Content], [IsHot], [TotalView], [Date], [ID_UserPost], [Active], [ID_GroupServices]) VALUES (15, N'IT supply and maintenance services', N'it-supply-and-maintenance-services', N'<p>IT needs, whether hardware, software or services, represent some of the most crucial requirements for an efficient and smoothly-running operation, 24/7.</p>
', N'/Upload/images/Services/office-2.jpg', N'<p style="text-align: center;"><img alt="IT supply and maintenance services" class="border-image" src="/Upload/images/Services/f13_600x380.jpg" /></p>

<p>IT needs, whether hardware, software or services, represent some of the most crucial requirements for an efficient and smoothly-running operation, 24/7.&nbsp; IT is basically the &ldquo;blood and nervous system&rdquo; of any modern company.&nbsp; At NSO, we keenly recognize this fact and has partnered with leading IT companies to provide quality hardware, software, accessories and all types of necessary services (including security, maintenance and systems upgrading) at your doorstep, 24/7.</p>
', 0, 1, CAST(N'2015-09-17 18:18:54.563' AS DateTime), 2, 1, 4)
INSERT [dbo].[SERVICES] ([ID], [Title], [Tag], [Sub], [Image], [Content], [IsHot], [TotalView], [Date], [ID_UserPost], [Active], [ID_GroupServices]) VALUES (16, N'Catering supplies and Food service', N'catering-supplies-and-food-service', N'<p>NSO is also able to provide high-quality F&amp;B and catering services for office or corporate events.</p>
', N'/Upload/images/Services/office-3.jpg', N'<p style="text-align: center;"><img alt="Catering supplies and Food service" class="border-image" src="/Upload/images/Services/f14_600x380.jpg" /></p>

<p>NSO is also able to provide high-quality F&amp;B and catering services for office or corporate events. Should &ldquo;event services&rdquo; be required &ndash; for example, for factory opening, groundbreaking or special company celebrations &ndash; NSO can provide turn-key services to design, manage and cater for the entire event, leaving companies with no worries about organization or local customs, except to concentrate on their special occasion, guests, customers and VIPs.</p>

<p>NSO can also provide meal catering services for office staff and workers.</p>
', 0, 1, CAST(N'2015-09-17 18:19:37.653' AS DateTime), 2, 1, 4)
INSERT [dbo].[SERVICES] ([ID], [Title], [Tag], [Sub], [Image], [Content], [IsHot], [TotalView], [Date], [ID_UserPost], [Active], [ID_GroupServices]) VALUES (17, N'OUR SERVICES', N'our-services', N'<p>NSO has a strong and experienced team to serve you not just on working days but also throughout weekends and public holidays. We guarantee that our customer service team is fully operational and contactable round the clock, to make sure that your business needs and especially those occasions of unexpected challenges or problematic situations are always met with an NSO &ldquo;problem-solving&rdquo; response.</p>
', N'/Upload/images/Services/services_485x485.jpg', N'<p>NSO has a strong and experienced team to serve you not just on working days but also throughout weekends and public holidays. We guarantee that our customer service team is fully operational and contactable round the clock, to make sure that your business needs and especially those occasions of unexpected challenges or problematic situations are always met with an NSO &ldquo;problem-solving&rdquo; response.</p>

<p>Our strong support structure ensures that you are guaranteed consistent services and solutions whatever your business needs are. Whether you are planning to expand your operations, or to set up a new entity, we are there to provide fast-track set-up to secure all the necessary permits and to meet all legal and regulatory requirements. We also provide an efficient and effective interface on your behalf with the authorities to deal with all issues in overcoming linguistic, interpretation, cultural and other challenges in ensuring that these issues are expeditiously resolved so that you can move forward on focusing on building your company&rsquo;s strengths and concentrating on serving your customers and important stakeholders.</p>
', 0, 1, CAST(N'2015-09-18 10:28:58.170' AS DateTime), 2, 1, 1)
SET IDENTITY_INSERT [dbo].[SERVICES] OFF
SET IDENTITY_INSERT [dbo].[SIZES] ON 

INSERT [dbo].[SIZES] ([SizeId], [Name], [Note], [IsActive]) VALUES (1, N'XS', N'Rất nhỏ', 0)
INSERT [dbo].[SIZES] ([SizeId], [Name], [Note], [IsActive]) VALUES (2, N'S', N'Nhỏ', 1)
INSERT [dbo].[SIZES] ([SizeId], [Name], [Note], [IsActive]) VALUES (3, N'M', N'Trung bình', 1)
INSERT [dbo].[SIZES] ([SizeId], [Name], [Note], [IsActive]) VALUES (4, N'L', N'Lớn', 1)
INSERT [dbo].[SIZES] ([SizeId], [Name], [Note], [IsActive]) VALUES (5, N'XL', N'Rất lớn', 1)
INSERT [dbo].[SIZES] ([SizeId], [Name], [Note], [IsActive]) VALUES (6, N'XXL', N'Siêu lớn', 0)
SET IDENTITY_INSERT [dbo].[SIZES] OFF
SET IDENTITY_INSERT [dbo].[SOCIAL_NETWORK] ON 

INSERT [dbo].[SOCIAL_NETWORK] ([ID], [Name], [Href], [Description], [Active]) VALUES (1, N'Facebook', N'https://www.facebook.com/thanhnamit', N'fa fa-facebook', 1)
INSERT [dbo].[SOCIAL_NETWORK] ([ID], [Name], [Href], [Description], [Active]) VALUES (2, N'Twitter', N'#', N'fa fa-twitter', 1)
INSERT [dbo].[SOCIAL_NETWORK] ([ID], [Name], [Href], [Description], [Active]) VALUES (3, N'Google+', N'#', N'fa fa-google-plus', 1)
INSERT [dbo].[SOCIAL_NETWORK] ([ID], [Name], [Href], [Description], [Active]) VALUES (5, N'Youtube', N'https://youtube.com/', N'fa fa-youtube-play', 1)
INSERT [dbo].[SOCIAL_NETWORK] ([ID], [Name], [Href], [Description], [Active]) VALUES (6, N'Instagram', N'#', N'fa fa-instagram', 0)
INSERT [dbo].[SOCIAL_NETWORK] ([ID], [Name], [Href], [Description], [Active]) VALUES (7, N'Pinterest', N'#', N'fa fa-pinterest', 0)
INSERT [dbo].[SOCIAL_NETWORK] ([ID], [Name], [Href], [Description], [Active]) VALUES (8, N'Vimeo', N'#vimeo', N'fa fa-vimeo-square', 0)
INSERT [dbo].[SOCIAL_NETWORK] ([ID], [Name], [Href], [Description], [Active]) VALUES (9, N'Tin RSS', N'#', N'fa fa-rss', 0)
INSERT [dbo].[SOCIAL_NETWORK] ([ID], [Name], [Href], [Description], [Active]) VALUES (10, N'Flickr', N'#', N'fa fa-flickr', 0)
INSERT [dbo].[SOCIAL_NETWORK] ([ID], [Name], [Href], [Description], [Active]) VALUES (11, N'Linkedin', N'#', N'fa fa-linkedin', 0)
INSERT [dbo].[SOCIAL_NETWORK] ([ID], [Name], [Href], [Description], [Active]) VALUES (12, N'Skype', N'#', N'fa fa-skype', 1)
SET IDENTITY_INSERT [dbo].[SOCIAL_NETWORK] OFF
SET IDENTITY_INSERT [dbo].[TYPES] ON 

INSERT [dbo].[TYPES] ([ID_Type], [Name], [Tag], [IsActive]) VALUES (1, N'Sản phẩm mới', N'san-pham-moi', 1)
INSERT [dbo].[TYPES] ([ID_Type], [Name], [Tag], [IsActive]) VALUES (2, N'Sản phẩm khuyến mãi', N'san-pham-khuyen-mai', 1)
INSERT [dbo].[TYPES] ([ID_Type], [Name], [Tag], [IsActive]) VALUES (3, N'Sản phẩm bán chạy', N'san-pham-ban-chay', 0)
INSERT [dbo].[TYPES] ([ID_Type], [Name], [Tag], [IsActive]) VALUES (4, N'Sản phẩm hot', N'san-pham-hot-nhat', 0)
INSERT [dbo].[TYPES] ([ID_Type], [Name], [Tag], [IsActive]) VALUES (5, N'Hot deal', N'hot-deal', 0)
SET IDENTITY_INSERT [dbo].[TYPES] OFF
SET IDENTITY_INSERT [dbo].[USERS] ON 

INSERT [dbo].[USERS] ([ID], [Username], [Password], [Fullname], [Image], [Date], [Note], [Active], [Email]) VALUES (2, N'namnguyen1251', N'AFE18BF63FA44D4707E48B3BECAFBDDF20E6F886', N'Thành Nam', N'/Upload/images/Icons/avt-tn.png', CAST(N'2015-02-14 00:00:00.000' AS DateTime), N'I''m designer & web dev!', 1, N'namnguyen1251@gmail.com')
INSERT [dbo].[USERS] ([ID], [Username], [Password], [Fullname], [Image], [Date], [Note], [Active], [Email]) VALUES (10, N'Systems', N'DCA0A5AFD0B457EE36F8862369C7FDA58C162B25', N'Systems', N'/Upload/images/Icons/user-big.jpg', CAST(N'2015-07-05 19:42:44.440' AS DateTime), N'Baotinsoftware.com.vn', 1, N'baotinsoftware@gmail.com')
SET IDENTITY_INSERT [dbo].[USERS] OFF
ALTER TABLE [dbo].[Comment] ADD  CONSTRAINT [DF_Comment_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[GROUP_PRODUCTS] ADD  CONSTRAINT [DF_GROUP_PRODUCTS_IsHot]  DEFAULT ((0)) FOR [IsHot]
GO
ALTER TABLE [dbo].[HashTagLink] ADD  CONSTRAINT [DF_HashTagLink_IsType]  DEFAULT ((0)) FOR [TypeId]
GO
ALTER TABLE [dbo].[GALLERY]  WITH CHECK ADD  CONSTRAINT [FK_GALLERY_GROUP_GALLERY] FOREIGN KEY([ID_GroupGallery])
REFERENCES [dbo].[GROUP_GALLERY] ([ID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[GALLERY] CHECK CONSTRAINT [FK_GALLERY_GROUP_GALLERY]
GO
ALTER TABLE [dbo].[HashTagLink]  WITH CHECK ADD  CONSTRAINT [FK_HashTagLink_HashTag] FOREIGN KEY([HashTagId])
REFERENCES [dbo].[HashTag] ([HashTagId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[HashTagLink] CHECK CONSTRAINT [FK_HashTagLink_HashTag]
GO
ALTER TABLE [dbo].[NEWS]  WITH CHECK ADD  CONSTRAINT [FK_NEWS_GROUP_NEWS] FOREIGN KEY([ID_GroupNews])
REFERENCES [dbo].[GROUP_NEWS] ([ID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[NEWS] CHECK CONSTRAINT [FK_NEWS_GROUP_NEWS]
GO
ALTER TABLE [dbo].[NEWS]  WITH CHECK ADD  CONSTRAINT [FK_NEWS_USER] FOREIGN KEY([ID_UserPost])
REFERENCES [dbo].[USERS] ([ID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[NEWS] CHECK CONSTRAINT [FK_NEWS_USER]
GO
ALTER TABLE [dbo].[ORDER_DETAILS]  WITH CHECK ADD  CONSTRAINT [FK_ORDER_DETAILS_ORDER_PRODUCTS] FOREIGN KEY([OrderID])
REFERENCES [dbo].[ORDER_PRODUCTS] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ORDER_DETAILS] CHECK CONSTRAINT [FK_ORDER_DETAILS_ORDER_PRODUCTS]
GO
ALTER TABLE [dbo].[ORDER_PRODUCTS]  WITH CHECK ADD  CONSTRAINT [FK_ORDERS_PRODUCTS_ORDER_STATUSES] FOREIGN KEY([StatusID])
REFERENCES [dbo].[ORDER_STATUSES] ([ID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[ORDER_PRODUCTS] CHECK CONSTRAINT [FK_ORDERS_PRODUCTS_ORDER_STATUSES]
GO
ALTER TABLE [dbo].[PRODUCT_COLORS]  WITH CHECK ADD  CONSTRAINT [FK_PRODUCT_COLORS_COLORS] FOREIGN KEY([ColorId])
REFERENCES [dbo].[COLORS] ([ColorId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PRODUCT_COLORS] CHECK CONSTRAINT [FK_PRODUCT_COLORS_COLORS]
GO
ALTER TABLE [dbo].[PRODUCT_COLORS]  WITH CHECK ADD  CONSTRAINT [FK_PRODUCT_COLORS_PRODUCTS] FOREIGN KEY([ProductId])
REFERENCES [dbo].[PRODUCTS] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PRODUCT_COLORS] CHECK CONSTRAINT [FK_PRODUCT_COLORS_PRODUCTS]
GO
ALTER TABLE [dbo].[PRODUCT_IMAGES]  WITH CHECK ADD  CONSTRAINT [FK_PRODUCT_IMAGES_PRODUCTS] FOREIGN KEY([ID_Products])
REFERENCES [dbo].[PRODUCTS] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PRODUCT_IMAGES] CHECK CONSTRAINT [FK_PRODUCT_IMAGES_PRODUCTS]
GO
ALTER TABLE [dbo].[PRODUCT_NEWS]  WITH CHECK ADD  CONSTRAINT [FK_PRODUCT_NEWS_NEWS] FOREIGN KEY([NewsId])
REFERENCES [dbo].[NEWS] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PRODUCT_NEWS] CHECK CONSTRAINT [FK_PRODUCT_NEWS_NEWS]
GO
ALTER TABLE [dbo].[PRODUCT_NEWS]  WITH CHECK ADD  CONSTRAINT [FK_PRODUCT_NEWS_PRODUCTS] FOREIGN KEY([ProductId])
REFERENCES [dbo].[PRODUCTS] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PRODUCT_NEWS] CHECK CONSTRAINT [FK_PRODUCT_NEWS_PRODUCTS]
GO
ALTER TABLE [dbo].[PRODUCT_SIZES]  WITH CHECK ADD  CONSTRAINT [FK_PRODUCT_SIZES_PRODUCT_SIZES] FOREIGN KEY([SizeId])
REFERENCES [dbo].[SIZES] ([SizeId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PRODUCT_SIZES] CHECK CONSTRAINT [FK_PRODUCT_SIZES_PRODUCT_SIZES]
GO
ALTER TABLE [dbo].[PRODUCT_SIZES]  WITH CHECK ADD  CONSTRAINT [FK_PRODUCT_SIZES_PRODUCTS] FOREIGN KEY([ProductId])
REFERENCES [dbo].[PRODUCTS] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PRODUCT_SIZES] CHECK CONSTRAINT [FK_PRODUCT_SIZES_PRODUCTS]
GO
ALTER TABLE [dbo].[PRODUCT_TYPES]  WITH CHECK ADD  CONSTRAINT [FK_PRODUCT_TYPES_PRODUCTS] FOREIGN KEY([ID_Product])
REFERENCES [dbo].[PRODUCTS] ([ID])
GO
ALTER TABLE [dbo].[PRODUCT_TYPES] CHECK CONSTRAINT [FK_PRODUCT_TYPES_PRODUCTS]
GO
ALTER TABLE [dbo].[PRODUCT_TYPES]  WITH CHECK ADD  CONSTRAINT [FK_PRODUCT_TYPES_TYPES] FOREIGN KEY([ID_Type])
REFERENCES [dbo].[TYPES] ([ID_Type])
GO
ALTER TABLE [dbo].[PRODUCT_TYPES] CHECK CONSTRAINT [FK_PRODUCT_TYPES_TYPES]
GO
ALTER TABLE [dbo].[PRODUCTS]  WITH CHECK ADD  CONSTRAINT [FK_PRODUCTS_GROUP_PRODUCTS] FOREIGN KEY([ID_GroupProduct])
REFERENCES [dbo].[GROUP_PRODUCTS] ([ID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[PRODUCTS] CHECK CONSTRAINT [FK_PRODUCTS_GROUP_PRODUCTS]
GO
ALTER TABLE [dbo].[PRODUCTS]  WITH CHECK ADD  CONSTRAINT [FK_PRODUCTS_PRODUCT_STATUS] FOREIGN KEY([StatusID])
REFERENCES [dbo].[PRODUCT_STATUS] ([ID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[PRODUCTS] CHECK CONSTRAINT [FK_PRODUCTS_PRODUCT_STATUS]
GO
ALTER TABLE [dbo].[SERVICES]  WITH CHECK ADD  CONSTRAINT [FK_SERVICES_GROUP_SERVICES] FOREIGN KEY([ID_GroupServices])
REFERENCES [dbo].[GROUP_SERVICES] ([ID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[SERVICES] CHECK CONSTRAINT [FK_SERVICES_GROUP_SERVICES]
GO
ALTER TABLE [dbo].[SERVICES]  WITH CHECK ADD  CONSTRAINT [FK_SERVICES_USERS] FOREIGN KEY([ID_UserPost])
REFERENCES [dbo].[USERS] ([ID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[SERVICES] CHECK CONSTRAINT [FK_SERVICES_USERS]
GO
/****** Object:  StoredProcedure [dbo].[Fe_GetHashtagByLinkId]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<NAM-NT>
-- Create date: <2017/11/17>
-- Description:	<Fe_GetHashtagByTypeId>
-- =============================================
CREATE PROCEDURE [dbo].[Fe_GetHashtagByLinkId] 
	@LinkId INT,
	@TypeId INT,
	@PrefixUrl VARCHAR(100)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		HL.HashTagId, HL.LinkId, H.Name, H.Alias,
		CASE
			WHEN HL.TypeId = 0 THEN N'Product'
			WHEN HL.TypeId = 1 THEN N'News'
			WHEN HL.TypeId = 2 THEN N'Services'
			ELSE N'N/A'
		END as TypeName,
		('/' + @PrefixUrl +'/' + H.Alias + '-' + CAST(HL.HashTagId as VARCHAR(10)) + '.html') as UrlFormat
	FROM [dbo].[HashTagLink] as HL LEFT JOIN [dbo].[HashTag] as H ON HL.HashTagId =  H.HashTagId
	WHERE HL.TypeId = @TypeId AND HL.LinkId = @LinkId AND H.IsActive = 1
	ORDER BY HL.HashTagId DESC
END

GO
/****** Object:  StoredProcedure [dbo].[Fe_GetProduct_Paging_By_HashtagId]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<NAM-NT>
-- Create date: <2017/05/25>
-- Description:	<Phân trang theo HashtagId>
-- =============================================
CREATE PROCEDURE [dbo].[Fe_GetProduct_Paging_By_HashtagId] 
	@HashtagId INT,
	@PageIndex INT = 1, 
	@PageSize INT = 10, 
	@PrefixUrl VARCHAR(50) = 'san-pham'
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @New nvarchar(100) = N'<img src="/Theme/photo/new.png" class="new" alt="Sản phẩm mới" />'
	DECLARE @SaleOff nvarchar(100) = N'<img src="/Theme/photo/sale.png" class="new" alt="Sản phẩm khyến mãi" />'

	SELECT * FROM
	(
		SELECT 
			P.ID as ProductId, P.Code as ProductCode, P.Name as ProductName, P.Tag as Alias, P.Image as Avatar,
			P.Sapo, P.Content, P.Price, P.PriceOld, P.ID_GroupProduct as ProductCategoryId, P.DatePublish, P.CountView,
			P.CountBuy, P.IsActive, P.IsHot, G.Name as ProductCategoryName, G.Tag as ProductCategoryAlias,
			('/' + @PrefixUrl + '/' + G.Tag + '-' + CAST(G.ID as varchar(10)) + '/' + P.Tag + '-' + CAST(P.ID as varchar(10)) + '.html') as UrlFormat,
			('/' + @PrefixUrl + '/' + G.Tag + '-' + CAST(G.ID as varchar(10)) + '.html') as CategoryUrl,
			P.LinkY as Youtube,
			CASE (SELECT TOP 1 ID_Type FROM PRODUCT_TYPES WHERE ID_Product = P.ID)
				WHEN 1 THEN @New
				WHEN 2 THEN @SaleOff
				ELSE ''
			END as Icon,
			ROW_NUMBER() OVER (ORDER BY p.DatePublish DESC) Row
		FROM PRODUCTS as P 
			INNER JOIN GROUP_PRODUCTS as G ON P.ID_GroupProduct = G.ID
			INNER JOIN PRODUCT_STATUS as S ON P.StatusID = S.ID
			INNER JOIN HashTagLink as HL ON P.Id = HL.LinkId AND HL.TypeId = '0'
		WHERE HL.HashTagId = @HashtagId AND P.IsActive = 1
	) as A WHERE A.Row > (@PageIndex - 1) * @PageSize AND A.Row <= @PageIndex * @PageSize 
END
GO
/****** Object:  StoredProcedure [dbo].[Fe_GetProductByCategoryId]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Fe_GetProductByCategoryId] 
	@CategoryId int,
	@PrefixUrl varchar(50) = 'san-pham'
AS
BEGIN
	SET NOCOUNT ON;

	IF(@CategoryId IS NOT NULL AND @CategoryId > 0)
	BEGIN
		SELECT 
			P.ID as ProductId, P.Code as ProductCode, P.Name as ProductName, P.Tag as Alias, P.Image as Avatar,
			P.Sapo, P.Content, P.Price, P.PriceOld, P.ID_GroupProduct as ProductCategoryId, P.DatePublish, P.CountView,
			P.CountBuy, P.IsActive, P.IsHot, G.Name as ProductCategoryName, G.Tag as ProductCategoryAlias, S.Name as Status,
			('/' + @PrefixUrl + '/' + G.Tag + '-' + CAST(G.ID as varchar(10)) + '/' + P.Tag + '-' + CAST(P.ID as varchar(10)) + '.html') as UrlFormat,
			('/' + @PrefixUrl + '/' + G.Tag + '-' + CAST(G.ID as varchar(10)) + '.html') as CategoryUrl,
			P.LinkY as Youtube
		FROM PRODUCTS as P 
			INNER JOIN GROUP_PRODUCTS as G ON P.ID_GroupProduct = G.ID
			INNER JOIN PRODUCT_STATUS as S ON P.StatusID = S.ID 
		WHERE P.IsActive = 1 AND P.ID_GroupProduct = @CategoryId
		ORDER BY P.DatePublish DESC
	END
END
GO
/****** Object:  StoredProcedure [dbo].[Fe_GetProductById]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Fe_GetProductById] 
	@ProductId int,
	@PrefixUrl varchar(50) = 'san-pham'
AS
BEGIN
	SET NOCOUNT ON;

	IF(@ProductId IS NOT NULL AND @ProductId > 0)
	BEGIN
		SELECT 
			P.ID as ProductId, P.Code as ProductCode, P.Name as ProductName, P.Tag as Alias, P.Image as Avatar,
			P.Sapo, P.Content, P.Price, P.PriceOld, P.ID_GroupProduct as ProductCategoryId, P.DatePublish, P.CountView,
			P.CountBuy, P.IsActive, P.IsHot, G.Name as ProductCategoryName, G.Tag as ProductCategoryAlias, S.Name as Status,
			('/' + @PrefixUrl + '/' + G.Tag + '-' + CAST(G.ID as varchar(10)) + '/' + P.Tag + '-' + CAST(P.ID as varchar(10)) + '.html') as UrlFormat,
			('/' + @PrefixUrl + '/' + G.Tag + '-' + CAST(G.ID as varchar(10)) + '.html') as CategoryUrl,
			P.LinkY as Youtube
		FROM PRODUCTS as P 
			LEFT JOIN GROUP_PRODUCTS as G ON P.ID_GroupProduct = G.ID
			LEFT JOIN PRODUCT_STATUS as S ON P.StatusID = S.ID 
		WHERE P.IsActive = 1 AND P.ID = @ProductId
	END
END

GO
/****** Object:  StoredProcedure [dbo].[GET_NEWS_FEATURED_CATID]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GET_NEWS_FEATURED_CATID] 
	-- Truyền GroupNewsID vào
	@CatId int
AS
BEGIN
	SELECT  p.*
	FROM    NEWS p INNER JOIN dbo.f_GetGROUP_NEWS_InParent(@CatId) gp ON p.ID_GroupNews = gp.ID
	WHERE   p.IsHot = 1 AND p.Active = 1
END

GO
/****** Object:  StoredProcedure [dbo].[GET_NEWS_PAGING]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GET_NEWS_PAGING]
	-- Add the parameters for the stored procedure here
	@PageIndex INT = 1,
	@PageSize INT = 10
AS
BEGIN

	-- Buoc 1: Danh index cho cac row
	--SELECT u.ID, u.Username,
	--	   ROW_NUMBER() OVER (ORDER BY u.Date DESC) Row
	--FROM   USERS u
	
	-- Buoc 2: lay theo phan trang
	-- Vi du: 1 trang co 10 ban ghi, thi trang 1: row se la tu 1 den 10
	--                                   trang 2: row se la tu 10 den 20
	-- => trang n: row se la (n-1) * 10 den n * 10
	
	-- =>
	
	SELECT *
	FROM
	(
		SELECT n.*,
			   ROW_NUMBER() OVER (ORDER BY n.Date DESC) Row
		FROM   NEWS n
	) n
	WHERE n.Row >  (@PageIndex - 1) * @PageSize AND n.Row <= @PageIndex * @PageSize
 
END

GO
/****** Object:  StoredProcedure [dbo].[GET_NEWS_PAGING_COUNT]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GET_NEWS_PAGING_COUNT]
	
AS
BEGIN

	
	

		SELECT COUNT(1) Total			   
		FROM   NEWS n

 
END

GO
/****** Object:  StoredProcedure [dbo].[GET_NEWS_PAGING_COUNT_GROUP_NEWS]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GET_NEWS_PAGING_COUNT_GROUP_NEWS]
	@CatID INT
AS
BEGIN

		SELECT COUNT(1) Total			   
		FROM   NEWS p INNER JOIN dbo.f_GetGROUP_NEWS_InParent(@CatID) gp ON p.ID_GroupNews = gp.ID
		
END

GO
/****** Object:  StoredProcedure [dbo].[GET_NEWS_PAGING_GROUP_NEWS]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GET_NEWS_PAGING_GROUP_NEWS]
	-- Add the parameters for the stored procedure here
	@CatID INT,
	@PageIndex INT = 1,
	@PageSize INT = 10
AS
BEGIN

	-- Buoc 1: Danh index cho cac row
	--SELECT u.ID, u.Username,
	--	   ROW_NUMBER() OVER (ORDER BY u.Date DESC) Row
	--FROM   USERS u
	
	-- Buoc 2: lay theo phan trang
	-- Vi du: 1 trang co 10 ban ghi, thi trang 1: row se la tu 1 den 10
	--                                   trang 2: row se la tu 10 den 20
	-- => trang n: row se la (n-1) * 10 den n * 10
	
	-- =>
	
	SELECT *
	FROM
	(
		SELECT p.*,
			   ROW_NUMBER() OVER (ORDER BY p.Date DESC) Row
		FROM   NEWS p INNER JOIN dbo.f_GetGROUP_NEWS_InParent(@CatID) gp ON p.ID_GroupNews = gp.ID
		-- WHERE  p.Active = 1
	) p
	WHERE p.Row >  (@PageIndex - 1) * @PageSize AND p.Row <= @PageIndex * @PageSize
 
END

GO
/****** Object:  StoredProcedure [dbo].[GET_ORDER_DETAILS]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GET_ORDER_DETAILS]
	-- Add the parameters for the stored procedure here
	@OrderID INT
AS
BEGIN
	
	SELECT P.ID,P.Code,P.Name,P.Tag,P.Image,P.Price,ORDT.Quantity 
	FROM PRODUCTS P
	INNER JOIN ORDER_DETAILS ORDT ON ORDT.ProductID = P.ID
	WHERE ORDT.OrderID = @OrderID
 
END

GO
/****** Object:  StoredProcedure [dbo].[GET_ORDER_PRODUCT_PAGING]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GET_ORDER_PRODUCT_PAGING]
	-- Add the parameters for the stored procedure here
	@PageIndex INT = 1,
	@PageSize INT = 10
AS
BEGIN

	-- Buoc 1: Danh index cho cac row
	--SELECT u.ID, u.Username,
	--	   ROW_NUMBER() OVER (ORDER BY u.Date DESC) Row
	--FROM   USERS u
	
	-- Buoc 2: lay theo phan trang
	-- Vi du: 1 trang co 10 ban ghi, thi trang 1: row se la tu 1 den 10
	--                                   trang 2: row se la tu 10 den 20
	-- => trang n: row se la (n-1) * 10 den n * 10
	
	-- =>
	
	SELECT *
	FROM
	(
		SELECT n.*,
			   ROW_NUMBER() OVER (ORDER BY n.Date DESC) Row
		FROM   ORDER_PRODUCTS n
	) n
	WHERE n.Row >  (@PageIndex - 1) * @PageSize AND n.Row <= @PageIndex * @PageSize
 
END

GO
/****** Object:  StoredProcedure [dbo].[GET_ORDER_PRODUCT_PAGING_COUNT]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GET_ORDER_PRODUCT_PAGING_COUNT]
	
AS
BEGIN

	
	

		SELECT COUNT(1) Total			   
		FROM   ORDER_PRODUCTS n

 
END

GO
/****** Object:  StoredProcedure [dbo].[GET_PRODUCT_PAGING]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GET_PRODUCT_PAGING]
	-- Add the parameters for the stored procedure here
	@FlagId INT,
	@PageIndex INT = 1,
	@PageSize INT = 10
AS
BEGIN
	SET NOCOUNT ON;
	-- Buoc 1: Danh index cho cac row
	--SELECT u.ID, u.Username,
	--	   ROW_NUMBER() OVER (ORDER BY u.Date DESC) Row
	--FROM   USERS u
	
	-- Buoc 2: lay theo phan trang
	-- Vi du: 1 trang co 10 ban ghi, thi trang 1: row se la tu 1 den 10
	--                                   trang 2: row se la tu 10 den 20
	-- => trang n: row se la (n-1) * 10 den n * 10
	
	-- =>
	
	IF @FlagId = 1 OR @FlagId = 0
		SELECT *
		FROM
		(
			SELECT p.*, ROW_NUMBER() OVER (ORDER BY p.DatePublish DESC) Row
			FROM   PRODUCTS p
			WHERE p.IsHot = @FlagId
		) p
		WHERE p.Row >  (@PageIndex - 1) * @PageSize AND p.Row <= @PageIndex * @PageSize
	ELSE
		SELECT *
		FROM
		(
			SELECT p.*, ROW_NUMBER() OVER (ORDER BY p.DatePublish DESC) Row
			FROM   PRODUCTS p
		) p
		WHERE p.Row >  (@PageIndex - 1) * @PageSize AND p.Row <= @PageIndex * @PageSize									 
END

GO
/****** Object:  StoredProcedure [dbo].[GET_PRODUCT_PAGING_COUNT]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GET_PRODUCT_PAGING_COUNT]
	@FlagId INT
AS
BEGIN

	SET NOCOUNT ON;
	IF (@FlagId = 1 OR @FlagId = 0)
		SELECT COUNT(1) Total			   
		FROM   PRODUCTS AS p
		WHERE p.IsHot = @FlagId
	ELSE	
		SELECT COUNT(1) Total			   
		FROM   PRODUCTS AS p
 
END

GO
/****** Object:  StoredProcedure [dbo].[GET_PRODUCT_TYPE_ID]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GET_PRODUCT_TYPE_ID] 
	-- Truyền GroupProducts vào
	@TypeID int
AS
BEGIN
	SELECT  p.*
	FROM    PRODUCTS p INNER JOIN PRODUCT_TYPES pt ON p.ID = pt.ID_Product
	WHERE   pt.ID_Type = @TypeID
	ORDER BY p.DatePublish DESC
END

GO
/****** Object:  StoredProcedure [dbo].[Get_ProductColor_By_ProductId]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Get_ProductColor_By_ProductId] 
	-- Add the parameters for the stored procedure here
	@productId int
AS
BEGIN
	SELECT A.*, B.Price, SelectedId = B.ProductColorId 
	FROM COLORS AS A LEFT JOIN PRODUCT_COLORS AS B ON A.ColorId = B.ColorId AND B.ProductId = @productId
	WHERE A.IsActive = 1
END

GO
/****** Object:  StoredProcedure [dbo].[Get_ProductSize_By_ProductId]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Get_ProductSize_By_ProductId] 
	-- Add the parameters for the stored procedure here
	@productId int
AS
BEGIN
	SELECT A.*, B.Price, SelectedId = B.SizeId 
	FROM SIZES AS A
		LEFT JOIN PRODUCT_SIZES AS B 
	ON A.SizeId = B.SizeId AND B.ProductId = @productId
	WHERE A.IsActive = 1
END

GO
/****** Object:  StoredProcedure [dbo].[GET_SERVICES_PAGING]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GET_SERVICES_PAGING]
	-- Add the parameters for the stored procedure here
	@PageIndex INT = 1,
	@PageSize INT = 10
AS
BEGIN	
	
	SELECT *
	FROM
	(
		SELECT n.*,
			   ROW_NUMBER() OVER (ORDER BY n.Date DESC) Row
		FROM   SERVICES n
	) n
	WHERE n.Row >  (@PageIndex - 1) * @PageSize AND n.Row <= @PageIndex * @PageSize
 
END

GO
/****** Object:  StoredProcedure [dbo].[GET_SERVICES_PAGING_COUNT]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GET_SERVICES_PAGING_COUNT]
	
AS
BEGIN	
		SELECT COUNT(1) Total			   
		FROM   SERVICES n
END

GO
/****** Object:  StoredProcedure [dbo].[GET_SERVICES_PAGING_COUNT_GROUP_SERVICES]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GET_SERVICES_PAGING_COUNT_GROUP_SERVICES]
	@CatID INT
AS
BEGIN

		SELECT COUNT(1) Total			   
		FROM   SERVICES p INNER JOIN dbo.f_GetGROUP_SERVICES_InParent(@CatID) gp ON p.ID_GroupServices = gp.ID		
END

GO
/****** Object:  StoredProcedure [dbo].[GET_SERVICES_PAGING_GROUP_SERVICES]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GET_SERVICES_PAGING_GROUP_SERVICES]
	-- Add the parameters for the stored procedure here
	@CatID INT,
	@PageIndex INT = 1,
	@PageSize INT = 10
AS
BEGIN	

	SELECT *
	FROM
	(
		SELECT p.*,
			   ROW_NUMBER() OVER (ORDER BY p.Date DESC) Row
		FROM   SERVICES p INNER JOIN dbo.f_GetGROUP_SERVICES_InParent(@CatID) gp ON p.ID_GroupServices = gp.ID
		-- WHERE  p.Active = 1
	) p
	WHERE p.Row >  (@PageIndex - 1) * @PageSize AND p.Row <= @PageIndex * @PageSize
 
END

GO
/****** Object:  StoredProcedure [dbo].[GET_USERS_PAGING]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GET_USERS_PAGING]
	-- Add the parameters for the stored procedure here
	@PageIndex INT = 1,
	@PageSize INT = 10
AS
BEGIN

	-- Buoc 1: Danh index cho cac row
	--SELECT u.ID, u.Username,
	--	   ROW_NUMBER() OVER (ORDER BY u.Date DESC) Row
	--FROM   USERS u
	
	-- Buoc 2: lay theo phan trang
	-- Vi du: 1 trang co 10 ban ghi, thi trang 1: row se la tu 1 den 10
	--                                   trang 2: row se la tu 10 den 20
	-- => trang n: row se la (n-1) * 10 den n * 10
	
	-- =>
	
	SELECT *
	FROM
	(
		SELECT u.*,
			   ROW_NUMBER() OVER (ORDER BY u.Date DESC) Row
		FROM   USERS u
	) u
	WHERE u.Row >  (@PageIndex - 1) * @PageSize AND u.Row <= @PageIndex * @PageSize
 
END

GO
/****** Object:  StoredProcedure [dbo].[GET_USERS_PAGING_COUNT]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GET_USERS_PAGING_COUNT]
	
AS
BEGIN
		SELECT COUNT(1) Total			   
		FROM   USERS u 
END

GO
/****** Object:  StoredProcedure [dbo].[GetCategoryProductByCountItemProduct]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCategoryProductByCountItemProduct] 
	-- Lấy ra danh mục sản phẩm và đến xem danh mục đó có bao nhiêu sản phẩm con.
AS
BEGIN
	SET NOCOUNT ON;

    SELECT *,(SELECT COUNT(*) FROM PRODUCTS AS B WHERE B.ID_GroupProduct = A.ID) AS Item 
	FROM GROUP_PRODUCTS AS A
	WHERE A.ParentID = 0
END
GO
/****** Object:  StoredProcedure [dbo].[GetCommentByTypeId]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetCommentByTypeId] 
	@TypeId int = 0, -- 0 is Product, 1 is News
	@PrefixUrl varchar(100) = 'san-pham'
AS
BEGIN
	SET NOCOUNT ON;

	IF(@TypeId = 0) -- FOR PRODUCT
		BEGIN
			SELECT 
				C.*, 
				P.Name AS ProductName, P.[Image] as ProductImage, P.ID as ProductId, P.ID_GroupProduct as ProductCategoryId,
				('/' + @PrefixUrl + '/' + G.Tag + '-' + CAST(G.ID as varchar(10)) + '/' + P.Tag + '-' + CAST(P.ID as varchar(10)) + '.html') as ProductUrl,
				('/' + @PrefixUrl + '/' + G.Tag + '-' + CAST(G.ID as varchar(10)) + '.html') as ProductCategoryUrl
			FROM [dbo].[Comment] as C
				LEFT JOIN [dbo].[PRODUCTS] as P ON C.LinkId = P.ID
				LEFT JOIN [dbo].[GROUP_PRODUCTS] as G ON P.ID_GroupProduct = G.ID
			WHERE C.TypeId = @TypeId ORDER BY C.DateCreated DESC
		END
	ELSE -- FOR NEWS
		BEGIN
			SELECT 
				C.*,
				N.Title as NewsTitle, N.Image as NewsImage, N.ID as NewsId, N.ID_GroupNews as NewsCategoryId,
				('/' + @PrefixUrl + '/' + N.Tag + '-' + CAST(N.ID as varchar(10)) + '.html') as NewsUrl
			FROM [dbo].[Comment] as C
				LEFT JOIN [dbo].[NEWS] as N ON C.LinkId = N.ID
				LEFT JOIN [dbo].[GROUP_NEWS] as G ON N.ID_GroupNews =  G.ID
			WHERE C.TypeId = @TypeId ORDER BY C.DateCreated DESC
		END
END

GO
/****** Object:  StoredProcedure [dbo].[GetProductByKeyword]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetProductByKeyword] 
	-- Lấy ra những sản phẩm có tên giống với keyword đưa vào
	@Keyword NVARCHAR(300),
	@PrefixUrl varchar(50) = 'san-pham'
AS
BEGIN
	SET NOCOUNT ON;
	
	IF(@Keyword IS NOT NULL AND @Keyword <> '')
	BEGIN
		DECLARE @New nvarchar(100) = N'<img src="/Theme/photo/new.png" class="new" alt="Sản phẩm mới" />'
		DECLARE @SaleOff nvarchar(100) = N'<img src="/Theme/photo/sale.png" class="new" alt="Sản phẩm khyến mãi" />'
		
		SELECT 
			P.ID as ProductId, P.Code as ProductCode, P.Name as ProductName, P.Tag as Alias, P.Image as Avatar,
			P.Sapo, P.Content, P.Price, P.PriceOld, P.ID_GroupProduct as ProductCategoryId, P.DatePublish, P.CountView,
			P.CountBuy, P.IsActive, P.IsHot, G.Name as ProductCategoryName, G.Tag as ProductCategoryAlias,
			('/' + @PrefixUrl + '/' + G.Tag + '-' + CAST(G.ID as varchar(10)) + '/' + P.Tag + '-' + CAST(P.ID as varchar(10)) + '.html') as UrlFormat,
			('/' + @PrefixUrl + '/' + G.Tag + '-' + CAST(G.ID as varchar(10)) + '.html') as CategoryUrl,
			P.LinkY as Youtube,
			CASE (SELECT TOP 1 ID_Type FROM PRODUCT_TYPES WHERE ID_Product = P.ID)
				WHEN 1 THEN @New
				WHEN 2 THEN @SaleOff
				ELSE ''
			END as Icon,
			ROW_NUMBER() OVER (ORDER BY p.DatePublish DESC) Row 
		FROM PRODUCTS AS P
			INNER JOIN GROUP_PRODUCTS as G ON P.ID_GroupProduct = G.ID
			INNER JOIN PRODUCT_STATUS as S ON P.StatusID = S.ID
		WHERE 
			P.IsActive = 1 AND
			dbo.fc_ConvertStringVietnamese(P.Name) LIKE '%' + dbo.fc_ConvertStringVietnamese(@Keyword) +'%'
	END
END

GO
/****** Object:  StoredProcedure [dbo].[GetProductPagingByCategoryId]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Lấy sản phẩm và phân trang theo danh mục. Nếu là danh mục cha sẽ lấy cả sản phẩm thuộc cả danh mục con
CREATE PROCEDURE [dbo].[GetProductPagingByCategoryId]
	@CatId Int,
	@PageIndex Int = 1,
	@PageSize Int = 10,
	@PrefixUrl varchar(50) = 'san-pham'
AS
BEGIN
	
	Declare @New nvarchar(100) = N'<img src="/Theme/photo/new.png" class="new" alt="Sản phẩm mới" />'
	Declare @SaleOff nvarchar(100) = N'<img src="/Theme/photo/sale.png" class="new" alt="Sản phẩm khyến mãi" />'

	SELECT *
	FROM
	(
		SELECT 
			P.ID as ProductId, P.Code as ProductCode, P.Name as ProductName, P.Tag as Alias, P.Image as Avatar,
			P.Sapo, P.Content, P.Price, P.PriceOld, P.ID_GroupProduct as ProductCategoryId, P.DatePublish, P.CountView,
			P.CountBuy, P.IsActive, P.IsHot, G.Name as ProductCategoryName, G.Tag as ProductCategoryAlias,
			('/' + @PrefixUrl + '/' + G.Tag + '-' + CAST(G.ID as varchar(10)) + '/' + P.Tag + '-' + CAST(P.ID as varchar(10)) + '.html') as UrlFormat,
			('/' + @PrefixUrl + '/' + G.Tag + '-' + CAST(G.ID as varchar(10)) + '.html') as CategoryUrl,
			Case (Select TOP 1 ID_Type From PRODUCT_TYPES where ID_Product = P.ID)
				When 1 Then @New
				When 2 Then @SaleOff
				Else ''
			End as Icon,
			ROW_NUMBER() OVER (ORDER BY p.DatePublish DESC) Row
		FROM   PRODUCTS as P 
			INNER JOIN dbo.f_GetGROUP_PRODUCTS_InParent(@CatId) GP ON P.ID_GroupProduct = GP.ID
			INNER JOIN GROUP_PRODUCTS as G ON P.ID_GroupProduct = G.ID
	) as N
	WHERE N.Row >  (@PageIndex - 1) * @PageSize AND N.Row <= @PageIndex * @PageSize
 
END
GO
/****** Object:  StoredProcedure [dbo].[GetProductPagingByCategoryIdCount]    Script Date: 2018-07-10 08:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetProductPagingByCategoryIdCount]
	@CatId INT
AS
BEGIN
		SELECT COUNT(1) Total			   
		FROM  PRODUCTS P INNER JOIN dbo.f_GetGROUP_PRODUCTS_InParent(@CatId) as GP ON P.ID_GroupProduct = GP.ID
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0:IsProduct;1:IsNews' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comment', @level2type=N'COLUMN',@level2name=N'TypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0:IsProduct;1:IsNews' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'HashTagLink', @level2type=N'COLUMN',@level2name=N'TypeId'
GO
