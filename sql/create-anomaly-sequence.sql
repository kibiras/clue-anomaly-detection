CREATE TABLE `train.anomaly_activity_type` AS
WITH AnomalyData AS (
  SELECT
    uid,
    CAST(time AS DATE) as date,
    STRING_AGG(type, ' ' ORDER BY id) AS normal_activity,
    COUNT(type) AS actions
  FROM
    `phd1-374514.raw.clue_json_schema_anomalies`
  GROUP BY
    uid,
    date
)

SELECT
  a.uid,
  a.date,
  a.normal_activity,
  a.actions,
  CASE
    WHEN c.uid IS NOT NULL THEN 1
    ELSE 0
  END AS anomaly
FROM
  AnomalyData a
LEFT JOIN
  `phd1-374514.raw.clue_labels_time` c
ON
  a.uid = c.uid AND a.date = CAST(c.time AS DATE)
ORDER BY
  a.date,
  a.uid;