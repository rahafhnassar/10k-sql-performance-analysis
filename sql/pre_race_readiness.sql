-- Evaluate training readiness in the 4 weeks leading into a race
WITH training_block AS (
  SELECT
    r.race_id,
    ru.athlete_id,
    ru.run_date,
    ru.distance_km,
    ru.rpe
  FROM races r
  JOIN runs ru
    ON ru.athlete_id = r.athlete_id
   AND ru.run_date BETWEEN date(r.race_date, '-28 day')
                        AND date(r.race_date, '-1 day')
),
wellness_block AS (
  SELECT
    r.race_id,
    AVG(w.sleep_hours) AS avg_sleep,
    AVG(w.stress_level) AS avg_stress,
    AVG(w.soreness_level) AS avg_soreness
  FROM races r
  JOIN wellness_daily w
    ON w.athlete_id = r.athlete_id
   AND w.wellness_date BETWEEN date(r.race_date, '-28 day')
                           AND date(r.race_date, '-1 day')
  GROUP BY r.race_id
)
SELECT
  t.race_id,
  t.athlete_id,
  ROUND(SUM(t.distance_km), 1) AS total_km_4w,
  ROUND(AVG(t.rpe), 1) AS avg_rpe_4w,
  ROUND(w.avg_sleep, 2) AS avg_sleep_4w,
  ROUND(w.avg_stress, 2) AS avg_stress_4w,
  ROUND(w.avg_soreness, 2) AS avg_soreness_4w
FROM training_block t
JOIN wellness_block w
  ON t.race_id = w.race_id
GROUP BY t.race_id, t.athlete_id;
