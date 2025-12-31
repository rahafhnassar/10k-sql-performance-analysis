-- Rolling 7-day workload and overtraining risk
WITH daily_load AS (
  SELECT
    athlete_id,
    run_date,
    SUM(distance_km) AS km_day,
    AVG(rpe) AS rpe_day
  FROM runs
  GROUP BY athlete_id, run_date
),
rolling_load AS (
  SELECT
    d1.athlete_id,
    d1.run_date,
    (
      SELECT SUM(d2.km_day)
      FROM daily_load d2
      WHERE d2.athlete_id = d1.athlete_id
        AND d2.run_date BETWEEN date(d1.run_date, '-6 day')
                            AND d1.run_date
    ) AS km_7d,
    (
      SELECT AVG(d2.rpe_day)
      FROM daily_load d2
      WHERE d2.athlete_id = d1.athlete_id
        AND d2.run_date BETWEEN date(d1.run_date, '-6 day')
                            AND d1.run_date
    ) AS rpe_7d
  FROM daily_load d1
)
SELECT
  athlete_id,
  run_date,
  ROUND(km_7d, 1) AS km_7d,
  ROUND(rpe_7d, 1) AS rpe_7d,
  CASE
    WHEN km_7d >= 45 AND rpe_7d >= 7 THEN 'HIGH'
    WHEN km_7d >= 35 AND rpe_7d >= 6 THEN 'MEDIUM'
    ELSE 'LOW'
  END AS overtraining_risk
FROM rolling_load
ORDER BY run_date DESC;
