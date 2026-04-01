CREATE TABLE [dbo].[dim_supplier] (

	[supplier_id] bigint NULL, 
	[supplier_key] varchar(8000) NULL, 
	[supplier_name] varchar(8000) NULL, 
	[country] varchar(8000) NULL, 
	[city] varchar(8000) NULL, 
	[specialty] varchar(8000) NULL, 
	[tier] varchar(8000) NULL, 
	[avg_quality_score] float NULL
);