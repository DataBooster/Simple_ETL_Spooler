DECLARE
    create_table VARCHAR2(4000)  := '
CREATE TABLE {Schema}.UTIL_SYS_LAST_ACTIVE_STATUS
(
    APP_KEY         VARCHAR2(50) NOT NULL,
    LAST_TIMESTAMP  TIMESTAMP(3) NOT NULL,
    LAST_STATUS     VARCHAR2(1024),
    CONSTRAINT PK_UTIL_SYS_LAST_ACTIVE_STATUS PRIMARY KEY (APP_KEY)
)
ORGANIZATION INDEX
INCLUDING LAST_STATUS
OVERFLOW TABLESPACE ERS
NOLOGGING
STORAGE
(
  INITIAL 64K
  NEXT 256K
)';
BEGIN
    EXECUTE IMMEDIATE create_table;
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -955 THEN
            NULL;
        ELSE
            RAISE;
        END IF;
END;
/

INSERT INTO {Schema}.UTIL_SYS_LAST_ACTIVE_STATUS (APP_KEY, LAST_TIMESTAMP)
SELECT 'POLL_ETL_TASK_QUEUE' AS APP_KEY, SYSTIMESTAMP AS LAST_TIMESTAMP
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM {Schema}.UTIL_SYS_LAST_ACTIVE_STATUS WHERE APP_KEY = 'POLL_ETL_TASK_QUEUE');

COMMIT;
