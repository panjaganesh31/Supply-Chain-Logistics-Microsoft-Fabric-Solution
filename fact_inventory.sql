CREATE TABLE [dbo].[fact_inventory] (

	[inventory_id] bigint NULL, 
	[date_key] bigint NULL, 
	[product_id] bigint NULL, 
	[facility_id] bigint NULL, 
	[stock_level] bigint NULL, 
	[safety_stock_level] bigint NULL, 
	[reorder_point] bigint NULL
);