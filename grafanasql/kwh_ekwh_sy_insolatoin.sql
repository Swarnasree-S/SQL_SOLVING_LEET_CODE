select 
    ig.day,
    ig.plantname,
    ig.plantid, 
    ig.solar,
    pi.Dccapacity,
    ws.expectedenergy,
    ws.dayIrradiation,
    ig.SY
from (
    select 
       ig.plantname,
       ig.plantid,
       pi.Dccapacity,
       date_format(from_unixtime(ig.createddate+86400),'%Y-%m-%d') as day,
       sum(cast(replace(nullif(ig.daygeneration,'NA'),',','') as decimal(10,2))) as solar,
       sum(cast(replace(nullif(ig.daygeneration,'NA'),',','') as decimal(10,2))/pi.Dccapacity) as SY
    from invgeneration ig
    join plantinfo pi on ig.plantid=pi.plantid
    group by day,ig.plantid,ig.plantname,pi.Dccapacity
 )ig 
join (
    select 
      date_format(from_unixtime(ws.createddate+86400),'%Y-%m-%d') as day,
      pi.Dccapacity,
      ws.plantid,
      ws.plantname,
      SUM(ws.dayIrradiation) AS dayIrradiation,
      sum(ws.dayIrradiation * (pi.Dccapacity*1000)) as expectedenergy
    from weatherstation ws
    join plantinfo pi on ws.plantid=pi.plantid
    group by day,ws.plantid,ws.plantname,pi.DCcapacity
 )ws 
on ig.plantid=ws.plantid AND ig.day = ws.day
JOIN plantinfo pi ON ig.plantid = pi.plantid
ORDER BY ig.day, ig.plantid;

                 
               
