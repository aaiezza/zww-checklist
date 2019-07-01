-- .width 2 17 2 25
SELECT
    `Location`.`coordinate`,
    "Treasure Chart "||SUBSTR('00' || `number`, -2, 2) AS "chart",
    `SunkenThing`.`location` AS "Sunken Treasure Location",
    `SunkenThing`.`treasure`
FROM `Location`
INNER JOIN `TreasureChart` ON
    `Location`.`coordinate` = `TreasureChart`.`location`
LEFT JOIN `SunkenThing` ON
    "Treasure Chart "||SUBSTR('00' || `TreasureChart`.`number`, -2, 2) =
        `SunkenThing`.`chart`
ORDER BY `latitude`, `longitude`;
