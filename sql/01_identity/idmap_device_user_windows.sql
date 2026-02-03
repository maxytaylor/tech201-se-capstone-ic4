-- Purpose: Create device → user windows based on identify events
-- Output table: max_ic4_raw.idmap_device_user_windows
-- Notes:
-- - start_time is first identify
-- - end_time is set to a far-future placeholder

CREATE OR REPLACE TABLE `max_ic4_raw.idmap_device_user_windows` AS
SELECT
  device_id,
  user_id,
  first_identify_time AS start_time,
  TIMESTAMP '9999-12-31 23:59:59' AS end_time
FROM `max_ic4_raw.id_bridge_identify_events`;
