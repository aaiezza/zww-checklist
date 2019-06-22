.width 2 2 2 %
SELECT
    `Location`.`coordinate`,
    SUBSTR('00' || `HeartPieceLocation`.`HeartPieces`, -2, 2) AS "HP",
    SUBSTR('00' || `TreasureChartLocation`.`TreasureCharts`, -2, 2) AS "TC"

FROM (SELECT `Latitude`.`value`||`Longitude`.`value` AS "coordinate"
    FROM `Latitude` CROSS JOIN `Longitude`) AS "Location"

LEFT JOIN (SELECT
        `Location`.`coordinate`,
        CASE WHEN `HeartPiece`.`id` IS NOT NULL THEN
            COUNT(`HeartPiece`.`id`) ELSE NULL END AS "HeartPieces"
    FROM (SELECT `Latitude`.`value`||`Longitude`.`value` AS "coordinate"
        FROM `Latitude` CROSS JOIN `Longitude`) AS "Location"
    LEFT JOIN`HeartPiece` ON
        `Location`.`coordinate` = `HeartPiece`.`latitude`||`HeartPiece`.`longitude`
    GROUP BY
        `Location`.`coordinate`) AS `HeartPieceLocation` ON
    `Location`.`coordinate` = `HeartPieceLocation`.`coordinate`

LEFT JOIN (SELECT
        `Location`.`coordinate`,
        CASE WHEN `TreasureChart`.`number` IS NOT NULL THEN
            COUNT(`TreasureChart`.`number`) ELSE NULL END AS "TreasureCharts"
    FROM (SELECT `Latitude`.`value`||`Longitude`.`value` AS "coordinate"
        FROM `Latitude` CROSS JOIN `Longitude`) AS "Location"
    LEFT JOIN`TreasureChart` ON
        `Location`.`coordinate` = `TreasureChart`.`latitude`||`TreasureChart`.`longitude`
    GROUP BY
        `Location`.`coordinate`) AS `TreasureChartLocation` ON
    `Location`.`coordinate` = `TreasureChartLocation`.`coordinate`

GROUP BY
    `Location`.`coordinate`;