BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE {Schema}.UTIL_SYS_ETL_BATCH_STATUS';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

-- Create table
CREATE TABLE {Schema}.UTIL_SYS_ETL_BATCH_STATUS
(
    BATCH_ID            NUMBER(10)      NOT NULL,
    BATCH_COMMENT       VARCHAR2(4000),
    SCHEDULED_TIME      DATE            DEFAULT SYSDATE     NOT NULL,
    BATCH_STATUS        VARCHAR2(30)    DEFAULT 'DRAFTING'  NOT NULL,
    TASKS_COUNT         NUMBER(5)       DEFAULT 0           NOT NULL,
    SERIES_COUNT        NUMBER(5)       DEFAULT 0           NOT NULL,
    ENTRY_TIME          DATE            DEFAULT SYSDATE     NOT NULL,
    TRIGGERED_TIME      DATE,

    CONSTRAINT PK_UTIL_SYS_ETL_BATCH_STATUS PRIMARY KEY (BATCH_ID),
    CONSTRAINT CK_UTIL_SYS_ETL_BATCH_STATUS check (BATCH_STATUS IN ('DRAFTING', 'READY_TO_RUN', 'RUNNING'))
)
NOLOGGING;

COMMENT ON TABLE {Schema}.UTIL_SYS_ETL_BATCH_STATUS IS 'Simple ETL Spooler batch status';

CREATE INDEX {Schema}.IX_UTIL_SYS_ETL_BATCH_STATUS ON {Schema}.UTIL_SYS_ETL_BATCH_STATUS (BATCH_STATUS, SCHEDULED_TIME, BATCH_ID);