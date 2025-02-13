
  
    

        create or replace transient table weather.data.pressure_drops
         as
        (WITH weather_data AS (
    SELECT 
        datetime, 
        pressure, 
        LAG(pressure) OVER (ORDER BY datetime) AS prev_pressure,
        (pressure - LAG(pressure) OVER (ORDER BY datetime)) AS pressure_change,
        CASE 
            WHEN (pressure - LAG(pressure) OVER (ORDER BY datetime)) < -2 THEN 'Yes'
            ELSE 'No'
        END AS pressure_drop
    FROM weather.data.custom_daily_weather_view
)
SELECT 
    datetime, 
    pressure, 
    prev_pressure, 
    pressure_change, 
    pressure_drop
FROM weather_data
        );
      
  