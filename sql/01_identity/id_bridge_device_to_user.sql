-- Purpose: Reduce device → user mappings to a single canonical user
-- Output table: max_ic4_raw.id_bridge_device_to_user
-- Notes:
-- - ANY_VALUE is acceptable here because device sharing is allowed
-- - identity correctness is enforced elsewhere

CREATE OR REPLACE TABLE `max_ic4_raw.id_bridge_device_to_user` AS
SELECT
  device_id,
  ANY_VALUE(user_id) AS user_id
FROM `max_ic4_raw.id_bridge_user_device`
GROUP BY device_id;
