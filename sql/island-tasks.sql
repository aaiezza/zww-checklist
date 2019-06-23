.width 24 2 2 2 2 %
SELECT
    `IslandLocation`.`name`,
    `Location`.`coordinate`,
    SUBSTR('00' || `HeartPieceLocation`.`HeartPieces`, -2, 2) AS "HP",
    SUBSTR('00' || `TreasureChartLocation`.`TreasureCharts`, -2, 2) AS "TC",
    SUBSTR('00' || `ItemLocation`.`Items`, -2, 2) AS "XI"

FROM (SELECT `Latitude`.`value`||`Longitude`.`value` AS "coordinate"
    FROM `Latitude` CROSS JOIN `Longitude`
    UNION ALL
    SELECT "~~" AS "coordinate") AS "Location"

LEFT JOIN (SELECT
        `Location`.`coordinate`,
        `Island`.`name` AS "name"
    FROM (SELECT `Latitude`.`value`||`Longitude`.`value` AS "coordinate"
        FROM `Latitude` CROSS JOIN `Longitude`
        UNION ALL
        SELECT "~~" AS "coordinate") AS "Location"
    LEFT JOIN (SELECT *
        FROM `Island`
        UNION ALL SELECT
            'various' AS 'name',
            NULL AS 'longitude',
            NULL AS 'latitude') AS 'Island' ON
        `Location`.`coordinate` = (CASE WHEN `Island`.`latitude`||`Island`.`longitude` IS NULL THEN
            "~~" ELSE `Island`.`latitude`||`Island`.`longitude` END)
    GROUP BY
        `Location`.`coordinate`) AS `IslandLocation` USING(`coordinate`)

LEFT JOIN (SELECT
        `Location`.`coordinate`,
        CASE WHEN `HeartPiece`.`id` IS NOT NULL THEN
            COUNT(`HeartPiece`.`id`) ELSE NULL END AS "HeartPieces"
    FROM (SELECT `Latitude`.`value`||`Longitude`.`value` AS "coordinate"
        FROM `Latitude` CROSS JOIN `Longitude`
        UNION ALL
        SELECT "~~" AS "coordinate") AS "Location"
    LEFT JOIN `HeartPiece` ON
        `Location`.`coordinate` = (CASE WHEN `HeartPiece`.`latitude`||`HeartPiece`.`longitude` IS NULL THEN
            "~~" ELSE `HeartPiece`.`latitude`||`HeartPiece`.`longitude` END)
    GROUP BY
        `Location`.`coordinate`) AS `HeartPieceLocation` USING(`coordinate`)

LEFT JOIN (SELECT
        `Location`.`coordinate`,
        CASE WHEN `TreasureChart`.`number` IS NOT NULL THEN
            COUNT(`TreasureChart`.`number`) ELSE NULL END AS "TreasureCharts"
    FROM (SELECT `Latitude`.`value`||`Longitude`.`value` AS "coordinate"
        FROM `Latitude` CROSS JOIN `Longitude`
        UNION ALL
        SELECT "~~" AS "coordinate") AS "Location"
    LEFT JOIN `TreasureChart` ON
        `Location`.`coordinate` = (CASE WHEN `TreasureChart`.`latitude`||`TreasureChart`.`longitude` IS NULL THEN
            "~~" ELSE `TreasureChart`.`latitude`||`TreasureChart`.`longitude` END)
    GROUP BY
        `Location`.`coordinate`) AS `TreasureChartLocation` USING(`coordinate`)

LEFT JOIN (SELECT
        `Location`.`coordinate`,
        CASE WHEN `Item`.`name` IS NOT NULL THEN
            COUNT(`Item`.`name`) ELSE NULL END AS "Items"
    FROM (SELECT `Latitude`.`value`||`Longitude`.`value` AS "coordinate"
        FROM `Latitude` CROSS JOIN `Longitude`
        UNION ALL
        SELECT "~~" AS "coordinate") AS "Location"
    LEFT JOIN `Item` ON
        `Location`.`coordinate` = (CASE WHEN `Item`.`latitude`||`Item`.`longitude` IS NULL THEN
            "~~" ELSE `Item`.`latitude`||`Item`.`longitude` END)
    GROUP BY
        `Location`.`coordinate`) AS `ItemLocation` USING(`coordinate`)

GROUP BY
    `Location`.`coordinate`;
