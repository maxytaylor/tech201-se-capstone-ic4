-- Purpose: Map session_id to canonical user_id
-- Output table: max_ic4_raw.idmap_session_to_user
-- Notes:
-- - sessionIds are stored on the users snapshot
-- - each session maps to exactly one user

CREATE OR REPLACE TABLE `max_ic4_raw.idmap_session_to_user` AS
SELECT
  session_id,
  user_id
FROM `max_ic4_raw.mixpanel_users_sync_flat`,
UNNEST(sessionIds) AS session_id
WHERE user_id IS NOT NULL;
