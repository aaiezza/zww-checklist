.width 24 2 2 2 2 2 2 2 %
SELECT
    (
        SELECT
            CASE WHEN `loc`.`coordinate` IS NULL THEN
                'various' ELSE `Island`.`name` END AS "name"
        FROM `Island`
        WHERE CASE WHEN `loc`.`coordinate` IS NOT NULL THEN
            `loc`.`coordinate` = `Island`.`location` ELSE 1 END
    ) AS "name",
    CASE WHEN `loc`.`coordinate` IS NULL THEN '~~' ELSE `loc`.`coordinate` END AS "coordinate",
    (
        SELECT
            CASE WHEN `HeartContainer`.`id` IS NOT NULL THEN
                SUBSTR('00' || COUNT(`HeartContainer`.`id`), -2, 2) ELSE NULL END
        FROM `HeartContainer`
        WHERE CASE WHEN `loc`.`coordinate` IS NOT NULL THEN
            `loc`.`coordinate` = `HeartContainer`.`location` ELSE
            `HeartContainer`.`location` IS NULL END
    ) AS "HC",
    (
        SELECT
            CASE WHEN `HeartPiece`.`id` IS NOT NULL THEN
                SUBSTR('00' || COUNT(`HeartPiece`.`id`), -2, 2) ELSE NULL END
        FROM `HeartPiece`
        WHERE CASE WHEN `loc`.`coordinate` IS NOT NULL THEN
            `loc`.`coordinate` = `HeartPiece`.`location` ELSE
            `HeartPiece`.`location` IS NULL END
    ) AS "HP",
    (
        SELECT
            CASE WHEN `Item`.`name` IS NOT NULL THEN
                SUBSTR('00' || COUNT(`Item`.`name`), -2, 2) ELSE NULL END
        FROM `Item`
        WHERE CASE WHEN `loc`.`coordinate` IS NOT NULL THEN
            `loc`.`coordinate` = `Item`.`location` ELSE
            `Item`.`location` IS NULL END AND
            `Item`.`required` = 1
    ) AS "RI",
    (
        SELECT
            CASE WHEN `Item`.`name` IS NOT NULL THEN
                SUBSTR('00' || COUNT(`Item`.`name`), -2, 2) ELSE NULL END
        FROM `Item`
        WHERE CASE WHEN `loc`.`coordinate` IS NOT NULL THEN
            `loc`.`coordinate` = `Item`.`location` ELSE
            `Item`.`location` IS NULL END AND
            `Item`.`required` = 0
    ) AS "OI",
    (
        SELECT
            CASE WHEN `TreasureChart`.`number` IS NOT NULL THEN
                SUBSTR('00' || COUNT(`TreasureChart`.`number`), -2, 2) ELSE NULL END
        FROM `TreasureChart`
        WHERE CASE WHEN `loc`.`coordinate` IS NOT NULL THEN
            `loc`.`coordinate` = `TreasureChart`.`location` ELSE
            `TreasureChart`.`location` IS NULL END
    ) AS "TC",
    (
        SELECT
            CASE WHEN `TriforceChart`.`number` IS NOT NULL THEN
                SUBSTR('00' || COUNT(`TriforceChart`.`number`), -2, 2) ELSE NULL END
        FROM `TriforceChart`
        WHERE CASE WHEN `loc`.`coordinate` IS NOT NULL THEN
            `loc`.`coordinate` = `TriforceChart`.`location` ELSE
            `TriforceChart`.`location` IS NULL END
    ) AS "TR"

FROM (SELECT `coordinate` FROM `Location` UNION ALL SELECT NULL AS `coordinate`) `loc`;
