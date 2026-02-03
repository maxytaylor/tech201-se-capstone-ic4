-- idmap_device_user_windows
-- Builds time windows where a device_id maps to a user_id (for “at time of event” resolution).

CREATE OR REPLACE TABLE `mixpanel-gtm-training.max_ic4_raw.idmap_device_user_windows` AS
WITH ordered AS (
  SELECT
    device_id,
    user_id,
    last_seen AS change_time
  FROM `mixpanel-gtm-training.max_ic4_raw.id_bridge_device_to_user`
  WHERE device_id IS NOT NULL AND user_id IS NOT NULL
),
windows AS (
  SELECT
    device_id,
    user_id,
    change_time AS start_time,
    LEAD(change_time) OVER (PARTITION BY device_id ORDER BY change_time) AS end_time
  FROM ordered
)
SELECT
  device_id,
  user_id,
  start_time,
  COALESCE(end_time, TIMESTAMP('9999-12-31')) AS end_time
FROM windows;
