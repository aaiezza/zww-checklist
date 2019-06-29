SELECT
    `OtherChart`.`name` AS "Sunken Chart",
    `SunkenTreasure`.`location`,
    `SunkenTreasure`.`chart_number` AS "Use Chart #"
FROM `SunkenTreasure`
INNER JOIN `SunkenChart` ON
    `SunkenTreasure`.`number` = `SunkenChart`.`sunkenTreasureNumber`
INNER JOIN `OtherChart` ON
    `SunkenChart`.`otherChartNumber` = `OtherChart`.`number`
ORDER BY `SunkenTreasure`.`location`;