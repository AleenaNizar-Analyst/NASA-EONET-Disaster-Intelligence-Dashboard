CREATE DATABASE nasa_eonet_disaster_intelligence;
USE nasa_eonet_disaster_intelligence;

CREATE TABLE disaster_events (
    event_id VARCHAR(50),
    title TEXT,
    category VARCHAR(100),
    disaster_type_group VARCHAR(100),
    date DATE,
    year INT,
    month INT,
    month_name VARCHAR(20),
    source VARCHAR(100),
    latitude FLOAT,
    longitude FLOAT,
    region VARCHAR(100),
    event_age_days INT,
    event_age_category VARCHAR(50),
    status VARCHAR(50),
    severity VARCHAR(50),
    risk_score INT,
    data_collection_date DATE
);


SELECT COUNT(*) AS total_records
FROM disaster_events;
SELECT *
FROM disaster_events
LIMIT 10;


-- ============================================================
-- NASA EONET DISASTER INTELLIGENCE DASHBOARD
-- SQL ANALYSIS
-- ============================================================


-- ============================================================
-- SECTION 1: BASIC DATA OVERVIEW
-- ============================================================


-- 1. Total Number of Disaster Events

SELECT COUNT(*) AS Total_Events
FROM disaster_events;


-- 2. Total Active Disaster Events

SELECT COUNT(*) AS Active_Events
FROM disaster_events
WHERE status = 'Active';


-- 3. Total Closed Disaster Events

SELECT COUNT(*) AS Closed_Events
FROM disaster_events
WHERE status = 'Closed';


-- 4. Count of Events by Disaster Category

SELECT 
    category,
    COUNT(*) AS Total_Events
FROM disaster_events
GROUP BY category
ORDER BY Total_Events DESC;


-- 5. Region-wise Disaster Distribution

SELECT 
    region,
    COUNT(*) AS Total_Events
FROM disaster_events
GROUP BY region
ORDER BY Total_Events DESC;


-- 6. Severity-wise Disaster Analysis

SELECT 
    severity,
    COUNT(*) AS Total_Events
FROM disaster_events
GROUP BY severity
ORDER BY Total_Events DESC;


-- 7. Disaster Type Group Analysis

SELECT 
    disaster_type_group,
    COUNT(*) AS Total_Events
FROM disaster_events
GROUP BY disaster_type_group
ORDER BY Total_Events DESC;


-- 8. Count of Events by Status

SELECT 
    status,
    COUNT(*) AS Total_Events
FROM disaster_events
GROUP BY status
ORDER BY Total_Events DESC;


-- ============================================================
-- SECTION 2: TIME-BASED ANALYSIS
-- ============================================================


-- 9. Monthly Disaster Trend

SELECT 
    month,
    month_name,
    COUNT(*) AS Total_Events
FROM disaster_events
GROUP BY month, month_name
ORDER BY month;


-- 10. Yearly Disaster Trend

SELECT 
    year,
    COUNT(*) AS Total_Events
FROM disaster_events
GROUP BY year
ORDER BY year;


-- 11. Yearly Average Risk Score

SELECT 
    year,
    ROUND(AVG(risk_score), 2) AS Average_Risk_Score
FROM disaster_events
GROUP BY year
ORDER BY year;


-- 12. Yearly High-Severity Event Count

SELECT 
    year,
    COUNT(*) AS High_Severity_Events
FROM disaster_events
WHERE severity = 'High'
GROUP BY year
ORDER BY year;


-- 13. Latest 10 Disaster Events

SELECT *
FROM disaster_events
ORDER BY date DESC
LIMIT 10;


-- 14. Top 5 Oldest Disaster Events

SELECT 
    title,
    category,
    region,
    event_age_days
FROM disaster_events
ORDER BY event_age_days DESC
LIMIT 5;


-- 15. Events Collected on the Latest Available Date

SELECT *
FROM disaster_events
WHERE data_collection_date = (
    SELECT MAX(data_collection_date)
    FROM disaster_events
);


-- ============================================================
-- SECTION 3: RISK & SEVERITY ANALYSIS
-- ============================================================


-- 16. Average Risk Score Across All Events

SELECT 
    ROUND(AVG(risk_score), 2) AS Average_Risk_Score
FROM disaster_events;


-- 17. Maximum Risk Score Recorded

SELECT 
    MAX(risk_score) AS Highest_Risk_Score
FROM disaster_events;


-- 18. Disaster Events with Risk Score Greater Than 2

SELECT *
FROM disaster_events
WHERE risk_score > 2
ORDER BY risk_score DESC;


-- 19. High Severity Disaster Events

SELECT *
FROM disaster_events
WHERE severity = 'High'
ORDER BY risk_score DESC;


-- 20. Risk Level Classification

SELECT 
    event_id,
    title,
    category,
    region,
    risk_score,
    CASE
        WHEN risk_score >= 4 THEN 'Critical'
        WHEN risk_score >= 3 THEN 'High'
        WHEN risk_score >= 2 THEN 'Medium'
        ELSE 'Low'
    END AS Risk_Level
FROM disaster_events
ORDER BY risk_score DESC;


-- 21. Count of Events by Risk Level

SELECT 
    CASE
        WHEN risk_score >= 4 THEN 'Critical'
        WHEN risk_score >= 3 THEN 'High'
        WHEN risk_score >= 2 THEN 'Medium'
        ELSE 'Low'
    END AS Risk_Level,
    COUNT(*) AS Total_Events
FROM disaster_events
GROUP BY Risk_Level
ORDER BY Total_Events DESC;


-- 22. High-Risk Active Disaster Events

SELECT 
    event_id,
    title,
    category,
    region,
    severity,
    risk_score,
    status
FROM disaster_events
WHERE risk_score > 2
AND status = 'Active'
ORDER BY risk_score DESC;


-- 23. High-Severity Percentage of Total Events

SELECT 
    ROUND(
        SUM(
            CASE 
                WHEN severity = 'High' THEN 1 
                ELSE 0 
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS High_Severity_Percentage
FROM disaster_events;


-- 24. Active Event Percentage

SELECT 
    ROUND(
        SUM(
            CASE 
                WHEN status = 'Active' THEN 1 
                ELSE 0 
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS Active_Event_Percentage
FROM disaster_events;


-- ============================================================
-- SECTION 4: REGIONAL ANALYSIS
-- ============================================================


-- 25. Top 3 Most Affected Regions

SELECT 
    region,
    COUNT(*) AS Total_Events
FROM disaster_events
GROUP BY region
ORDER BY Total_Events DESC
LIMIT 3;


-- 26. Region-wise Average Risk Score

SELECT 
    region,
    ROUND(AVG(risk_score), 2) AS Average_Risk_Score
FROM disaster_events
GROUP BY region
ORDER BY Average_Risk_Score DESC;


-- 27. Regions with Above-Average Risk Score

SELECT 
    region,
    ROUND(AVG(risk_score), 2) AS Average_Risk_Score
FROM disaster_events
GROUP BY region
HAVING AVG(risk_score) > (
    SELECT AVG(risk_score)
    FROM disaster_events
)
ORDER BY Average_Risk_Score DESC;


-- 28. Regional Contribution to Total Disaster Events

SELECT 
    region,
    COUNT(*) AS Total_Events,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM disaster_events),
        2
    ) AS Percentage_of_Total
FROM disaster_events
GROUP BY region
ORDER BY Percentage_of_Total DESC;


-- 29. High-Severity Percentage by Region

SELECT 
    region,
    COUNT(*) AS Total_Events,
    SUM(
        CASE 
            WHEN severity = 'High' THEN 1 
            ELSE 0 
        END
    ) AS High_Severity_Events,
    ROUND(
        SUM(
            CASE 
                WHEN severity = 'High' THEN 1 
                ELSE 0 
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS High_Severity_Percentage
FROM disaster_events
GROUP BY region
ORDER BY High_Severity_Percentage DESC;


-- 30. Active High-Severity Events by Region

SELECT 
    region,
    COUNT(*) AS Active_High_Severity_Events
FROM disaster_events
WHERE status = 'Active'
AND severity = 'High'
GROUP BY region
ORDER BY Active_High_Severity_Events DESC;


-- ============================================================
-- SECTION 5: CATEGORY & DISASTER TYPE ANALYSIS
-- ============================================================


-- 31. Most Frequently Occurring Disaster Category

SELECT 
    category,
    COUNT(*) AS Total_Events
FROM disaster_events
GROUP BY category
ORDER BY Total_Events DESC
LIMIT 1;


-- 32. Top 5 Disaster Categories by Event Count

SELECT 
    category,
    COUNT(*) AS Total_Events
FROM disaster_events
GROUP BY category
ORDER BY Total_Events DESC
LIMIT 5;


-- 33. Average Risk Score by Disaster Category

SELECT 
    category,
    ROUND(AVG(risk_score), 2) AS Average_Risk_Score
FROM disaster_events
GROUP BY category
ORDER BY Average_Risk_Score DESC;


-- 34. Highest-Risk Disaster Category

SELECT 
    category,
    ROUND(AVG(risk_score), 2) AS Average_Risk_Score
FROM disaster_events
GROUP BY category
ORDER BY Average_Risk_Score DESC
LIMIT 1;


-- 35. Category and Severity Distribution

SELECT 
    category,
    severity,
    COUNT(*) AS Total_Events
FROM disaster_events
GROUP BY category, severity
ORDER BY category, Total_Events DESC;


-- 36. Category and Status Distribution

SELECT 
    category,
    status,
    COUNT(*) AS Total_Events
FROM disaster_events
GROUP BY category, status
ORDER BY category, Total_Events DESC;


-- 37. High Severity Wildfire Events

SELECT *
FROM disaster_events
WHERE category = 'Wildfires'
AND severity = 'High'
ORDER BY risk_score DESC;


-- 38. Climate-Related Disaster Count

SELECT 
    COUNT(*) AS Climate_Disasters
FROM disaster_events
WHERE disaster_type_group = 'Climate';


-- 39. Geological Disaster Count

SELECT 
    COUNT(*) AS Geological_Disasters
FROM disaster_events
WHERE disaster_type_group = 'Geological';


-- 40. Environmental Events by Region

SELECT 
    region,
    COUNT(*) AS Environmental_Events
FROM disaster_events
WHERE disaster_type_group = 'Environmental'
GROUP BY region
ORDER BY Environmental_Events DESC;


-- ============================================================
-- SECTION 6: ADVANCED SQL ANALYSIS
-- ============================================================


-- 41. Highest-Risk Event in Each Category

SELECT 
    category,
    title,
    risk_score,
    severity,
    region
FROM disaster_events d
WHERE risk_score = (
    SELECT MAX(d2.risk_score)
    FROM disaster_events d2
    WHERE d2.category = d.category
)
ORDER BY risk_score DESC;


-- 42. Most Recent Event in Each Region

SELECT 
    region,
    title,
    category,
    date
FROM disaster_events d
WHERE date = (
    SELECT MAX(d2.date)
    FROM disaster_events d2
    WHERE d2.region = d.region
)
ORDER BY date DESC;


-- 43. Events with Risk Score Above Their Category Average

SELECT 
    d.event_id,
    d.title,
    d.category,
    d.risk_score,
    ROUND(c.Average_Category_Risk, 2) AS Average_Category_Risk
FROM disaster_events d
JOIN (
    SELECT 
        category,
        AVG(risk_score) AS Average_Category_Risk
    FROM disaster_events
    GROUP BY category
) c
ON d.category = c.category
WHERE d.risk_score > c.Average_Category_Risk
ORDER BY d.risk_score DESC;


-- 44. Disaster Category Ranking by Total Events

SELECT 
    category,
    COUNT(*) AS Total_Events,
    RANK() OVER (
        ORDER BY COUNT(*) DESC
    ) AS Category_Rank
FROM disaster_events
GROUP BY category
ORDER BY Category_Rank;


-- 45. Region Ranking by Average Risk Score

SELECT 
    region,
    ROUND(AVG(risk_score), 2) AS Average_Risk_Score,
    RANK() OVER (
        ORDER BY AVG(risk_score) DESC
    ) AS Risk_Rank
FROM disaster_events
GROUP BY region
ORDER BY Risk_Rank;


-- 46. Risk Ranking of Individual Disaster Events

SELECT 
    event_id,
    title,
    category,
    region,
    risk_score,
    RANK() OVER (
        ORDER BY risk_score DESC
    ) AS Risk_Rank
FROM disaster_events
ORDER BY Risk_Rank;


-- 47. Running Total of Disaster Events by Year

SELECT 
    year,
    COUNT(*) AS Yearly_Events,
    SUM(COUNT(*)) OVER (
        ORDER BY year
    ) AS Cumulative_Events
FROM disaster_events
GROUP BY year
ORDER BY year;


-- 48. Category-wise Active vs Closed Events

SELECT 
    category,
    SUM(
        CASE 
            WHEN status = 'Active' THEN 1 
            ELSE 0 
        END
    ) AS Active_Events,
    SUM(
        CASE 
            WHEN status = 'Closed' THEN 1 
            ELSE 0 
        END
    ) AS Closed_Events,
    COUNT(*) AS Total_Events
FROM disaster_events
GROUP BY category
ORDER BY Total_Events DESC;


-- 49. Status Percentage Distribution

SELECT 
    status,
    COUNT(*) AS Total_Events,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM disaster_events),
        2
    ) AS Percentage_of_Total
FROM disaster_events
GROUP BY status
ORDER BY Percentage_of_Total DESC;


-- 50. Monthly Disaster Events with Severity Breakdown

SELECT 
    month,
    month_name,
    SUM(
        CASE 
            WHEN severity = 'High' THEN 1 
            ELSE 0 
        END
    ) AS High_Severity_Events,
    SUM(
        CASE 
            WHEN severity = 'Medium' THEN 1 
            ELSE 0 
        END
    ) AS Medium_Severity_Events,
    SUM(
        CASE 
            WHEN severity = 'Low' THEN 1 
            ELSE 0 
        END
    ) AS Low_Severity_Events,
    COUNT(*) AS Total_Events
FROM disaster_events
GROUP BY month, month_name
ORDER BY month;

-- ============================================================
--                      END
-- ============================================================
