select id, 
first_name,
last_name,
email 
from {{source('datafeed_shared_schema','customer')}}