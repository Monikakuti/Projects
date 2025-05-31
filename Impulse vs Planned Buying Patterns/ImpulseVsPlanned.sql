create database ImpulseBuyingDB

use ImpulseBuyingDB;

SELECT TOP 10 * FROM impulse_planned;

-- Count rows with missing category
SELECT COUNT(*) AS MissingCategoryCount
FROM impulse_planned
WHERE Category IS NULL;

-- Fill with 'Unknown'
UPDATE impulse_planned
SET Category = 'Unknown'
WHERE Category IS NULL;

-- Check empty User IDs
SELECT COUNT(*) AS EmptyUserIDCount
FROM impulse_planned
WHERE LTRIM(RTRIM(User_ID)) = '';

-- Delete empty User_ID records
DELETE FROM impulse_planned
WHERE LTRIM(RTRIM(User_ID)) = '';

-- Identify rows with negative durations
SELECT * 
FROM impulse_planned
WHERE Cart_Duration_Minutes < 0;

-- Set them to NULL 
UPDATE impulse_planned
SET Cart_Duration_Minutes = NULL
WHERE Cart_Duration_Minutes < 0;

-- Check how many rows have null purchase timestamps
SELECT COUNT(*) AS NullPurchaseTimestamps
FROM impulse_planned
WHERE Purchase_Timestamp IS NULL;

--To remove
DELETE FROM impulse_planned
WHERE Purchase_Timestamp IS NULL;

--Add new column
ALTER TABLE impulse_planned
ADD Purchase_Type VARCHAR(20);

-- update values
UPDATE impulse_planned
SET Purchase_Type = 
    CASE 
        WHEN Cart_Duration_Minutes IS NULL THEN 'Unknown'
        WHEN Cart_Duration_Minutes <= 10 THEN 'Impulse'
        ELSE 'Planned'
    END;

--Count of Impulse vs. Planned
SELECT Purchase_Type, COUNT(*) AS Total
FROM impulse_planned
GROUP BY Purchase_Type;

-- Average Duration by Type
SELECT Purchase_Type, 
       AVG(Cart_Duration_Minutes) AS Avg_Cart_Duration
FROM impulse_planned
GROUP BY Purchase_Type;

-- Category-Wise Impulse Behavior
SELECT Category, Purchase_Type, COUNT(*) AS Total
FROM impulse_planned
GROUP BY Category, Purchase_Type
ORDER BY Category, Total DESC;