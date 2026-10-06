## Dashboard Preview

### Executive Overview


![Executive Overview](Power%20BI%20Dashboard/Executive_Overview.png)



### Disaster Trends & Risk


![Disaster Trends and Risk](Power%20BI%20Dashboard/Disaster%20Trends%20%26%20Risk.png)



### Geographical & Disaster Analysis


![Geographical and Disaster Analysis](Power%20BI%20Dashboard/Geographical%20%26%20Disaster%20Analysis.png)



### Disaster Event Details (Drill-Through)


![Disaster Event Details](Power%20BI%20Dashboard/Disaster%20Event%20Details.png)



---# NASA EONET Disaster Intelligence

An end-to-end disaster intelligence and analytics project that transforms NASA EONET event data into an interactive Power BI dashboard using Python, MySQL, SQL, and Power BI.

The project demonstrates an API-driven data analytics workflow covering data collection, transformation, database storage, SQL analysis, KPI development, interactive visualization, geographic analysis, and drill-through reporting.

---

## Project Overview

Natural disasters generate continuously changing information across different categories, regions, dates, and severity levels.

This project uses the NASA EONET API to collect disaster event data and transforms it into a structured analytical dataset for business-intelligence-style reporting.

The final Power BI dashboard provides an executive-level view of global disaster activity, risk, severity, event status, geographic distribution, and individual event details.

### Data Flow

NASA EONET API
↓
Python Requests
↓
Pandas Data Cleaning & Transformation
↓
MySQL Database
↓
SQL Analysis
↓
Power BI
↓
Interactive Disaster Intelligence Dashboard

---

## Key Features

- NASA EONET API data ingestion
- Python-based data extraction and transformation
- Pandas-based data cleaning
- MySQL database integration
- SQL-based analytical queries
- Power BI executive dashboard
- KPI cards for disaster intelligence metrics
- Disaster category analysis
- Disaster type group analysis
- Severity analysis
- Risk score analysis
- Event status analysis
- Event age analysis
- Regional analysis
- Geographic disaster event mapping
- Interactive slicers
- Cross-filtering between visuals
- Event-level drill-through analysis
- Event detail table
- Severity trend analysis
- Related event analysis
- Refreshable API-driven data pipeline

---

## Data Source

The project uses the:

**NASA Earth Observatory Natural Event Tracker (EONET) API**

API endpoint used:

`https://eonet.gsfc.nasa.gov/api/v3/events?days=365`

The API provides information about natural events detected and tracked by NASA EONET.

The dataset used in this project includes fields such as:

- Event ID
- Title
- Category
- Disaster Type Group
- Date
- Year
- Month
- Month Name
- Source
- Latitude
- Longitude
- Region
- Event Age Days
- Event Age Category
- Status
- Severity
- Risk Score
- Data Collection Date

---

## Technology Stack

| Technology | Purpose |
|---|---|
| Python | API data extraction and transformation |
| Requests | NASA EONET API requests |
| Pandas | Data cleaning and transformation |
| MySQL | Structured data storage |
| SQL | Data analysis and analytical queries |
| Power BI | Interactive dashboard and visualization |
| Power BI Map | Geographic event analysis |
| GitHub | Version control and project documentation |

---

# Python Data Pipeline

The Python script connects to the NASA EONET API and retrieves the latest available event data.

The data is then cleaned and transformed before being loaded into MySQL.

### Main Python workflow

1. Connect to NASA EONET API
2. Retrieve disaster event data
3. Extract relevant event attributes
4. Clean and transform the dataset
5. Create analytical fields
6. Remove duplicate records
7. Load the latest dataset into MySQL
8. Save a CSV backup/output where required

### Derived Analytical Fields

The Python pipeline creates additional analytical fields including:

- Disaster Type Group
- Event Age Days
- Event Age Category
- Status
- Severity
- Risk Score
- Region
- Data Collection Date

These fields make the raw API data more suitable for analytical reporting.

---

# MySQL Database

The transformed disaster data is stored in MySQL.

### Database

`nasa_eonet_disaster_intelligence`

### Main Table

`disaster_events`

The MySQL database acts as the central structured data source for Power BI.

The Python pipeline refreshes the table with the latest API data, allowing the Power BI report to be refreshed from the updated database.

---

# SQL Analysis

SQL was used to analyze the disaster dataset and generate insights before building the Power BI dashboard.

The SQL analysis includes queries for:

- Total disaster events
- Active events
- Closed events
- Disaster categories
- Disaster type groups
- Severity distribution
- Risk score distribution
- Regional distribution
- Event status
- Event age
- Year-wise event analysis
- Category-level analysis
- Regional risk analysis
- Other analytical aggregations

The SQL queries are included in this repository.

---

# Power BI Dashboard

The final Power BI report is designed as an executive-level disaster intelligence dashboard.

## Dashboard Pages

### 1. Executive Overview

Provides a high-level view of the current disaster situation.

Key KPIs include:

- Total Disaster Events
- High Severity Events
- Active Events
- Average Risk Score
- Recent Events

Visual analysis includes:

- Disaster Events by Category
- Disaster Distribution by Region
- Disaster Events by Type Group
- Global Disaster Event Map
- Severity Distribution
- Event Status

Interactive filters include:

- Year
- Category
- Region
- Severity
- Status

---

## 2. Disaster Trends & Risk

Analyzes disaster activity over time and evaluates risk patterns.

Key KPIs include:

- Total Events
- Average Risk Score
- High Severity Percentage
- Active Event Percentage

Visual analysis includes:

- Events by Year
- Event Age Category
- Disaster Events by Severity
- Risk Score Distribution
- Average Risk Score by Category
- Event Status by Category

The page helps identify changes in disaster activity, severity, risk concentration, and event status.

---

## 3. Geographical & Disaster Analysis

Focuses on the geographic distribution and concentration of disaster events.

Key KPIs include:

- Total Regions
- Total Categories
- High Severity Events
- Active Events

Visual analysis includes:

- Disaster Events by Region
- Average Risk Score by Region
- Category Risk Analysis
- Disaster Type Group Analysis
- Geographic Disaster Event Distribution
- Top Disaster Categories
- Category × Severity Matrix

The geographic analysis uses latitude and longitude data from NASA EONET to visualize event locations.

---

# Disaster Event Drill-Through

The dashboard includes a dedicated:

**Disaster Event Details**

drill-through page.

Users can select an individual event and drill through using the **Event ID**.

The selected event automatically filters the detail page.

The drill-through page includes:

### Event Overview

A concise summary of the selected event, including:

- Event Title
- Category
- Disaster Type Group
- Event Date
- Region
- Severity
- Status
- Risk Score

### Event Location

An interactive map showing the selected event's geographic location using:

- Latitude
- Longitude
- Severity
- Region
- Category
- Risk Score

### Severity Trend

A line-chart analysis of the selected event context over the most recent 30 days.

### Related Events

Provides additional analysis of related disaster activity.

### Event Details

A detailed table containing the available event-level fields from the database.

---

# Dashboard Interactivity

The Power BI report supports:

- Interactive slicers
- Cross-filtering
- Visual interactions
- Geographic exploration
- Drill-through analysis
- Event-level investigation
- Dynamic KPI updates

The drill-through functionality allows users to move from an executive-level view into individual event-level information.

---

# Data Refresh Workflow

The project is designed as a refreshable API-driven analytics pipeline.

To obtain updated disaster data:

### Step 1 — Run the Python pipeline

The Python script retrieves the latest NASA EONET API data and updates the MySQL database.

### Step 2 — Refresh Power BI

Power BI is connected to the MySQL database.

After the MySQL data is updated, refreshing the Power BI report loads the updated dataset.

### Refresh Architecture

NASA EONET API
→ Python
→ MySQL
→ Power BI Refresh
→ Updated Dashboard

> Note: The Power BI Refresh action does not execute the Python script automatically. The Python ingestion process must run first to retrieve and load the latest API data.

---

# Project Architecture

```text
                 NASA EONET API
                       |
                       v
                Python Requests
                       |
                       v
                  Pandas
            Data Cleaning & ETL
                       |
                       v
                     MySQL
          nasa_eonet_disaster_intelligence
                       |
                       v
                 SQL Analysis
                       |
                       v
                   Power BI
                       |
        +--------------+--------------+
        |              |              |
        v              v              v
 Executive        Trends & Risk   Geographical
 Overview                           Analysis
        |              |              |
        +--------------+--------------+
                       |
                       v
              Event Drill-Through
                Event Details
