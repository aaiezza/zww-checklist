-- .width 2 22 45 3
SELECT
    `location` AS "coordinates",
    `name`,
    `details`,
    CASE WHEN `required` THEN
        '' ELSE 'Optional' END AS "required"
FROM `Item`;
