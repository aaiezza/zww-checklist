.width 2 %
SELECT `Location`.`coordinate`, `HeartPiece`.`task` AS "Heart Piece"
    FROM (SELECT `Latitude`.`value`||`Longitude`.`value` AS "coordinate"
        FROM `Latitude` CROSS JOIN `Longitude`) AS "Location" LEFT JOIN `HeartPiece` ON
            `Location`.`coordinate` = `HeartPiece`.`latitude`||`HeartPiece`.`longitude`;
