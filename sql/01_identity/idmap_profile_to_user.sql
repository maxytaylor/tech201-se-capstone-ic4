-- Purpose: Map Mixpanel profile-level IDs to canonical user_id
-- Output table: max_ic4_raw.idmap_profile_to_user
-- Notes:
-- - profile_distinct_id represents the Mixpanel profile identifier
-- - user_id is the canonical authenticated identifier

CREATE OR REPLACE TABLE `max_ic4_raw.idmap_profile_to_user` AS
SELECT
  user_id AS profile_distinct_id,
  user_id AS user_id
FROM `max_ic4_raw.mixpanel_users_sync_flat`
WHERE user_id IS NOT NULL;
