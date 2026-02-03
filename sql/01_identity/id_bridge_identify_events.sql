-- id_bridge_identify_events
-- Uses identify-style events to bridge device_id <-> user_id when available.

CREATE OR REPLACE TABLE `mixpanel-gtm-training.max_ic4_raw.id_bridge_identify_events` AS
SELECT
  device_id,
  user_id,
  MIN(event_time) AS first_seen,
  MAX(event_time) AS last_seen
FROM `mixpanel-gtm-training.max_ic4_raw.mixpanel_events_sync`
WHERE device_id IS NOT NULL
  AND user_id IS NOT NULL
  -- If you have a specific identify event name, uncomment and set it:
  -- AND event_name IN ('$identify','Identify','identify')
GROUP BY 1,2;
