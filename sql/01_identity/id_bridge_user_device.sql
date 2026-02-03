-- Purpose: Bridge users and devices from observed events
-- Output table: max_ic4_raw.id_bridge_user_device
-- Notes:
-- - only includes events where both user_id and device_id are present

CREATE OR REPLACE TABLE `max_ic4_raw.id_bridge_user_device` AS
SELECT DISTINCT
  user_id,
  device_id
FROM `max_ic4_raw.mixpanel_events_sync`
WHERE user_id IS NOT NULL
  AND device_id IS NOT NULL;
