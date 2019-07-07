SELECT
    `sunk`.`sunkenChestId` AS 'No',
    `sunk`.`longitude` AS 'X|',
    `sunk`.`latitude` AS 'X-',
    `sunk`.`islandName` AS 'Location',
    `sunk`.`treasure` AS 'Treasure',
    `sunk`.`chartNumber` AS `Chart`
FROM (
SELECT
    `SunkenChest`.`id` AS 'sunkenChestId',
    `Location`.`longitude`,
    `Location`.`latitude`,
    `Island`.`name` AS 'islandName',
    CONCAT(`Rupee`.`value`, " Rupee(s)") AS 'treasure',
    `TreasureChart`.`chartNumber`
FROM `SunkenRupee`

LEFT JOIN `SunkenChest` ON
    `SunkenRupee`.`sunkenChestId` = `SunkenChest`.`id`
LEFT JOIN `Location` ON
    `SunkenChest`.`expectedLocationId` = `Location`.`id`
LEFT JOIN `Island` ON
    `Location`.`id` = `Island`.`locationId`

LEFT JOIN `TreasureChart` ON
    `SunkenRupee`.`chartId` = `TreasureChart`.`id`

LEFT JOIN `Rupee` ON
    `SunkenRupee`.`rupeeId` = `Rupee`.`id`
) AS `sunk`
ORDER BY `sunk`.`longitude`, `sunk`.`latitude`
;
