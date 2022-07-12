CREATE OR REPLACE VIEW {Schema}.VIEW_UTIL_SYS_ETL_TASK_QUEUE AS
SELECT
    b.BATCH_ID,
    t.STEP_PLAN,
    t.TASK_ID,
    t.EXTRACT_TYPE,
    t.EXTRACT_SOURCE,
    t.EXTRACT_COMMAND,
    t.EXTRACT_PARAMS,
    t.EXTRACT_TIMEOUT_SEC,
    t.RESULT_SET,
    t.NAMING_CONVENTION,
    t.LOAD_TYPE,
    t.FIELD_MAPPING,
    t.MERGE_PARAMS,
    t.LOAD_DESTINATION,
    t.LOAD_COMMAND,
    t.LOAD_TIMEOUT_SEC,
    b.BATCH_STATUS,
    b.ENTRY_TIME,
    b.SCHEDULED_TIME,
    b.TRIGGERED_TIME,
    t.COMPLETED_TIME,
    t.RUNTIME_ERROR
FROM
    {Schema}.UTIL_SYS_ETL_BATCH_STATUS   b
    JOIN
    {Schema}.UTIL_SYS_ETL_TASK_QUEUE     t
    ON t.BATCH_ID = b.BATCH_ID
WITH READ ONLY;
