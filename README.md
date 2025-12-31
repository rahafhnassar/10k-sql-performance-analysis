# 🏃‍♀️ 10K Training & Race Performance Analysis (SQL)

## Overview
This project uses SQL to analyze 10K training data and uncover patterns related to performance, consistency, and recovery.  
Instead of a generic business case, I modeled a real-life scenario: tracking runs, wellness metrics, and race outcomes to answer practical training questions a runner or coach would actually care about.

The goal was to practice **relational database design, time-based analysis, and performance insights** using SQL.

---

## Objectives
- Track weekly mileage, intensity, and consistency over time  
- Analyze how recovery factors (sleep, stress, soreness) relate to performance  
- Evaluate readiness leading into a 10K race  
- Identify early indicators of overtraining using rolling workload metrics  

---

## Database Schema
The project is built using a relational structure designed for realistic analytics queries.

### Tables
- **athletes** – runner demographics and training start date  
- **runs** – daily workouts (distance, duration, intensity, effort)  
- **wellness_daily** – sleep, stress, soreness, and recovery indicators  
- **races** – official race results and performance metrics  
- **injuries** – injury periods and severity  

This structure supports joins, CTEs, and window functions across training and wellness data.

---

## Key Questions Explored
- How has weekly mileage and training intensity changed over time?
- What does a strong four-week training block look like before a 10K?
- Does reduced sleep or elevated stress show up in performance?
- Are there early warning signs of overtraining based on workload and effort?

---

## Analysis Highlights

### Training Trends
- Calculated weekly mileage and average effort to track training consistency
- Analyzed workout mix (easy vs tempo vs interval runs)

### Performance Readiness
- Built a four-week pre-race training summary to assess readiness
- Compared race outcomes against training volume and recovery metrics

### Overtraining Risk
- Created rolling 7-day workload views
- Flagged periods of elevated fatigue using mileage and perceived effort

---

## Example SQL Query
```sql
-- Weekly training volume and effort
SELECT
  strftime('%Y-%W', run_date) AS year_week,
  ROUND(SUM(distance_km), 1) AS total_km,
  ROUND(AVG(rpe), 1) AS avg_effort
FROM runs
GROUP BY 1
ORDER BY 1;
