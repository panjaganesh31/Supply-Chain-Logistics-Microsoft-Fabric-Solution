CREATE TABLE [dbo].[fact_procurement] (

	[procurement_id] bigint NULL, 
	[order_date_key] bigint NULL, 
	[product_id] bigint NULL, 
	[supplier_id] bigint NULL, 
	[order_quantity] bigint NULL, 
	[unit_cost] float NULL, 
	[total_cost] float NULL, 
	[lead_time_days] bigint NULL, 
	[delivery_date_key] bigint NULL, 
	[quality_score] float NULL, 
	[po_number] varchar(8000) NULL
);