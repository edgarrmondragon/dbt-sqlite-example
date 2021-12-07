drop table if exists scanner_data;

create table scanner_data(
  "row_id" INT
  , "date" TEXT
  , "customer_id" TEXT
  , "transaction_id" TEXT
  , "sku_category" TEXT
  , "sku" TEXT
  , "quantity" REAL
  , "sales_amount" REAL
);
