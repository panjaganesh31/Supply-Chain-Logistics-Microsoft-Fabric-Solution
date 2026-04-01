CREATE TABLE [dbo].[dim_product] (

	[product_id] bigint NULL, 
	[product_key] varchar(8000) NULL, 
	[product_name] varchar(8000) NULL, 
	[category] varchar(8000) NULL, 
	[product_line] varchar(8000) NULL, 
	[spec] varchar(8000) NULL, 
	[color] varchar(8000) NULL, 
	[unit_price] float NULL, 
	[unit_cost] float NULL, 
	[weight_kg] float NULL, 
	[Img] varchar(8000) NULL
);