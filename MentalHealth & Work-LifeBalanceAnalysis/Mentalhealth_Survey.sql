-- CREATE DATABASE 
create database mentalhealthDB

--USE DATABASE
use mentalhealthDB;

--TO VIEW
SELECT TOP 10 * FROM mental_health_worklife_survey;

-- AGE AND GENDER DISTRIBUTION
SELECT Gender, COUNT(*) AS Total_Employees, AVG(Age) AS Avg_Age
FROM mental_health_worklife_survey
GROUP BY Gender;

-- HOW BURNOUT VARIES BY DEPARTMENT
SELECT Department, Burnout_Level, COUNT(*) AS Count_Burnout
FROM mental_health_worklife_survey
GROUP BY Department, Burnout_Level
ORDER BY Department;

-- COMPARE REMOTE VS. ON-SITE EMPLOYEES
SELECT Remote_Work,AVG(Productivity_Score) AS Avg_Productivity,SUM(CASE WHEN Burnout_Level = 'High' THEN 1 ELSE 0 END) AS High_Burnout_Employees
FROM mental_health_worklife_survey
GROUP BY Remote_Work;

-- DOES SUPPORT REDUCE BURNOUT OR INCREASE SATISFACTION
SELECT Company_MH_Support,AVG(Productivity_Score) AS Avg_Productivity,AVG(Mental_Health_Days_Missed) AS Avg_Days_Missed,COUNT(*) AS Employees_Count
FROM mental_health_worklife_survey
GROUP BY Company_MH_Support;

-- CORRELATION BETWEEN STRESS AND SATISFACTION
SELECT Stress_Level, Job_Satisfaction, COUNT(*) AS Count_Employees
FROM mental_health_worklife_survey
GROUP BY Stress_Level, Job_Satisfaction;