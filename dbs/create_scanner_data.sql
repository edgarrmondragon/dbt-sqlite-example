drop table if exists scanner_data;

create table scanner_data(
  "row_id" numeric
  , "date" text
  , "customer_id" text
  , "transaction_id" text
  , "sku_category" text
  , "sku" text
  , "quantity" numeric
  , "sales_amount" numeric
);
