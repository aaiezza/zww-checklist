.width 2 2 45
SELECT `latitude` || `longitude` AS "coordinates", SUBSTR('00' || `number`, -2, 2) AS "#", `details` FROM `TreasureChart`;
