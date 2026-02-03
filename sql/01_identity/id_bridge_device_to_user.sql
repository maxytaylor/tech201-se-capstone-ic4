-- id_bridge_device_to_user
-- Consolidated bridge device_id -> user_id (sessions + events + identify bridge)

CREATE OR REPLACE TABLE `mixpanel-gtm-training.max_ic4_raw.id_bridge_device_to_user` AS
WITH from_events AS (
  SELECT device_id, user_id, MAX(event_time) AS last_seen
  FROM `mixpanel-gtm-training.max_ic4_raw.mixpanel_events_sync`
  WHERE device_id IS NOT NULL AND user_id IS NOT NULL
  GROUP BY 1,2
),
from_sessions AS (
  SELECT device_id, user_id, MAX(end_time) AS last_seen
  FROM `mixpanel-gtm-training.max_ic4_raw.mixpanel_sessions_enriched`
  WHERE device_id IS NOT NULL AND user_id IS NOT NULL
  GROUP BY 1,2
),
from_identify AS (
  SELECT device_id, user_id, last_seen
  FROM `mixpanel-gtm-training.max_ic4_raw.id_bridge_identify_events`
),
unioned AS (
  SELECT * FROM from_events
  UNION ALL
  SELECT * FROM from_sessions
  UNION ALL
  SELECT * FROM from_identify
)
SELECT
  device_id,
  user_id,
  MAX(last_seen) AS last_seen
FROM unioned
GROUP BY 1,2;
