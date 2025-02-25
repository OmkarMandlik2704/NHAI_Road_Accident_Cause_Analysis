create database Accidents;
use accidents;
select * from accident;

# 1 Retrieve all accident records for the year 2023.
create view Accident_Records_2023 as
SELECT * FROM accident
WHERE YEAR(Date) = 2023;

#2.	Find the total number of accidents per location.
create view Accident_count_per_Location as
select Location,  count(Casualties)
from accident 
group by Location;

#3.	Get the average emergency response time for different accident causes.
ALTER TABLE accident 
CHANGE COLUMN `Emergency_Response_Time (mins)` `Emergency_Response_Time` INT;

create view Avg_Ememrgency_response_time_per_cause as
select Cause, avg(Emergency_Response_Time ) as Avg_response_time
from accident 
group by Cause;

#4.	List the top 5 accident-prone areas based on accident count.
create view accident_prone_areas as
select Location, count(Casualties) as Top_5_accident_prone_areas 
from accident
group by Location
order by Top_5_accident_prone_areas DESC LIMIT 5;

#5.	Retrieve all accident cases where casualties are more than 3.
create view Cases_with_Casulties as
select Cause,Casualties from
accident 
where Casualties > '3';

#6.	Find the number of accidents involving drunk driving
create view durnk_drive_accidents as
SELECT COUNT(*) AS Total_Accidents
FROM accident
WHERE Cause LIKE '%Drunk%';

#7.	Find the average vehicle age involved in accidents.
ALTER TABLE accident CHANGE COLUMN `Vehicle_Age (Years)` `Vehicles_Age` INT;
create view Avg_Vehicles_Age as
select avg(Vehicles_Age) from accident;

#8.	Retrieve accident cases where emergency response time was more than 30 minutes.
create view emergency_response_time_30mins as
select Cause,Emergency_Response_Time from 
accident 
where Emergency_Response_Time > '30';

#9. Get the count of accidents for each weather condition
create view accidents_count_by_weather as
select Weather , count(Casualties) as accident_count_for_weather_condition 
from accident
group by Weather
order by accident_count_for_weather_condition ;

#10.	Get the percentage of accidents where safety measures (seatbelts, helmets) were used
create view Accident_percentage_for_safetymaeasuers_used_ones as
SELECT 
    (COUNT(*) / (SELECT COUNT(*) FROM accident)) * 100 AS Percentage_Safety_Measures_Used
FROM accident
WHERE Safety_Measures_Used IN ('Seatbelt', 'Airbag Deployed', 'Helmet');
