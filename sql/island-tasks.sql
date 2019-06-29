-- .width 24 2 2 2 2 2 2 2 2 %
SELECT
    `IslandLocation`.`name`,
    `Location`.`coordinate`,
    SUBSTR('00' || `HeartContainerLocation`.`HeartContainers`, -2, 2) AS "HC",
    SUBSTR('00' || `HeartPieceLocation`.`HeartPieces`, -2, 2) AS "HP",
    SUBSTR('00' || `RequiredItemLocation`.`Items`, -2, 2) AS "RI",
    SUBSTR('00' || `OptionalItemLocation`.`Items`, -2, 2) AS "OI",
    SUBSTR('00' || `TreasureChartLocation`.`TreasureCharts`, -2, 2) AS "TC",
    SUBSTR('00' || `TriforceChartLocation`.`TriforceCharts`, -2, 2) AS "TR",
    SUBSTR('00' || `SunkenTreasureLocation`.`SunkenTreasures`, -2, 2) AS "ST"

FROM `Location`

LEFT JOIN (SELECT
        `Location`.`coordinate`,
        `Island`.`name`
    FROM `Location` LEFT JOIN `Island` ON
        `Location`.`coordinate` = `Island`.`location`
    GROUP BY
        `Location`.`coordinate`) AS `IslandLocation`
USING(`coordinate`)

LEFT JOIN (SELECT
        `Location`.`coordinate`,
        CASE WHEN `HeartContainer`.`id` IS NOT NULL THEN
            COUNT(`HeartContainer`.`id`) ELSE NULL END AS "HeartContainers"
    FROM `Location`
    LEFT JOIN `HeartContainer` ON
        `Location`.`coordinate` = `HeartContainer`.`location`
    GROUP BY
        `Location`.`coordinate`) AS `HeartContainerLocation`
USING(`coordinate`)

LEFT JOIN (SELECT
        `Location`.`coordinate`,
        CASE WHEN `HeartPiece`.`id` IS NOT NULL THEN
            COUNT(`HeartPiece`.`id`) ELSE NULL END AS "HeartPieces"
    FROM `Location`
    LEFT JOIN `HeartPiece` ON
        `Location`.`coordinate` = `HeartPiece`.`location`
    GROUP BY
        `Location`.`coordinate`) AS `HeartPieceLocation`
USING(`coordinate`)

LEFT JOIN (SELECT
        `Location`.`coordinate`,
        CASE WHEN `Item`.`name` IS NOT NULL THEN
            COUNT(`Item`.`name`) ELSE NULL END AS "Items"
    FROM `Location`
    LEFT JOIN `Item` ON
        `Location`.`coordinate` = `Item`.`location`
    WHERE `Item`.`required` = 1
    GROUP BY
        `Location`.`coordinate`) AS `RequiredItemLocation`
USING(`coordinate`)

LEFT JOIN (SELECT
        `Location`.`coordinate`,
        CASE WHEN `Item`.`name` IS NOT NULL THEN
            COUNT(`Item`.`name`) ELSE NULL END AS "Items"
    FROM `Location`
    LEFT JOIN `Item` ON
        `Location`.`coordinate` = `Item`.`location`
    WHERE `Item`.`required` = 0
    GROUP BY
        `Location`.`coordinate`) AS `OptionalItemLocation`
USING(`coordinate`)

LEFT JOIN (SELECT
        `Location`.`coordinate`,
        CASE WHEN `Chart`.`number` IS NOT NULL THEN
            COUNT(`Chart`.`number`) ELSE NULL END AS "TreasureCharts"
    FROM `Location`
    LEFT JOIN `Chart` ON
        `Location`.`coordinate` = `Chart`.`location`
    WHERE `Chart`.`type` = 'Treasure'
    GROUP BY
        `Location`.`coordinate`) AS `TreasureChartLocation`
USING(`coordinate`)

LEFT JOIN (SELECT
        `Location`.`coordinate`,
        CASE WHEN `Chart`.`number` IS NOT NULL THEN
            COUNT(`Chart`.`number`) ELSE NULL END AS "TriforceCharts"
    FROM `Location`
    LEFT JOIN `Chart` ON
        `Location`.`coordinate` = `Chart`.`location`
    WHERE `Chart`.`type` = 'Triforce'
    GROUP BY
        `Location`.`coordinate`) AS `TriforceChartLocation`
USING(`coordinate`)

LEFT JOIN (SELECT
        `Location`.`coordinate`,
        CASE WHEN `SunkenTreasure`.`number` IS NOT NULL THEN
            COUNT(`SunkenTreasure`.`number`) ELSE NULL END AS "SunkenTreasures"
    FROM `Location`
    LEFT JOIN `SunkenTreasure` ON
        `Location`.`coordinate` = `SunkenTreasure`.`location`
    GROUP BY
        `Location`.`coordinate`) AS `SunkenTreasureLocation`
USING(`coordinate`)

GROUP BY
    `Location`.`coordinate`

UNION ALL

SELECT
    "various" AS "name",
    "~~" AS "coordinate",
    (
        SELECT
            CASE WHEN `HeartContainer`.`id` IS NOT NULL THEN
                SUBSTR('00' || COUNT(`HeartContainer`.`id`), -2, 2) ELSE NULL END
        FROM `HeartContainer`
        WHERE `HeartContainer`.`location` IS NULL
    ) AS "HC",
    (
        SELECT
            CASE WHEN `HeartPiece`.`id` IS NOT NULL THEN
                SUBSTR('00' || COUNT(`HeartPiece`.`id`), -2, 2) ELSE NULL END
        FROM `HeartPiece`
        WHERE `HeartPiece`.`location` IS NULL
    ) AS "HP",
    (
        SELECT
            CASE WHEN `Item`.`name` IS NOT NULL THEN
                SUBSTR('00' || COUNT(`Item`.`name`), -2, 2) ELSE NULL END
        FROM `Item`
        WHERE `Item`.`location` IS NULL AND `Item`.`required` = 1
    ) AS "RI",
    (
        SELECT
            CASE WHEN `Item`.`name` IS NOT NULL THEN
                SUBSTR('00' || COUNT(`Item`.`name`), -2, 2) ELSE NULL END
        FROM `Item`
        WHERE `Item`.`location` IS NULL AND `Item`.`required` = 0
    ) AS "OI",
    (
        SELECT
            CASE WHEN `Chart`.`number` IS NOT NULL THEN
                SUBSTR('00' || COUNT(`Chart`.`number`), -2, 2) ELSE NULL END
        FROM `Chart`
        WHERE `Chart`.`location` IS NULL AND `Chart`.`type` = 'Treasure'
    ) AS "TC",
    (
        SELECT
            CASE WHEN `Chart`.`number` IS NOT NULL THEN
                SUBSTR('00' || COUNT(`Chart`.`number`), -2, 2) ELSE NULL END
        FROM `Chart`
        WHERE `Chart`.`location` IS NULL AND `Chart`.`type` = 'Triforce'
    ) AS "TR",
    (
        SELECT
            CASE WHEN `SunkenTreasure`.`number` IS NOT NULL THEN
                SUBSTR('00' || COUNT(`SunkenTreasure`.`number`), -2, 2) ELSE NULL END
        FROM `SunkenTreasure`
        WHERE `SunkenTreasure`.`location` IS NULL
    ) AS "ST"
;
