CREATE TABLE [dbo].[fact_production] (

	[production_id] bigint NULL, 
	[date_key] bigint NULL, 
	[product_id] bigint NULL, 
	[facility_id] bigint NULL, 
	[quantity_produced] bigint NULL, 
	[defective_units] bigint NULL, 
	[defect_rate_pct] float NULL, 
	[batch_number] varchar(8000) NULL
);