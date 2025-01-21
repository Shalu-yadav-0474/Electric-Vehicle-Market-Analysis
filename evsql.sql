DROP TABLE IF EXISTS EV_states;
CREATE TABLE EV_states(
       date	DATE ,
	   state VARCHAR(25),	
	   vehicle_category	VARCHAR(20),
	   electric_vehicles_sold INT,	
	   total_vehicles_sold INT
);


DROP TABLE IF EXISTS EV_makers;
CREATE TABLE EV_makers(
       date DATE,	
	   vehicle_category VARCHAR(20),
	   maker VARCHAR(20) ,	
	   electric_vehicles_sold INT

);

DROP TABLE IF EXISTS fiscal_years;
CREATE TABLE fiscal_years(
     date DATE,	
	 fiscal_year INT,	
	 quarter VARCHAR(5)
);

SELECT * FROM EV_makers

SELECT * FROM EV_states

SELECT * FROM fiscal_years

--write sql query to find out overall ev vehicles sold and total vehicle sold
SELECT
  t2.fiscal_year,
  SUM(t1.total_vehicles_sold) as total_vehicle,
  SUM(t1.electric_vehicles_sold) as EV_vehicle
FROM 
   EV_states AS t1
INNER JOIN 
   fiscal_years AS t2
 ON   
   t1.date = t2.date
 GROUP BY t2.fiscal_year 
 ORDER BY t2.fiscal_year ASC;


-- write sql query to know how many ev vehicles were sold in each year
SELECT
    t2.fiscal_year,
    SUM(CASE WHEN t1.vehicle_category = '2' THEN t1.electric_vehicles_sold ELSE 0 END) AS EV_2Wheeler,
    SUM(CASE WHEN t1.vehicle_category = '4' THEN t1.electric_vehicles_sold ELSE 0 END) AS EV_4Wheeler
FROM 
    EV_states AS t1
INNER JOIN 
    fiscal_years AS t2
ON 
    t1.date = t2.date
GROUP BY 
    t2.fiscal_year
ORDER BY 
    t2.fiscal_year ASC;


-- write sql query to know how many ev vehicles were sold overall
SELECT
    SUM(CASE WHEN t1.vehicle_category = '2' THEN t1.electric_vehicles_sold ELSE 0 END) AS EV_2Wheeler,
    SUM(CASE WHEN t1.vehicle_category = '4' THEN t1.electric_vehicles_sold ELSE 0 END) AS EV_4Wheeler
FROM 
    EV_states AS t1
INNER JOIN 
    fiscal_years AS t2
ON 
    t1.date = t2.date

-- write sql query to know how many ev vehicles were sold in each state in each year
SELECT
    t1.state,
    t2.fiscal_year,
    SUM(t1.electric_vehicles_sold) AS total_ev_sales
FROM 
    EV_states AS t1
INNER JOIN 
    fiscal_years AS t2
ON 
    t1.date = t2.date
GROUP BY 
    t1.state, t2.fiscal_year
ORDER BY 
    t1.state ASC, t2.fiscal_year ASC;

-- write sql query to know how many ev vehicles were sold in each state in each year vehicle category wise
SELECT
    t1.state,
    SUM(t1.electric_vehicles_sold) AS total_ev_sales,
    SUM(CASE WHEN t1.vehicle_category = '2' THEN t1.electric_vehicles_sold ELSE 0 END) AS total_2_wheelers_sold,
    SUM(CASE WHEN t1.vehicle_category = '4' THEN t1.electric_vehicles_sold ELSE 0 END) AS total_4_wheelers_sold
FROM 
    EV_states AS t1
GROUP BY 
    t1.state
ORDER BY 
    t1.state ASC;

-- write sql query to find top 5 states in sales of ev in each vehicle category
SELECT
    t1.state,
    SUM(t1.electric_vehicles_sold) AS total_ev_sales,
    SUM(CASE WHEN t1.vehicle_category = '2' THEN t1.electric_vehicles_sold ELSE 0 END) AS two_wheeler_sales,
    SUM(CASE WHEN t1.vehicle_category = '4' THEN t1.electric_vehicles_sold ELSE 0 END) AS four_wheeler_sales
FROM 
    EV_states AS t1
GROUP BY 
    t1.state
ORDER BY 
    total_ev_sales DESC
LIMIT 5;

-- write sql query to find 5 states in sales of ev in each vehicle category sold least
SELECT
    t1.state,
    SUM(t1.electric_vehicles_sold) AS total_ev_sales,
    SUM(CASE WHEN t1.vehicle_category = '2' THEN t1.electric_vehicles_sold ELSE 0 END) AS two_wheeler_sales,
    SUM(CASE WHEN t1.vehicle_category = '4' THEN t1.electric_vehicles_sold ELSE 0 END) AS four_wheeler_sales
FROM 
    EV_states AS t1
GROUP BY 
    t1.state
ORDER BY 
    total_ev_sales ASC
LIMIT 5;

-- write sql query to find total ev sales of each ev maker
SELECT
    t2.maker,
    SUM(t2.electric_vehicles_sold) AS total_ev_sales
FROM
    EV_makers AS t2
GROUP BY
    t2.maker
ORDER BY
    total_ev_sales DESC;

-- write sql query to find ev sales of each ev maker in each year
SELECT 
    t1.maker,
    t2.fiscal_year,
    SUM(t1.electric_vehicles_sold) AS total_ev_sales
FROM 
    EV_makers AS t1
INNER JOIN 
    fiscal_years AS t2
ON 
    t1.date = t2.date
GROUP BY 
    t1.maker, t2.fiscal_year
ORDER BY 
    t1.maker ASC, t2.fiscal_year ASC;

-- write sql query to find which maker is of 2-wheeler ev
SELECT
 DISTINCT maker,
  '2-wheeler' AS vehicle_type
FROM
  EV_makers
WHERE
  vehicle_category = '2-Wheelers'

-- write sql query to find which maker is of 4-wheeler ev
SELECT
  DISTINCT maker,
  '4-wheeler' AS vehicle_type
FROM
  EV_makers
WHERE
  vehicle_category = '4-Wheelers';

-- write sql query to find how much total ev sold in each quater of each year
SELECT
    f.fiscal_year,
    f.quarter,
    SUM(e.electric_vehicles_sold) AS total_ev_sales
FROM
    EV_states AS e
INNER JOIN
    fiscal_years AS f
ON
    e.date = f.date
GROUP BY
    f.fiscal_year,
    f.quarter
ORDER BY
    f.fiscal_year ASC,
    f.quarter ASC;

-- write sql query to find how much average ev sold in each quater of each year
SELECT
    f.fiscal_year,
    f.quarter,
    ROUND(avg(e.electric_vehicles_sold),2) AS total_ev_sold
FROM
    EV_states AS e
INNER JOIN
    fiscal_years AS f
ON
    e.date = f.date
GROUP BY
    f.fiscal_year,
    f.quarter
ORDER BY
    f.fiscal_year ASC,
    f.quarter ASC;

-- write sql query to find ech ev maker of 2 wheeler and their ev sales for each year
SELECT
  t2.fiscal_year,
  t1.maker,
  SUM(t1.electric_vehicles_sold) AS total_two_wheeler_sales
FROM
  EV_makers AS t1
INNER JOIN
  fiscal_years AS t2
ON
  t1.date = t2.date
WHERE
  t1.vehicle_category = '2-Wheelers'
GROUP BY
  t2.fiscal_year,
  t1.maker
ORDER BY
  t2.fiscal_year ASC, total_two_wheeler_sales DESC;

-- write sql query to find ech ev maker of 4 wheeler and their ev sales for each year
 SELECT
  t2.fiscal_year,
  t1.maker,
  SUM(t1.electric_vehicles_sold) AS total_two_wheeler_sales
FROM
  EV_makers AS t1
INNER JOIN
  fiscal_years AS t2
ON
  t1.date = t2.date
WHERE
  t1.vehicle_category = '4-Wheelers'
GROUP BY
  t2.fiscal_year,
  t1.maker
ORDER BY
  t2.fiscal_year ASC, total_two_wheeler_sales DESC; 


  -- write sql query to find top 5 ev makers in terms of sales in 2 wheeler category 
 SELECT
  t1.maker,
  SUM(t1.electric_vehicles_sold) AS total_two_wheeler_sales
FROM
  EV_makers AS t1
WHERE
  t1.vehicle_category = '2-Wheelers'
GROUP BY
  t1.maker
ORDER BY
  total_two_wheeler_sales DESC
LIMIT 5; 

 -- write sql query to find top 5 ev makers in terms of sales in 4 wheeler category 
SELECT
  t1.maker,
  SUM(t1.electric_vehicles_sold) AS total_two_wheeler_sales
FROM
  EV_makers AS t1
WHERE
  t1.vehicle_category = '4-Wheelers'
GROUP BY
  t1.maker
ORDER BY
  total_two_wheeler_sales DESC
LIMIT 5; 

--write sql query to analyse states and sales growth rate over years

WITH StateYearlySales AS (
  SELECT
    t1.state,
    t2.fiscal_year,
    SUM(t1.electric_vehicles_sold) AS total_ev_sales
  FROM
    EV_states AS t1
  INNER JOIN
    fiscal_years AS t2
  ON
    t1.date = t2.date
  GROUP BY
    t1.state, t2.fiscal_year
),
StateGrowthRate AS (
  SELECT
    a.state,
    a.fiscal_year AS current_year,
    a.total_ev_sales AS current_sales,
    b.total_ev_sales AS previous_sales,
    CASE 
      WHEN b.total_ev_sales > 0 THEN 
        ROUND(((a.total_ev_sales - b.total_ev_sales) * 100.0 / b.total_ev_sales), 2)
      ELSE 
        NULL
    END AS growth_rate_percentage
  FROM
    StateYearlySales AS a
  LEFT JOIN
    StateYearlySales AS b
  ON
    a.state = b.state
    AND a.fiscal_year = b.fiscal_year + 1
)
SELECT
  state,
  current_year,
  current_sales,
  previous_sales,
  growth_rate_percentage
FROM
  StateGrowthRate
ORDER BY
  state, 
  current_year DESC;

--write sql query to analyse makers and sales growth rate over years.
WITH makerYearlySales AS (
  SELECT
    t1.maker,
    t2.fiscal_year,
    SUM(t1.electric_vehicles_sold) AS total_ev_sales
  FROM
    EV_makers AS t1
  INNER JOIN
    fiscal_years AS t2
  ON
    t1.date = t2.date
  GROUP BY
    t1.maker, t2.fiscal_year
),
makerGrowthRate AS (
  SELECT
    a.maker,
    a.fiscal_year AS current_year,
    a.total_ev_sales AS current_sales,
    b.total_ev_sales AS previous_sales,
    CASE 
      WHEN b.total_ev_sales > 0 THEN 
        ROUND(((a.total_ev_sales - b.total_ev_sales) * 100.0 / b.total_ev_sales), 2)
      ELSE 
        NULL
    END AS growth_rate_percentage
  FROM
    makerYearlySales AS a
  LEFT JOIN
    makerYearlySales AS b
  ON
    a.maker = b.maker
    AND a.fiscal_year = b.fiscal_year + 1
)
SELECT
  maker,
  current_year,
  current_sales,
  previous_sales,
  growth_rate_percentage
FROM
  makerGrowthRate
ORDER BY
  maker, 
  current_year DESC

  