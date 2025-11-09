select 
    plantname,
    plantid,
    date_format(from_unixtime(createddate+86400),'%Y-%m-%d') as day, 
    SUM(CAST(REPLACE(NULLIF(daygeneration, 'NA'), ',', '') AS DECIMAL(10,2))) as actual_solar
from 
    invgeneration
    where plantid IN (23) 
    group by day,plantname,plantid 
    order by day,plantname;


1.date_format(from_unixtime(createddate+86400),'%Y-%m-%d') as day, 
  🧩 Explanation
Part	Meaning
FROM_UNIXTIME(createddate + 86400)	Converts the UNIX timestamp (in seconds) to a MySQL datetime — adding 86400 seconds = 1 day shift
DATE_FORMAT(..., '%Y-%m-%d')	Formats that datetime to only show the date in YYYY-MM-DD format
AS day	Gives the formatted date an alias (column name) called day


🧩 2️⃣ SUM(CAST(REPLACE(NULLIF(ig.daygeneration, 'NA'), ',', '') AS DECIMAL(10,2)))

Purpose:
👉 To clean and convert text data (like '1,234.56' or 'NA') into a proper number before summing.

Behavior:

NULLIF(ig.daygeneration, 'NA') → converts 'NA' to NULL (so it won’t cause error).

REPLACE(..., ',', '') → removes commas from values like '1,234.56' → '1234.56'.

CAST(... AS DECIMAL(10,2)) → converts that clean string to a proper decimal number.

SUM(...) → adds all cleaned numeric values together.
