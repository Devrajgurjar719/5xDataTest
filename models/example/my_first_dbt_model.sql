
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='Table') }}

with source_data as (

    select 1 as id
    union all
    select null as id

)

select *
from source_data

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null


--Create table Country_Info as select distinct country, Continent from "FIVETRAN_INTERVIEW_DB"."GOOGLE_SHEETS"."COVID_19_INDONESIA_DEVRAJ_GURJAR"

--Create Table Location_Info as SELECT Location , Location_iso_code, Island, Latitude, Longitude From  "FIVETRAN_INTERVIEW_DB"."GOOGLE_SHEETS"."COVID_19_INDONESIA_DEVRAJ_GURJAR" Where Location_level = 'Province'

--Create Table Country_wise_cases as SELECT DAte, Total_Recovered, Total_Cases_per_million, Total_active_cases, New_Cases, New_Deaths  From  "FIVETRAN_INTERVIEW_DB"."GOOGLE_SHEETS"."COVID_19_INDONESIA_DEVRAJ_GURJAR" Where Location_level = 'Country'

--Create table Province_wise_cases as SELECT Date, LOCATION_ISO_CODE ,Total_Recovered, Total_Cases_per_million, Total_active_cases, New_Cases, New_Deaths  From  "FIVETRAN_INTERVIEW_DB"."GOOGLE_SHEETS"."COVID_19_INDONESIA_DEVRAJ_GURJAR" Where Location_level = 'Province'


---Create table Country_info as SELECT Distinct Country, Continent, LOCATION_ISO_CODE From  "FIVETRAN_INTERVIEW_DB"."GOOGLE_SHEETS"."COVID_19_INDONESIA_DEVRAJ_GURJAR" Where LOCATION_ISO_CODE = 'IDN'

--CREATE TABLE Location_Wise_general_data as SELECT TOTAL_Regencies, POPULATION_DENSITY, POPULATION, TOTAL_CITIES, TOTAL_DISTRICTS, TOTAL_URBAN_VILLAGES, AREA_KM_2_, LOCATION_ISO_CODE
---from "FIVETRAN_INTERVIEW_DB"."GOOGLE_SHEETS"."COVID_19_INDONESIA_DEVRAJ_GURJAR"

--CREATE TABLE Location_Wise_Covid_Stats as 
--SELECT TOTAL_CASES_PER_MILLION, GROWTH_FACTOR_OF_NEW_DEATHS, NEW_CASES_PER_MILLION, NEW_DEATHS_PER_MILLION, CASE_FATALITY_RATE, CASE_RECOVERED_RATE,
--TOTAL_DEATHS_PER_MILLION, GROWTH_FACTOR_OF_NEW_CASES, LOCATION_ISO_CODE
--from "FIVETRAN_INTERVIEW_DB"."GOOGLE_SHEETS"."COVID_19_INDONESIA_DEVRAJ_GURJAR"

Create table Final_Denormalized_Data as 
    select 
        --COUNTRY.*, 
        Location_Info.Location, Location_Info.Location_iso_code,Location_Info.Island, Location_Info.Latitude,Location_Info.Longitude,
        Province_wise_cases.Date, Province_wise_cases.Total_Recovered,Province_wise_cases.Total_Cases_per_million, Province_wise_cases.Total_active_cases,
        Location_Wise_Covid_Stats.NEW_CASES_PER_MILLION, Location_Wise_Covid_Stats.NEW_DEATHS_PER_MILLION, Location_Wise_Covid_Stats.CASE_FATALITY_RATE, Location_Wise_Covid_Stats.CASE_RECOVERED_RATE
    from Location_Info
    --join LOCATIONS on COUNTRY.LOCATION_ISO_CODE = LOCATIONS.LOCATION_ISO_CODE
    join Province_wise_cases on Location_Info.LOCATION_ISO_CODE = Province_wise_cases.LOCATION_ISO_CODE
	  join Location_Wise_Covid_Stats on Location_Info.LOCATION_ISO_CODE = Location_Wise_Covid_Stats.LOCATION_ISO_CODE

limit 10000
