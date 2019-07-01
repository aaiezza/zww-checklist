-- Zelda Wind Waker Checklist

PRAGMA foreign_keys = ON;

BEGIN;

DROP TABLE IF EXISTS `Island`;
DROP TABLE IF EXISTS `HeartContainer`;
DROP TABLE IF EXISTS `HeartPiece`;
DROP TABLE IF EXISTS `Item`;
DROP TABLE IF EXISTS `Chart`;
DROP TABLE IF EXISTS `ChartType`;
DROP TABLE IF EXISTS `SunkenTreasureOtherChart`;
DROP TABLE IF EXISTS `SunkenTreasure`;
DROP TABLE IF EXISTS `OtherChart`;

DROP TABLE IF EXISTS `Location`;

--------------------
-- Map Coordinates
--------------------
-- Longitude
--------------------
DROP TABLE IF EXISTS `Longitude`;
CREATE TABLE IF NOT EXISTS `Longitude`(
    `value` CHAR(1) PRIMARY KEY NOT NULL
);
INSERT INTO `Longitude` ( `value` ) VALUES
    ('A'), ('B'), ('C'), ('D'), ('E'), ('F'), ('G');

-- Latitude
--------------------
DROP TABLE IF EXISTS `Latitude`;
CREATE TABLE IF NOT EXISTS `Latitude`(
    `value` UNSIGNED TINYINT(1) PRIMARY KEY NOT NULL
);
INSERT INTO `Latitude` ( `value` ) VALUES
    (1), (2), (3), (4), (5), (6), (7);

-- Location
--------------------
CREATE TABLE IF NOT EXISTS `Location`(
    `id` INTEGER PRIMARY KEY NOT NULL,
    `coordinate` CHAR(2) NOT NULL,
    `longitude` UNSIGNED TINYINT(1) NOT NULL,
    `latitude` CHAR(1) NOT NULL,
        FOREIGN KEY (`longitude`) REFERENCES `Longitude`(`value`),
        FOREIGN KEY (`latitude`)  REFERENCES `Latitude`(`value`)
);
CREATE UNIQUE INDEX `location_coordinate` ON
    `Location`(`coordinate`);
CREATE UNIQUE INDEX `location_longitude_latitude` ON
    `Location`(`longitude`, `latitude`);

INSERT INTO `Location` (
    `id`, `coordinate`, `longitude`, `latitude`
)
SELECT
    ROW_NUMBER() OVER() AS "id",
    `Longitude`.`value`||`Latitude`.`value` AS "coordinate",
    `Longitude`.`value` AS "longitude",
    `Latitude`.`value` AS "latitude"
FROM `Longitude` CROSS JOIN `Latitude`
    ORDER BY `Longitude`.`value`, `Latitude`.`value`
;

-- Island
--------------------
CREATE TABLE IF NOT EXISTS `Island`(
    `name` VARCHAR(100) PRIMARY KEY NOT NULL,
    `location` CHAR(2) NOT NULL,
        FOREIGN KEY (`location`) REFERENCES `Location`(`coordinate`)
);
CREATE UNIQUE INDEX `island_location` ON
    `Island`(`location`);

INSERT INTO `Island` (
    `name`, `location`
) VALUES
    ("Forsaken Fortress",        'A1'),
    ("Four-Eye Reef",            'A2'),
    ("Western Fairy Island",     'A3'),
    ("Three-Eye Reef",           'A4'),
    ("Needle Rock Isle",         'A5'),
    ("Diamond Steppe Island",    'A6'),
    ("Horseshoe Island",         'A7'),

    ("Star Island",              'B1'),
    ("Mother & Child Isles",     'B2'),
    ("Rock Spire Island",        'B3'),
    ("Greatfish Island",         'B4'),
    ("Islet of Steel",           'B5'),
    ("Five-Eye Reef",            'B6'),
    ("Outset Island",            'B7'),

    ("Northern Fairy Island",    'C1'),
    ("Spectacle Island",         'C2'),
    ("Tingle Island",            'C3'),
    ("Cyclops Reef",             'C4'),
    ("Stone Watcher Island",     'C5'),
    ("Shark Island",             'C6'),
    ("Headstone Island",         'C7'),

    ("Gale Isle",                'D1'),
    ("Windfall Island",          'D2'),
    ("Northern Triangle Island", 'D3'),
    ("Six-Eye Reef",             'D4'),
    ("Southern Triangle Island", 'D5'),
    ("Southern Fairy Island",    'D6'),
    ("Two-Eye Reef",             'D7'),

    ("Crescent Moon Island",     'E1'),
    ("Pawprint Isle",            'E2'),
    ("Eastern Fairy Island",     'E3'),
    ("Tower of the Gods",        'E4'),
    ("Private Oasis",            'E5'),
    ("Ice Ring Isle",            'E6'),
    ("Angular Isles",            'E7'),

    ("Seven-Star Isles",         'F1'),
    ("Dragon Roost Island",      'F2'),
    ("Fire Mountain",            'F3'),
    ("Eastern Triangle Island",  'F4'),
    ("Bomb Island",              'F5'),
    ("Forest Haven",             'F6'),
    ("Boating Course",           'F7'),

    ("Overlook Island",          'G1'),
    ("Flight Control Platform",  'G2'),
    ("Star Belt Archipelago",    'G3'),
    ("Thorned Fairy Island",     'G4'),
    ("Bird's Peak Rock",         'G5'),
    ("Cliff Plateau Isles",      'G6'),
    ("Five-Star Isles",          'G7')
;

--------------------
-- Features
--------------------
-- Heart Containers
--------------------
CREATE TABLE IF NOT EXISTS `HeartContainer`(
    `id` INTEGER PRIMARY KEY NOT NULL,
    `location` CHAR(2),
    `details` VARCHAR(100) NOT NULL,
        FOREIGN KEY (`location`) REFERENCES `Location`(`coordinate`)
);
CREATE INDEX `heart_container_location` ON
    `HeartContainer`(`location`);

INSERT INTO `HeartContainer` (
    `location`, `details`
) VALUES
    ('F2', "Dragon Roost Cavern"),
    ('F6', "Forbidden Woods"),
    ('E4', "Tower of the Gods"),
    ('A1', "2nd visit"),
    ('C7', "Earth Temple"),
    ('D1', "Wind Temple")
;

-- Heart Pieces
--------------------
CREATE TABLE IF NOT EXISTS `HeartPiece`(
    `id` INTEGER PRIMARY KEY NOT NULL,
    `location` CHAR(2),
    `task` VARCHAR(100) NOT NULL,
        FOREIGN KEY (`location`) REFERENCES `Location`(`coordinate`)
);
CREATE INDEX `heart_piece_location` ON
    `HeartPiece`(`location`);

INSERT INTO `HeartPiece` (
    `id`, `location`, `task`
) VALUES
    (01, 'A1', "Locked in a jail cell; Use button to open door"),
    (02, 'A4', "Use Treasure Chart 38"),
    (03, 'A5', "Use Seagull to hit switch to put out flames"),
    (04, 'A6', "Use Treasure Chart 23"),
    (05, 'B1', "Clear the Secret Cave"),
    (06, 'B3', "950 Rupees at Beedle's Shop Ship"),
    (07, 'B3', "Use Treasure Chart 2"),
    (08, 'B3', "Defeat Cannon Boats and get from Light Ring"),
    (09, 'B4', "Use Deku Leaf from spiral island to ledge"),
    (10, 'B4', "Give Traveling Merchant a Shop Guru Statue"),
    (11, 'B7', "Hit Orca 500 times"),
    (12, 'B7', "Carry large pig to black dirt and use bait"),
    (13, 'B7', "Clear the Secret Cave (all 50 floors)"),
    (14, 'C2', "Win the Cannon Shoot mini-game (1st)"),
    (15, 'C3', "Defeat the Big Octo (12 eyes)"),
    (16, 'C5', "Destroy th Cannons on the Platform"),
    (17, 'C7', "Use Seagull to fetch from top of mountain"),
    (18, 'D2', "Win the hide-and-seek game with the kids"),
    (19, 'D2', "Win the Zee Fleet mini-game (1st)"),
    (20, 'D2', "Get the two people to start datig"),
    (21, 'D2', "Win the Auction (3rd item)"),
    (22, 'D2', "Decorate the town and talk to man on bench"),
    (23, 'D2', "Light the lighthouse; Talk to operator"),
    (24, 'D2', "Light the lighthouse; Chest on small island"),
    (25, 'D2', "Give Moe's letter to Maggie"),
    (26, 'D4', "Clear the Submarine"),
    (27, 'D6', "Use Treasure Chart 4"),
    (28, 'E1', "Use Treasure Chart 11"),
    (29, 'E2', "Use Treasure Chart 30"),
    (30, 'E2', "At the back of the Turtle Dome Secret Cave"),
    (31, 'E7', "Use Treasure Chart 15"),
    (32, 'E7', "On the top of the block-puzzle mountain"),
    (33, 'F1', "Defeat the Big Octo (12 eyes)"),
    (34, 'F2', "Letter after defeating Kalle Demos"),
    (35, 'F2', "Letter after delivering part-timer's letter"),
    (36, 'F2', "Letter after give 20 Golden Feathers to guard"),
    (37, 'F5', "Clear the Secret Cave"),
    (38, 'F5', "Use Treasure Chart 20"),
    (39, 'F6', "Complete the Wilted Deku Tree side quest"),
    (40, 'F6', "Use Treasure Chart 31"),
    (41, 'G2', "Win the Bird-Man Contest mini-game"),
    (42, 'G4', "Use Treasure Chart 5"),
    (43, 'G7', "Clear the Submarine"),
    (44, 'G7', "Use Treasure Chart 33")
;

-- Items
--------------------
CREATE TABLE IF NOT EXISTS `Item`(
    `id` INTEGER PRIMARY KEY NOT NULL,
    `name` VARCHAR(50) NOT NULL,
    `location` CHAR(2),
    `details` VARCHAR(100) NOT NULL,
    `required` BOOLEAN DEFAULT 1 NOT NULL,
        FOREIGN KEY (`location`) REFERENCES `Location`(`coordinate`)
);
CREATE INDEX `item_location` ON
    `Item`(`location`);

INSERT INTO `Item` (
    `id`, `location`, `required`, `name`, `details`
) VALUES
    (01, 'B7', 1, "Telescope",              "Aryll"),
    (02, 'B7', 1, "Hero's Sword",           "Orca"),
    (03, 'B7', 1, "Hero's Sheild",          "Granny"),
    (04, 'B7', 1, "Spoils Bag",             "Tetra's Pirate Ship - Niko's Rope Challenge"),
    (05, 'A1', 1, "Pirate's Charm",         "Tetra"),
    (06, 'D2', 1, "Sail",                   "Zunari (80 Rupees)"),
    (07, 'D2', 0, "Tingle Tuner",           "Tingle"),
    (08, 'D2', 0, "Picto Box",              "Tingle's cell maze"),
    (09, 'F2', 1, "Wind Waker",             "The King of Red Lions"),
    (10, 'F2', 1, "Delivery Bag",           "Quill"),
    (11, 'F2', 1, "Bottle 1",               "Medli"),
    (12, 'F2', 1, "Grappling Hook",         "Dragon Roost Cavern"),
    (13, 'F2', 1, "Din's Pearl",            "Komali"),
    (14, 'F5', 0, "Bottle 2",               "Submarine"),
    (15, 'F6', 1, "Deku Leaf",              "Great Deku Tree"),
    (16, 'F6', 1, "Boomerang",              "Forbidden Woods"),
    (17, 'F6', 1, "Farore's Pearl",         "Great Deku Tree"),
    (18, 'D2', 1, "Bombs",                  "Tetra's Pirate Ship - Niko's Rope Challenge"),
    (19, 'B7', 1, "Nayru's Pearl",          "Jabun"),
    (20, 'E4', 1, "Hero's Bow",             "Tower of the Gods"),
    (21, 'E4', 1, "Master Sword",           "Hyrule Castle"),
    (22, 'A1', 1, "Skull Hammer",           "Phantom Ganon"),
    (23, 'B2', 1, "Fire & Ice Arrows",      "Fairy Queen"),
    (24, 'F3', 1, "Power Bracelets",        "Secret Cave"),
    (25, 'C7', 1, "Mirror Shield",          "Earth Temple"),
    (26, 'C7', 1, "Master Sword Restore 1", "Earth Temple"),
    (27, 'E6', 1, "Iron Boots",             "Secret Cave"),
    (28, 'D1', 1, "Hookshot",               "Wind Temple"),
    (29, 'D1', 1, "Master Sword Restore 2", "Wind Temple"),
    (30, NULL, 1, "Bait Bag",               "Beedle Shop Ship"),
    (31, 'D2', 1, "Cabana Deed",            "Mrs. Marie (20 Joy Pendants)"),
    (32, NULL, 1, "Triforce of Courage",    "Triforce Chart x8"),
    (33, 'D2', 0, "Deluxe Picto Box",       "Lenzo"),
    (34, 'D2', 0, "Hero's Charm",           "Mrs. Marie (40 Joy Pendants)"),
    (35, 'B3', 0, "Bottle 3",               "Beedle Special Shop (500 Rupees)"),
    (36, 'D2', 0, "Magic Armor",            "Zunari (Exotic Flower)"),
    (37, 'D2', 0, "Bottle 4",               "Mila")
;

-- Treasure Charts
--------------------
CREATE TABLE IF NOT EXISTS `TreasureChart`(
    `number` INTEGER PRIMARY KEY NOT NULL,
    `location` CHAR(2),
    `details` VARCHAR(100) NOT NULL,
        FOREIGN KEY (`location`) REFERENCES `Location`(`coordinate`)
);
CREATE INDEX `treasure_chart_location` ON
    `TreasureChart`(`location`);

INSERT INTO `TreasureChart` (
    `number`, `location`, `details`
) VALUES
    (01, 'F6', "In Forbidden Woods"),
    (02, 'D2', "Give Maggie's Father 20 Skull Necklaces"),
    (03, 'F6', "Small island outside Forest Haven, Deku Leaf"),
    (04, 'B3', "Beedle Special Shop (900 Rupees)"),
    (05, 'D1', "In Wind Temple"),
    (06, 'E4', "In Tower of the Gods"),
    (07, 'D2', "Win the Zee Fleet mini-game (2nd)"),
    (08, 'A7', "Clear the Secret Cave"),
    (09, 'E1', "Clear the Submarine"),
    (10, 'E1', "Sitting on the island"),
    (11, 'F2', "In Dragon Roost Cavern"),
    (12, 'C7', "In Earth Temple"),
    (13, 'D7', "Clear the artillery from the reef"),
    (14, 'C7', "Clear the Submarine"),
    (15, 'F6', "In Forbidden Woods"),
    (16, 'F1', "Clear the Platforms"),
    (17, 'C2', "Win the Cannon Shoot mini-game (2nd)"),
    (18, 'D2', "Win the Auction (2nd)"),
    (19, 'A2', "Clear all artillery from the reef"),
    (20, 'C7', "In Earth Temple"),
    (21, 'C4', "Clear all artillery from the reef"),
    (22, 'C1', "Clear the Submarine"),
    (23, 'D2', "Win the Zee Fleet mini-game (3rd)"),
    (24, 'D2', "Show Lenzo & friend picto to gossip ladies"),
    (25, 'G6', "Use Secret Cave to reach it on high cliff"),
    (26, 'D4', "Clear all artillery from the reef"),
    (27, 'E5', "On top of the cliff"),
    (28, 'A7', "Finish the ""Golf"" game with the Boko Nuts"),
    (29, 'D2', "Secret room in Lenzo's house"),
    (30, 'E4', "In Tower of the Gods"),
    (31, 'D2', "Show full moon picto to man on steps"),
    (32, 'A4', "Clear all artillery from the reef"),
    (33, 'D2', "Show picto of old beauty queen to herself"),
    (34, 'F4', "Given by Salvage Corp."),
    (35, 'D1', "In Wind Temple"),
    (36, 'E6', "Use Fire Arrows on iced chest"),
    (37, 'B3', "Clear the Secret Cave"),
    (38, 'D2', "Win the Auction (1st)"),
    (39, 'F2', "In Dragon Roost Cavern"),
    (40, 'D6', "Clear the Platforms"),
    (41, 'B6', "Clear the artillery from the reef")
;

-- Triforce Charts
--------------------
CREATE TABLE IF NOT EXISTS `TriforceChart`(
    `number` INTEGER PRIMARY KEY NOT NULL,
    `location` CHAR(2),
    `details` VARCHAR(100) NOT NULL,
        FOREIGN KEY (`location`) REFERENCES `Location`(`coordinate`)
);
CREATE INDEX `triforce_chart_location` ON
    `TriforceChart`(`location`);

INSERT INTO `TriforceChart` (
    `number`, `location`, `details`
) VALUES
    (01, 'B5', "Inside the ""Secret Cave"""),
    (02, 'E5', "Clear the Secret Cave (fireplace"),
    (03, 'G5', "Use Seagull to hit 5 switchs; In Secret Cave"),
    (04, NULL, "Clear the Ghost Ship (G7,G3,B4,E1,A6,F5,C2)"),
    (05, 'A5', "Defeat Golden Cannon Boat; light ring"),
    (06, 'B7', "Clear the Secret Cave (level 30)"),
    (07, 'C5', "Clear the Secret Cave"),
    (08, 'G1', "Clear the Secret Cave")
;

-- Triforce Shards
--------------------
CREATE TABLE IF NOT EXISTS `TriforceShard`(
    `id` INTEGER PRIMARY KEY NOT NULL,
    `location` CHAR(2),
        FOREIGN KEY (`location`) REFERENCES `Location`(`coordinate`)
);
CREATE INDEX `triforce_shard_location` ON
    `TriforceShard`(`location`);

INSERT INTO `TriforceShard` (
    `id`, `location`
) VALUES
    (01, 'B4'),
    (02, 'B7'),
    (03, 'C5'),
    (04, 'D1'),
    (05, 'D5'),
    (06, 'D7'),
    (07, 'F1'),
    (08, 'G6')
;

-- Other Charts
--------------------
CREATE TABLE IF NOT EXISTS `OtherChart`(
    `number` INTEGER PRIMARY KEY NOT NULL,
    `location` CHAR(2),
    `name` VARCHAR(17) NOT NULL,
    `details` VARCHAR(50) NOT NULL,
        FOREIGN KEY (`location`) REFERENCES `Location`(`coordinate`)
);
CREATE INDEX `other_chart_location` ON
    `OtherChart`(`location`);
CREATE UNIQUE INDEX `other_chart_name` ON
    `OtherChart`(`name`);

INSERT INTO `OtherChart` (
    `number`, `location`, `name`, `details`
) VALUES
    (01, 'A6', "Ghost Ship Chart",    "Clear the Secret Cave"),
    (02, 'D2', "Tingle's Chart",      "Free Tingle from jail"),
    (03, NULL, "IN-credible Chart",   "Letter, after Zelda"),
    (04, 'D3', "Octo Chart",          "Use Treasure Chart 26"),
    (05, 'A2', "Great Fairy Chart",   "Use Treasure Chart 41"),
    (06, 'G2', "Island Hearts Chart", "Use Treasure Chart 19"),
    (07, 'F7', "Sea Hearts Chart",    "Use Treasure Chart 32"),
    (08, 'G1', "Secret Cave Chart",   "Use Treasure Chart 13"),
    (09, 'C4', "Light Ring Chart",    "Use Treasure Chart 21"),
    (10, 'G2', "Platform Chart",      "Clear the Submarine"),
    (11, NULL, "Beedle's Chart",      "Letter, after Bombs"),
    (12, 'F7', "Submarine Chart",     "Clear the Secret Cave")
;

-- Sunken Treasure → Heart Pieces
--------------------
CREATE TABLE IF NOT EXISTS `SunkenHeartPiece`(
    `id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    `treasureChartNumber` INTEGER NOT NULL,
    `heartPieceId` INTEGER NOT NULL,
        FOREIGN KEY (`treasureChartNumber`) REFERENCES
            `TreasureChart`(`number`),
        FOREIGN KEY (`heartPieceId`) REFERENCES
            `HeartPiece`(`id`)
);
CREATE UNIQUE INDEX `sunken_heart_piece_tcNum` ON
    `SunkenHeartPiece`(`treasureChartNumber`);
CREATE UNIQUE INDEX `sunken_heart_piece_hpId` ON
    `SunkenHeartPiece`(`heartPieceId`);

INSERT INTO `SunkenHeartPiece` (
    `treasureChartNumber`, `heartPieceId`
) VALUES
    (38, 02), -- A4
    (23, 04), -- A6
    (02, 07), -- B3
    (04, 27), -- D6
    (11, 28), -- E1
    (30, 29), -- E2
    (15, 31), -- E7
    (20, 38), -- F5
    (31, 40), -- F6
    (05, 42), -- G4
    (33, 44)  -- G7
;

-- Sunken Treasure → Triforce Shards
--------------------
CREATE TABLE IF NOT EXISTS `SunkenTriforceShard`(
    `id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    `triforceChartNumber` INTEGER NOT NULL,
    `triforceShardId` INTEGER NOT NULL,
        FOREIGN KEY (`triforceChartNumber`) REFERENCES
            `TriforceChart`(`number`),
        FOREIGN KEY (`triforceShardId`) REFERENCES
            `TriforceShard`(`id`)
);
CREATE UNIQUE INDEX `sunken_triforce_shard_tcNum` ON
    `SunkenTriforceShard`(`triforceChartNumber`);
CREATE UNIQUE INDEX `sunken_triforce_shard_tsId` ON
    `SunkenTriforceShard`(`triforceShardId`);

INSERT INTO `SunkenTriforceShard` (
    `triforceChartNumber`, `triforceShardId`
) VALUES
    (01, 01), -- B4
    (04, 02), -- B7
    (03, 03), -- C5
    (02, 04), -- D1
    (06, 05), -- D5
    (08, 06), -- D7
    (07, 07), -- F1
    (05, 08)  -- G6
;

-- Sunken Treasure → Other Charts
--------------------
CREATE TABLE IF NOT EXISTS `SunkenChart`(
    `id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    `treasureChartNumber` INTEGER NOT NULL,
    `otherChartNumber` INTEGER NOT NULL,
        FOREIGN KEY (`treasureChartNumber`) REFERENCES
            `TreasureChart`(`number`),
        FOREIGN KEY (`otherChartNumber`) REFERENCES
            `OtherChart`(`number`)
);
CREATE UNIQUE INDEX `sunken_chart_tcNum` ON
    `SunkenChart`(`treasureChartNumber`);
CREATE UNIQUE INDEX `sunken_chart_ocNum` ON
    `SunkenChart`(`otherChartNumber`);

INSERT INTO `SunkenChart` (
    `treasureChartNumber`, `otherChartNumber`
) VALUES
    (26, 04), -- D3
    (41, 05), -- A2
    (19, 06), -- G2
    (32, 07), -- F7
    (13, 08), -- G1
    (21, 09)  -- C4
;

-- Sunken Treasure → Rupees
--------------------
CREATE TABLE IF NOT EXISTS `SunkenRupee`(
    `id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    `treasureChartNumber` INTEGER NOT NULL,
    `location` CHAR(2) NOT NULL,
    `rupee_value` UNSIGNED INTEGER NOT NULL,
        FOREIGN KEY (`treasureChartNumber`) REFERENCES
            `TreasureChart`(`number`),
        FOREIGN KEY (`location`) REFERENCES
            `Location`(`coordinate`)
);
CREATE UNIQUE INDEX `sunken_rupee_tcNum` ON
    `SunkenRupee`(`treasureChartNumber`);
CREATE INDEX `sunken_rupee_location` ON
    `Location`(`coordinate`);

INSERT INTO `SunkenRupee` (
    `treasureChartNumber`, `location`, `rupee_value`
) VALUES
    (25, 'A1', 200),
    (08, 'A3', 200),
    (28, 'A5', 200),
    (09, 'A7', 200),
    (07, 'B1', 200),
    (29, 'B2', 200),
    (35, 'B5', 200),
    (12, 'B6', 200),
    (24, 'C1', 200),
    (22, 'C2', 200),
    (10, 'C3', 200),
    (16, 'C6', 200),
    (40, 'C7', 200),
    (18, 'D2', 001),
    (06, 'D4', 200),
    (03, 'E3', 200),
    (14, 'E4', 200),
    (01, 'E5', 200),
    (17, 'E6', 200),
    (39, 'F2', 200),
    (37, 'F3', 200),
    (34, 'F4', 200),
    (27, 'G3', 200),
    (36, 'G5', 200)
;

-- .width 2 2 17 2 19
CREATE VIEW IF NOT EXISTS `SunkenThing` AS
SELECT
    SUBSTR('00' || ROW_NUMBER() OVER(ORDER BY `sunk`.`location`), -2, 2) AS "id",
    CASE WHEN `sunk`.`chart location` IS NULL THEN
        '~~' ELSE `sunk`.`chart location` END AS `chart location`,
    `sunk`.`chart`,
    `sunk`.`location`,
    `sunk`.`treasure`
FROM (
SELECT
    `TreasureChart`.`location` AS "chart location",
    "Treasure Chart "||SUBSTR('00' || `TreasureChart`.`number`, -2, 2) AS `chart`,
    `SunkenRupee`.`location` AS `location`,
    `SunkenRupee`.`rupee_value`||(
        CASE WHEN `SunkenRupee`.`rupee_value` <= 1 THEN
            " Rupee" ELSE " Rupees" END) AS `treasure`
FROM `SunkenRupee`
LEFT JOIN `TreasureChart` ON
    `SunkenRupee`.`treasureChartNumber` = `TreasureChart`.`number`
UNION
SELECT
    `TreasureChart`.`location` AS "chart location",
    "Treasure Chart "||SUBSTR('00' || `TreasureChart`.`number`, -2, 2) AS `chart`,
    `HeartPiece`.`location`,
    "Heart Piece" AS `treasure`
FROM `SunkenHeartPiece`
LEFT JOIN `HeartPiece` ON
    `SunkenHeartPiece`.`heartPieceId` = `HeartPiece`.`id`
LEFT JOIN `TreasureChart` ON
    `SunkenHeartPiece`.`treasureChartNumber` = `TreasureChart`.`number`
UNION
SELECT
    `TriforceChart`.`location` AS "chart location",
    "Triforce Chart "||SUBSTR('00' || `TriforceChart`.`number`, -2, 2) AS `chart`,
    `TriforceShard`.`location`,
    "Triforce Shard" AS `treasure`
FROM `SunkenTriforceShard`
LEFT JOIN `TriforceShard` ON
    `SunkenTriforceShard`.`triforceShardId` = `TriforceShard`.`id`
LEFT JOIN `TriforceChart` ON
    `SunkenTriforceShard`.`triforceChartNumber` = `TriforceChart`.`number`
UNION
SELECT
    `TreasureChart`.`location` AS "chart location",
    "Treasure Chart "||SUBSTR('00' || `TreasureChart`.`number`, -2, 2) AS `chart`,
    `OtherChart`.`location`,
    `OtherChart`.`name` AS `treasure`
FROM `SunkenChart`
LEFT JOIN `OtherChart` ON
    `SunkenChart`.`otherChartNumber` = `OtherChart`.`number`
LEFT JOIN `TreasureChart` ON
    `SunkenChart`.`treasureChartNumber` = `TreasureChart`.`number`
) `sunk`
ORDER BY `sunk`.`location`
;

END;
