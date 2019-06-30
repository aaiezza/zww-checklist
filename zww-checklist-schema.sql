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
    `id` INTEGER AUTOINCREMENT PRIMARY KEY NOT NULL,
    `location` CHAR(2),
    `task` VARCHAR(100) NOT NULL,
        FOREIGN KEY (`location`) REFERENCES `Location`(`coordinate`)
);
CREATE INDEX `heart_piece_location` ON
    `HeartPiece`(`location`);

INSERT INTO `HeartPiece` (
    `location`, `task`
) VALUES
    ('A1', "Locked in a jail cell; Use button to open door"),
    ('A4', "Use Treasure Chart 38"),
    ('A5', "Use Seagull to hit switch to put out flames"),
    ('A6', "Use Treasure Chart 23"),
    ('B1', "Clear the Secret Cave"),
    ('B3', "950 Rupees at Beedle's Shop Ship"),
    ('B3', "Use Treasure Chart 2"),
    ('B3', "Defeat Cannon Boats and get from Light Ring"),
    ('B4', "Use Deku Leaf from spiral island to ledge"),
    ('B4', "Give Traveling Merchant a Shop Guru Statue"),
    ('B7', "Hit Orca 500 times"),
    ('B7', "Carry large pig to black dirt and use bait"),
    ('B7', "Clear the Secret Cave (all 50 floors)"),
    ('C2', "Win the Cannon Shoot mini-game (1st)"),
    ('C3', "Defeat the Big Octo (12 eyes)"),
    ('C5', "Destroy th Cannons on the Platform"),
    ('C7', "Use Seagull to fetch from top of mountain"),
    ('D2', "Win the hide-and-seek game with the kids"),
    ('D2', "Win the Zee Fleet mini-game (1st)"),
    ('D2', "Get the two people to start datig"),
    ('D2', "Win the Auction (3rd item)"),
    ('D2', "Decorate the town and talk to man on bench"),
    ('D2', "Light the lighthouse; Talk to operator"),
    ('D2', "Light the lighthouse; Chest on small island"),
    ('D2', "Give Moe's letter to Maggie"),
    ('D4', "Clear the Submarine"),
    ('D6', "Use Treasure Chart 4"),
    ('E1', "Use Treasure Chart 11"),
    ('E2', "Use Treasure Chart 30"),
    ('E2', "At the back of the Turtle Dome Secret Cave"),
    ('E7', "Use Treasure Chart 15"),
    ('E7', "On the top of the block-puzzle mountain"),
    ('F1', "Defeat the Big Octo (12 eyes)"),
    ('F2', "Letter after defeating Kalle Demos"),
    ('F2', "Letter after delivering part-timer's letter"),
    ('F2', "Letter after give 20 Golden Feathers to guard"),
    ('F5', "Clear the Secret Cave"),
    ('F5', "Use Treasure Chart 20"),
    ('F6', "Complete the Wilted Deku Tree side quest"),
    ('F6', "Use Treasure Chart 31"),
    ('G2', "Win the Bird-Man Contest mini-game"),
    ('G4', "Use Treasure Chart 5"),
    ('G7', "Clear the Submarine"),
    ('G7', "Use Treasure Chart 33")
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
    `location`, `required`, `name`, `details`
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

-- Treasure & Triforce Chart Types
--------------------
CREATE TABLE IF NOT EXISTS `ChartType`(
    `name` VARCHAR(7) PRIMARY KEY NOT NULL
);

INSERT INTO `ChartType`(`name`) VALUES
    ('Treasure'), ('Triforce')
;

-- Treasure/Triforce Charts
--------------------
CREATE TABLE IF NOT EXISTS `Chart`(
    `number` INTEGER NOT NULL,
    `location` CHAR(2),
    `type` VARCHAR(7) NOT NULL,
    `details` VARCHAR(100) NOT NULL,
        PRIMARY KEY (`number`, `type`),
        FOREIGN KEY (`location`) REFERENCES `Location`(`coordinate`),
        FOREIGN KEY (`type`) REFERENCES `ChartType`(`name`)
);
CREATE INDEX `treasure_chart_location` ON
    `Chart`(`location`);

INSERT INTO `Chart` (
    `number`, `type`, `location`, `details`
) VALUES
    (01, 'Treasure', 'F6', "In Forbidden Woods"),
    (02, 'Treasure', 'D2', "Give Maggie's Father 20 Skull Necklaces"),
    (03, 'Treasure', 'F6', "Small island outside Forest Haven, Deku Leaf"),
    (04, 'Treasure', 'B3', "Beedle Special Shop (900 Rupees)"),
    (05, 'Treasure', 'D1', "In Wind Temple"),
    (06, 'Treasure', 'E4', "In Tower of the Gods"),
    (07, 'Treasure', 'D2', "Win the Zee Fleet mini-game (2nd)"),
    (08, 'Treasure', 'A7', "Clear the Secret Cave"),
    (09, 'Treasure', 'E1', "Clear the Submarine"),
    (10, 'Treasure', 'E1', "Sitting on the island"),
    (11, 'Treasure', 'F2', "In Dragon Roost Cavern"),
    (12, 'Treasure', 'C7', "In Earth Temple"),
    (13, 'Treasure', 'D7', "Clear the artillery from the reef"),
    (14, 'Treasure', 'C7', "Clear the Submarine"),
    (15, 'Treasure', 'F6', "In Forbidden Woods"),
    (16, 'Treasure', 'F1', "Clear the Platforms"),
    (17, 'Treasure', 'C2', "Win the Cannon Shoot mini-game (2nd)"),
    (18, 'Treasure', 'D2', "Win the Auction (2nd)"),
    (19, 'Treasure', 'A2', "Clear all artillery from the reef"),
    (20, 'Treasure', 'C7', "In Earth Temple"),
    (21, 'Treasure', 'C4', "Clear all artillery from the reef"),
    (22, 'Treasure', 'C1', "Clear the Submarine"),
    (23, 'Treasure', 'D2', "Win the Zee Fleet mini-game (3rd)"),
    (24, 'Treasure', 'D2', "Show Lenzo & friend picto to gossip ladies"),
    (25, 'Treasure', 'G6', "Use Secret Cave to reach it on high cliff"),
    (26, 'Treasure', 'D4', "Clear all artillery from the reef"),
    (27, 'Treasure', 'E5', "On top of the cliff"),
    (28, 'Treasure', 'A7', "Finish the ""Golf"" game with the Boko Nuts"),
    (29, 'Treasure', 'D2', "Secret room in Lenzo's house"),
    (30, 'Treasure', 'E4', "In Tower of the Gods"),
    (31, 'Treasure', 'D2', "Show full moon picto to man on steps"),
    (32, 'Treasure', 'A4', "Clear all artillery from the reef"),
    (33, 'Treasure', 'D2', "Show picto of old beauty queen to herself"),
    (34, 'Treasure', 'F4', "Given by Salvage Corp."),
    (35, 'Treasure', 'D1', "In Wind Temple"),
    (36, 'Treasure', 'E6', "Use Fire Arrows on iced chest"),
    (37, 'Treasure', 'B3', "Clear the Secret Cave"),
    (38, 'Treasure', 'D2', "Win the Auction (1st)"),
    (39, 'Treasure', 'F2', "In Dragon Roost Cavern"),
    (40, 'Treasure', 'D6', "Clear the Platforms"),
    (41, 'Treasure', 'B6', "Clear the artillery from the reef"),

    (01, 'Triforce', 'B5', "Inside the ""Secret Cave"""),
    (02, 'Triforce', 'E5', "Clear the Secret Cave (fireplace"),
    (03, 'Triforce', 'G5', "Use Seagull to hit 5 switchs; In Secret Cave"),
    (04, 'Triforce', NULL, "Clear the Ghost Ship (G7,G3,B4,E1,A6,F5,C2)"),
    (05, 'Triforce', 'A5', "Defeat Golden Cannon Boat; light ring"),
    (06, 'Triforce', 'B7', "Clear the Secret Cave (level 30)"),
    (07, 'Triforce', 'C5', "Clear the Secret Cave"),
    (08, 'Triforce', 'G1', "Clear the Secret Cave")
;

-- Treasure
--------------------
CREATE TABLE IF NOT EXISTS `Treasure`(
    `id` INTEGER PRIMARY KEY NOT NULL,
    `name` VARCHAR(50) NOT NULL
);
CREATE UNIQUE INDEX `treasure_name` ON
    `Treasure`(`name`);

INSERT INTO `Treasure` (
    `id`, `name`
) VALUES
    (01, '1 Rupees'),
    (02, '5 Rupees'),
    (03, '10 Rupees'),
    (04, '20 Rupees'),
    (05, '50 Rupees'),
    (06, '100 Rupees'),
    (07, '200 Rupees'),
    (08, 'Joy Pendant'),
    (09, 'Skull Pendant'),
    (10, 'Treasure Chart'),
    (11, 'Triforce Chart'),
    (12, 'Heart Container'),
    (13, 'Heart Piece'),
    (14, 'Triforce Shard'),
    (15, 'Other Chart')
;

-- Sunken Treasures
--------------------
CREATE TABLE IF NOT EXISTS `SunkenTreasure`(
    `number` INTEGER PRIMARY KEY NOT NULL,
    `location` CHAR(2) NOT NULL,
    `chart_number` INTEGER NOT NULL,
    `chart_type` VARCHAR(7) NOT NULL,
    `treasure_id` INTEGER NOT NULL,
        FOREIGN KEY (`location`) REFERENCES `Location`(`coordinate`),
        FOREIGN KEY (`chart_number`, `chart_type`) REFERENCES `Chart`(`number`, `type`)
        FOREIGN KEY (`treasure_id`) REFERENCES `Treasure`(`id`)
);
CREATE INDEX `sunken_treasure_location` ON
    `SunkenTreasure`(`location`);

INSERT INTO `SunkenTreasure` (
    `number`, `location`, `chart_number`, `chart_type`, `treasure_id`
) VALUES
    (01, 'A1', 25, 'Treasure', 07),
    (02, 'A2', 41, 'Treasure', 15),
    (03, 'A3', 08, 'Treasure', 07),
    (04, 'A4', 38, 'Treasure', 13),
    (05, 'A5', 28, 'Treasure', 07),
    (06, 'A6', 23, 'Treasure', 13),
    (07, 'A7', 09, 'Treasure', 07),
    (08, 'B1', 07, 'Treasure', 07),
    (09, 'B2', 29, 'Treasure', 07),
    (10, 'B3', 02, 'Treasure', 13),
    (11, 'B4', 01, 'Triforce', 14),
    (12, 'B5', 35, 'Treasure', 07),
    (13, 'B6', 12, 'Treasure', 07),
    (14, 'B7', 04, 'Triforce', 14),
    (15, 'C1', 24, 'Treasure', 07),
    (16, 'C2', 22, 'Treasure', 07),
    (17, 'C3', 10, 'Treasure', 07),
    (18, 'C4', 21, 'Treasure', 15),
    (19, 'C5', 03, 'Triforce', 14),
    (20, 'C6', 16, 'Treasure', 07),
    (21, 'C7', 40, 'Treasure', 07),
    (22, 'D1', 02, 'Triforce', 14),
    (23, 'D2', 18, 'Treasure', 01),
    (24, 'D3', 26, 'Treasure', 15),
    (25, 'D4', 06, 'Treasure', 07),
    (26, 'D5', 06, 'Triforce', 14),
    (27, 'D6', 04, 'Treasure', 13),
    (28, 'D7', 08, 'Triforce', 14),
    (29, 'E1', 11, 'Treasure', 13),
    (30, 'E2', 30, 'Treasure', 13),
    (31, 'E3', 03, 'Treasure', 07),
    (32, 'E4', 14, 'Treasure', 07),
    (33, 'E5', 01, 'Treasure', 07),
    (34, 'E6', 17, 'Treasure', 07),
    (35, 'E7', 15, 'Treasure', 13),
    (36, 'F1', 07, 'Triforce', 14),
    (37, 'F2', 39, 'Treasure', 07),
    (38, 'F3', 37, 'Treasure', 07),
    (39, 'F4', 34, 'Treasure', 07),
    (40, 'F5', 20, 'Treasure', 13),
    (41, 'F6', 31, 'Treasure', 13),
    (42, 'F7', 32, 'Treasure', 15),
    (43, 'G1', 13, 'Treasure', 15),
    (44, 'G2', 19, 'Treasure', 15),
    (45, 'G3', 27, 'Treasure', 07),
    (46, 'G4', 05, 'Treasure', 13),
    (47, 'G5', 36, 'Treasure', 07),
    (48, 'G6', 05, 'Triforce', 14),
    (49, 'G7', 33, 'Treasure', 13)
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

-- Sunken Treasure → Other Charts
--------------------
CREATE TABLE IF NOT EXISTS `SunkenChart`(
    `sunkenTreasureNumber` INTEGER NOT NULL,
    `otherChartNumber` INTEGER NOT NULL,
        FOREIGN KEY (`sunkenTreasureNumber`) REFERENCES
            `SunkenTreasure`(`number`),
        FOREIGN KEY (`otherChartNumber`) REFERENCES
            `OtherChart`(`number`)
);
CREATE UNIQUE INDEX `sunken_chart_stNum` ON
    `SunkenChart`(`sunkenTreasureNumber`);
CREATE UNIQUE INDEX `sunken_other_chart_ocNum` ON
    `SunkenChart`(`otherChartNumber`);
CREATE TRIGGER otherChartSunkenTreasureLocation
BEFORE INSERT ON `SunkenChart`
BEGIN
        SELECT RAISE(FAIL, "That Sunken Treasure and Other Chart do not share the same location")
        FROM (SELECT COUNT(*) AS 'sunk'
            FROM `SunkenTreasure`
            INNER JOIN `OtherChart` USING(`location`)
            WHERE
                `SunkenTreasure`.`number` = NEW.`sunkenTreasureNumber` AND
                `OtherChart`.`number` = NEW.`otherChartNumber`) AS 'SunkenChart'
        WHERE `SunkenChart`.`sunk` != 1;
END;

INSERT INTO `SunkenChart` (
    `sunkenTreasureNumber`, `otherChartNumber`
) VALUES
    (24, 04), -- D3
    (02, 05), -- A2
    (44, 06), -- G2
    (42, 07), -- F7
    (43, 08), -- G1
    (18, 09)  -- C4
;

END;
