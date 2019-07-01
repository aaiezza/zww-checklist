-- .width 20 %
SELECT
    `SunkenThing`.`treasure`,
    SUBSTR('00' || COUNT(`SunkenThing`.`id`), -2, 2) AS "count"
FROM `SunkenThing`
GROUP BY `SunkenThing`.`treasure`;
