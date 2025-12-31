-- Weekly training volume and average effort
SELECT
  strftime('%Y-%W', run_date) AS year_week,
  athlete_id,
  ROUND(SUM(distance_km), 1) AS total_km,
  ROUND(AVG(rpe), 1) AS avg_effort
FROM runs
GROUP BY 1, 2
ORDER BY 1 DESC;
