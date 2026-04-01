CREATE TABLE [dbo].[dim_facility] (

	[facility_id] bigint NULL, 
	[facility_key] varchar(8000) NULL, 
	[facility_name] varchar(8000) NULL, 
	[country] varchar(8000) NULL, 
	[city] varchar(8000) NULL, 
	[facility_type] varchar(8000) NULL, 
	[specialization] varchar(8000) NULL, 
	[annual_capacity] bigint NULL
);