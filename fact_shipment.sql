CREATE TABLE [dbo].[fact_shipment] (

	[shipment_id] bigint NULL, 
	[ship_date_key] bigint NULL, 
	[delivery_date_key] bigint NULL, 
	[product_id] bigint NULL, 
	[facility_id] bigint NULL, 
	[customer_id] bigint NULL, 
	[quantity] bigint NULL, 
	[carrier] varchar(8000) NULL, 
	[status] varchar(8000) NULL, 
	[shipping_cost] float NULL, 
	[total_weight_kg] float NULL, 
	[tracking_number] varchar(8000) NULL, 
	[delay_reason] varchar(8000) NULL
);