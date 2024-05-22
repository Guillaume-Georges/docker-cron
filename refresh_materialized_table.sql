START TRANSACTION;

CREATE TEMPORARY TABLE IF NOT EXISTS temp_SG_product_full_info_materialized LIKE SG_product_full_info_materialized;
TRUNCATE TABLE temp_SG_product_full_info_materialized;
INSERT INTO temp_SG_product_full_info_materialized SELECT * FROM SG_only_product_full_info;

SET @count = (SELECT COUNT(*) FROM temp_SG_product_full_info_materialized);
IF @count > 0 THEN
    TRUNCATE TABLE SG_product_full_info_materialized;
    INSERT INTO SG_product_full_info_materialized SELECT * FROM temp_SG_product_full_info_materialized;
    COMMIT;
ELSE
    ROLLBACK;
END IF;

DROP TEMPORARY TABLE IF EXISTS temp_SG_product_full_info_materialized;
