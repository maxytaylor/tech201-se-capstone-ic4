-- Purpose: Capture identify events linking device_id to user_id
-- Output table: max_ic4_raw.id_bridge_identify_events
-- Notes:
-- - identifies the first observed identification per device/user

CREATE OR REPLACE TABLE `max_ic4_raw.id_bridge_identify_events` AS
SELECT
  device_id,
  user_id,
  MIN(event_time) AS first_identify_time
FROM `max_ic4_raw.mixpanel_events_sync`
WHERE event_name = 'identify'
  AND device_id IS NOT NULL
  AND user_id IS NOT NULL
GROUP BY device_id, user_id;
