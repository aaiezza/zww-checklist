.width 2 %
SELECT
    `Location`.`coordinate`,
    COUNT(`HeartPiece`.`id`)
    -- , CASE WHEN `HeartPiece`.`task` IS NOT NULL THEN COUNT(`HeartPiece`.`id`) ELSE NULL END
    AS "Heart Piece"
FROM (SELECT `Latitude`.`value`||`Longitude`.`value` AS "coordinate"
    FROM `Latitude` CROSS JOIN `Longitude`) AS "Location" LEFT JOIN `HeartPiece` ON
        `Location`.`coordinate` = `HeartPiece`.`latitude`||`HeartPiece`.`longitude`
GROUP BY `Location`.`coordinate`;
