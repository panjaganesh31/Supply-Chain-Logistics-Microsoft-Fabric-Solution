CREATE TABLE [dbo].[fact_sales] (

	[sales_id] bigint NULL, 
	[date_key] bigint NULL, 
	[product_id] bigint NULL, 
	[customer_id] bigint NULL, 
	[quantity_sold] bigint NULL, 
	[unit_price] float NULL, 
	[discount_pct] bigint NULL, 
	[discount_amount] float NULL, 
	[gross_revenue] float NULL, 
	[net_revenue] float NULL, 
	[total_cost] float NULL, 
	[profit] float NULL, 
	[profit_margin_pct] float NULL, 
	[order_number] varchar(8000) NULL
);