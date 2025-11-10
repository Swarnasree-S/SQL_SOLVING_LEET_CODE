SELECT
    w.month,

    -- Expected Energy per plant
    SUM(CASE WHEN w.plantid = 23 THEN w.Expected_Energy END) AS Expected_Energy_23,
    SUM(CASE WHEN w.plantid = 24 THEN w.Expected_Energy END) AS Expected_Energy_24,
    SUM(CASE WHEN w.plantid = 29 THEN w.Expected_Energy END) AS Expected_Energy_29,
    SUM(CASE WHEN w.plantid = 30 THEN w.Expected_Energy END) AS Expected_Energy_30,

    -- Total Generation per plant
    SUM(CASE WHEN g.plantid = 23 THEN g.total_generation END) AS total_generation_23,
    SUM(CASE WHEN g.plantid = 24 THEN g.total_generation END) AS total_generation_24,
    SUM(CASE WHEN g.plantid = 29 THEN g.total_generation END) AS total_generation_29,
    SUM(CASE WHEN g.plantid = 30 THEN g.total_generation END) AS total_generation_30,

    -- Forecasting Energy per plant (from forecasting table)
    MAX(
        CASE 
            WHEN w.plantid = 23 THEN 
                CASE 
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 1 THEN f23.jan
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 2 THEN f23.feb
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 3 THEN f23.mar
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 4 THEN f23.apr
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 5 THEN f23.may
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 6 THEN f23.june
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 7 THEN f23.july
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 8 THEN f23.aug
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 9 THEN f23.sept
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 10 THEN f23.oct
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 11 THEN f23.nov
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 12 THEN f23.decm
                END
        END
    ) AS Forecasting_Energy_23,

    MAX(
        CASE 
            WHEN w.plantid = 24 THEN 
                CASE 
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 1 THEN f24.jan
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 2 THEN f24.feb
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 3 THEN f24.mar
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 4 THEN f24.apr
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 5 THEN f24.may
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 6 THEN f24.june
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 7 THEN f24.july
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 8 THEN f24.aug
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 9 THEN f24.sept
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 10 THEN f24.oct
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 11 THEN f24.nov
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 12 THEN f24.decm
                END
        END
    ) AS Forecasting_Energy_24,

    MAX(
        CASE 
            WHEN w.plantid = 29 THEN 
                CASE 
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 1 THEN f29.jan
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 2 THEN f29.feb
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 3 THEN f29.mar
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 4 THEN f29.apr
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 5 THEN f29.may
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 6 THEN f29.june
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 7 THEN f29.july
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 8 THEN f29.aug
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 9 THEN f29.sept
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 10 THEN f29.oct
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 11 THEN f29.nov
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 12 THEN f29.decm
                END
        END
    ) AS Forecasting_Energy_29,

    MAX(
        CASE 
            WHEN w.plantid = 30 THEN 
                CASE 
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 1 THEN f30.jan
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 2 THEN f30.feb
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 3 THEN f30.mar
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 4 THEN f30.apr
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 5 THEN f30.may
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 6 THEN f30.june
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 7 THEN f30.july
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 8 THEN f30.aug
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 9 THEN f30.sept
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 10 THEN f30.oct
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 11 THEN f30.nov
                    WHEN MONTH(STR_TO_DATE(CONCAT(w.month, '-01'), '%Y-%m-%d')) = 12 THEN f30.decm
                END
        END
    ) AS Forecasting_Energy_30,

    -- DC Capacity per plant
    MAX(CASE WHEN w.plantid = 23 THEN w.Dccapacity END) AS Dccapacity_23,
    MAX(CASE WHEN w.plantid = 24 THEN w.Dccapacity END) AS Dccapacity_24,
    MAX(CASE WHEN w.plantid = 29 THEN w.Dccapacity END) AS Dccapacity_29,
    MAX(CASE WHEN w.plantid = 30 THEN w.Dccapacity END) AS Dccapacity_30,

    -- Day Irradiation per plant
    SUM(CASE WHEN w.plantid = 23 THEN w.dayIrradiation END) AS dayIrradiation_23,
    SUM(CASE WHEN w.plantid = 24 THEN w.dayIrradiation END) AS dayIrradiation_24,
    SUM(CASE WHEN w.plantid = 29 THEN w.dayIrradiation END) AS dayIrradiation_29,
    SUM(CASE WHEN w.plantid = 30 THEN w.dayIrradiation END) AS dayIrradiation_30,

    -- Specific Yield per plant (kWh/kW)
    MAX(CASE WHEN w.plantid = 23 THEN g.Specific_Yield END) AS SpecificYield_23,
    MAX(CASE WHEN w.plantid = 24 THEN g.Specific_Yield END) AS SpecificYield_24,
    MAX(CASE WHEN w.plantid = 29 THEN g.Specific_Yield END) AS SpecificYield_29,
    MAX(CASE WHEN w.plantid = 30 THEN g.Specific_Yield END) AS SpecificYield_30

FROM (
    SELECT
        ws.plantid,
        ws.plantname,
        pi.Dccapacity,
        DATE_FORMAT(FROM_UNIXTIME(ws.createddate + 86400), '%Y-%m') AS month,
        SUM(ws.dayIrradiation * (pi.Dccapacity * 1000)) AS Expected_Energy,
        SUM(ws.dayIrradiation) AS dayIrradiation
    FROM weatherstation ws
    INNER JOIN plantinfo pi
        ON ws.plantid = pi.plantid
    WHERE ws.plantid IN (23, 24, 29, 30)
    GROUP BY ws.plantid, ws.plantname, pi.Dccapacity, month
) w
INNER JOIN (
    SELECT
        ig.plantid,
        ig.plantname,
        pi.Dccapacity,  
        DATE_FORMAT(FROM_UNIXTIME(ig.createddate + 86400), '%Y-%m') AS month,
        SUM(CAST(REPLACE(ig.daygeneration, ',', '') AS DECIMAL(10,2)) / (pi.Dccapacity * 1000)) AS Specific_Yield,
        SUM(CAST(REPLACE(ig.daygeneration, ',', '') AS DECIMAL(10,2))) as total_generation
    FROM invgeneration ig
    INNER JOIN plantinfo pi
       ON ig.plantid = pi.plantid
    WHERE ig.plantid IN (23, 24, 29, 30)
    GROUP BY ig.plantid, ig.plantname, pi.Dccapacity, month
) g
    ON w.plantid = g.plantid AND w.month = g.month

-- Join forecasting table for each plant
LEFT JOIN forecasting f23 ON f23.plantid = 23
LEFT JOIN forecasting f24 ON f24.plantid = 24
LEFT JOIN forecasting f29 ON f29.plantid = 29
LEFT JOIN forecasting f30 ON f30.plantid = 30

GROUP BY w.month
ORDER BY w.month;
