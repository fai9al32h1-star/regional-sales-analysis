select region,
avg(discount) as avg_discount,
avg(unit_price) as avg_price,
count(order_id) as total_orders
from SuperStore
group by region
order by avg_discount desc;

select region, year(order_date) as order_year, avg(unit_price) as avg_price,
sum(sales) as total_sales, avg(discount) * 100 as avg_discount
from SuperStore
group by region, year(order_date)
order by region, order_year;

select region, avg(unit_price) as avg_price,
sum(sales) as total_sales, avg(discount) * 100 as avg_discount, count(distinct customer_name) as unique_customers,
sum(sales) / count(distinct customer_name) as sales_per_customer
from SuperStore
group by region
order by unique_customers desc;


create table region_population (
region nvarchar(100),
population int
);

INSERT INTO Region_Population (Region, Population) VALUES
('Ontario', 14223942),
('Quebec', 8501833),
('West', 9263514),
('Prarie', 2474658),
('Atlantic', 2409874),
('Northwest Territories', 41070),
('Yukon', 40232),
('Nunavut', 36858);


-- Population updated to reflect the full 2009-2012 study period.
-- Values below are population SUMMED across the four sales years
-- (2009 + 2010 + 2011 + 2012), based on official annual estimates.
UPDATE region_population
SET population = CASE region
    WHEN 'Ontario' THEN 52842000
    WHEN 'West' THEN 41197800
    WHEN 'Quebec' THEN 31670800
    WHEN 'Prarie' THEN 23299900   
    WHEN 'Atlantic' THEN 9373700
    WHEN 'Northwest Territories' THEN 174100
    WHEN 'Yukon' THEN 139400
    WHEN 'Nunavut' THEN 133300
    ELSE population 
END
WHERE region IN ('Ontario', 'West', 'Quebec', 'Prarie', 'Atlantic', 'Northwest Territories', 'Yukon', 'Nunavut');

-- Final metric: Customers per 100,000 Population.
--
-- Methodology note: population above is SUMMED across 2009-2012, but
-- population is a "stock" (a point-in-time count), not a "flow" like
-- sales, so it should not be summed across years the way revenue can be.
-- Dividing by 4.0 recovers the average annual population -- the
-- statistically defensible denominator to pair against unique customers,
-- which are already counted once per person (not once per year).
select s.Region,
count(distinct s.customer_name) as unique_customer, 
p.population / 4.0 as avg_population,
cast(count(distinct s.customer_name)as float)/(p.population/ 4.0 ) * 100000.0 as customer_per_100k
from SuperStore s
join region_population p on s.region = p.region
group by s.Region, p.population
order by customer_per_100k desc;
