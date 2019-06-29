-- .width 20 %
SELECT
    `SunkenTreasure`.`number`,
    `SunkenTreasure`.`treasure`,
    SUBSTR('00' || COUNT(`SunkenTreasure`.`number`), -2, 2) AS "count"
FROM `SunkenTreasure`
GROUP BY `SunkenTreasure`.`treasure`;

-- .width 2 2 20 2 %
SELECT
    SUBSTR('00' || `SunkenTreasure`.`number`, -2, 2) AS "#",
    `SunkenTreasure`.`location`,
    `SunkenTreasure`.`treasure`,
    CASE WHEN `Chart`.`location` IS NULL THEN
        '~~' ELSE `Chart`.`location` END AS "Chart Location"
FROM `SunkenTreasure`
LEFT JOIN `Chart` ON
    `SunkenTreasure`.`chart_number` = `Chart`.`number` AND
    `SunkenTreasure`.`chart_type`   = `Chart`.`type`;
