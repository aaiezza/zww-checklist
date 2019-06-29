-- .width 2 2 45
SELECT
    `location` AS "coordinates",
    SUBSTR('00' || `number`, -2, 2) AS "#",
    `details`
FROM `Chart`
LEFT JOIN `Location` ON
    `Chart`.`location` = `Location`.`coordinate`
WHERE `type` = "Treasure"
ORDER BY `latitude`, `longitude`;
