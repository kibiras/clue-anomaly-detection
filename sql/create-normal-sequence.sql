CREATE TABLE `train.normal_activity_type` AS SELECT
  uid,
   CAST(time AS DATE) as date,
  STRING_AGG(type, ' ' ORDER BY id) AS normal_activity,
  COUNT(type) AS normal_actions
FROM
  `phd1-374514.raw.clue_json_schema`
GROUP BY
  uid,
  date
ORDER BY
  date,
  uid