-- idmap_session_to_user
-- Maps session_id -> user_id using the sessions table (already enriched/cleaned)
-- Output columns: session_id, user_id

CREATE OR REPLACE TABLE `mixpanel-gtm-training.max_ic4_raw.idmap_session_to_user` AS
SELECT
  session_id,
  user_id
FROM `mixpanel-gtm-training.max_ic4_raw.mixpanel_sessions_enriched`
WHERE session_id IS NOT NULL
  AND user_id IS NOT NULL
QUALIFY ROW_NUMBER() OVER (PARTITION BY session_id ORDER BY start_time DESC) = 1;

