-- Zelda Wind Waker Checklist

PRAGMA foreign_keys = ON;

BEGIN;

DROP TABLE IF EXISTS `Island`;
DROP TABLE IF EXISTS `HeartContainer`;
DROP TABLE IF EXISTS `HeartPiece`;
DROP TABLE IF EXISTS `Item`;
DROP TABLE IF EXISTS `TreasureChart`;
DROP TABLE IF EXISTS `TriforceChart`;

DROP TABLE IF EXISTS `Location`;

--------------------
-- Map Coordinates
--------------------
-- Latitude
--------------------
DROP TABLE IF EXISTS `Latitude`;
CREATE TABLE IF NOT EXISTS `Latitude`(
    `value` CHAR(1) PRIMARY KEY NOT NULL
);
INSERT INTO `Latitude` ( `value` ) VALUES
    ('A'), ('B'), ('C'), ('D'), ('E'), ('F'), ('G');

-- Longitude
--------------------
DROP TABLE IF EXISTS `Longitude`;
CREATE TABLE IF NOT EXISTS `Longitude`(
    `value` UNSIGNED TINYINT(1) PRIMARY KEY NOT NULL
);
INSERT INTO `Longitude` ( `value` ) VALUES
    (1), (2), (3), (4), (5), (6), (7);

-- Location
--------------------
CREATE TABLE IF NOT EXISTS `Location`(
    `id` INTEGER PRIMARY KEY NOT NULL,
    `coordinate` CHAR(2) NOT NULL,
    `latitude` CHAR(1),
    `longitude` UNSIGNED TINYINT(1),
        FOREIGN KEY (`latitude`)  REFERENCES `Latitude`(`value`)
        FOREIGN KEY (`longitude`) REFERENCES `Longitude`(`value`)
);
CREATE UNIQUE INDEX `location_coordinate` ON
    `Location`(`coordinate`);
CREATE UNIQUE INDEX `location_latitude_longitude` ON
    `Location`(`latitude`, `longitude`);

INSERT INTO `Location` (
    `id`, `coordinate`, `latitude`, `longitude`
)
SELECT * FROM (SELECT
    ROW_NUMBER() OVER() AS "id",
    `Latitude`.`value`||`Longitude`.`value` AS "coordinate",
    `Latitude`.`value` AS "latitude",
    `Longitude`.`value` AS "longitude"
FROM `Latitude` CROSS JOIN `Longitude`
    ORDER BY `Latitude`.`value`, `Longitude`.`value`)
UNION ALL
SELECT
    0    AS "id",
    "~~" AS "coordinate",
    NULL AS "latitude",
    NULL AS "longitude"
;

-- Island
--------------------
CREATE TABLE IF NOT EXISTS `Island`(
    `name` VARCHAR(200) PRIMARY KEY NOT NULL,
    `location` CHAR(2) NOT NULL,
        FOREIGN KEY (`location`) REFERENCES `Location`(`coordinate`)
);
CREATE UNIQUE INDEX `island_location` ON
    `Island`(`location`);

INSERT INTO `Island` (
    `name`, `location`
) VALUES
    ("various",     (SELECT
                        `Location`.`coordinate`
                    FROM `Location`
                    WHERE `latitude`  IS NULL AND
                          `longitude` IS NULL)),

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

-- Heart Containers
--------------------
CREATE TABLE IF NOT EXISTS `HeartContainer`(
    `id` INTEGER PRIMARY KEY NOT NULL,
    `location` CHAR(2) NOT NULL,
    `details` VARCHAR(255),
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
    `latitude` CHAR(1),
    `longitude` UNSIGNED TINYINT(1),
    `task` VARCHAR(255),
        FOREIGN KEY (`latitude`)  REFERENCES `Latitude`(`value`)
        FOREIGN KEY (`longitude`) REFERENCES `Longitude`(`value`)
);
CREATE INDEX `heart_piece_coordinate` ON
    `HeartPiece`(`latitude` || `longitude`);

INSERT INTO `HeartPiece` (
    `latitude`, `longitude`, `task`
) VALUES
    ('A', 1, "Locked in a jail cell; Use button to open door"),
    ('A', 4, "Use Treasure Chart 38"),
    ('A', 5, "Use Seagull to hit switch to put out flames"),
    ('A', 6, "Use Treasure Chart 23"),
    ('B', 1, "Clear the Secret Cave"),
    ('B', 3, "950 Rupees at Beedle's Shop Ship"),
    ('B', 3, "Use Treasure Chart 2"),
    ('B', 3, "Defeat Cannon Boats and get from Light Ring"),
    ('B', 4, "Use Deku Leaf from spiral island to ledge"),
    ('B', 4, "Give Traveling Merchant a Shop Guru Statue"),
    ('B', 7, "Hit Orca 500 times"),
    ('B', 7, "Carry large pig to black dirt and use bait"),
    ('B', 7, "Clear the Secret Cave (all 50 floors)"),
    ('C', 2, "Win the Cannon Shoot mini-game (1st)"),
    ('C', 3, "Defeat the Big Octo (12 eyes)"),
    ('C', 5, "Destroy th Cannons on the Platform"),
    ('C', 7, "Use Seagull to fetch from top of mountain"),
    ('D', 2, "Win the hide-and-seek game with the kids"),
    ('D', 2, "Win the Zee Fleet mini-game (1st)"),
    ('D', 2, "Get the two people to start datig"),
    ('D', 2, "Win the Auction (3rd item)"),
    ('D', 2, "Decorate the town and talk to man on bench"),
    ('D', 2, "Light the lighthouse; Talk to operator"),
    ('D', 2, "Light the lighthouse; Chest on small island"),
    ('D', 2, "Give Moe's letter to Maggie"),
    ('D', 4, "Clear the Submarine"),
    ('D', 6, "Use Treasure Chart 4"),
    ('E', 1, "Use Treasure Chart 11"),
    ('E', 2, "Use Treasure Chart 30"),
    ('E', 2, "At the back of the Turtle Dome Secret Cave"),
    ('E', 7, "Use Treasure Chart 15"),
    ('E', 7, "On the top of the block-puzzle mountain"),
    ('F', 1, "Defeat the Big Octo (12 eyes)"),
    ('F', 2, "Letter after defeating Kalle Demos"),
    ('F', 2, "Letter after delivering part-timer's letter"),
    ('F', 2, "Letter after give 20 Golden Feathers to guard"),
    ('F', 5, "Clear the Secret Cave"),
    ('F', 5, "Use Treasure Chart 20"),
    ('F', 6, "Complete the Wilted Deku Tree side quest"),
    ('F', 6, "Use Treasure Chart 31"),
    ('G', 2, "Win the Bird-Man Contest mini-game"),
    ('G', 4, "Use Treasure Chart 5"),
    ('G', 7, "Clear the Submarine"),
    ('G', 7, "Use Treasure Chart 33")
;

-- Items
--------------------
CREATE TABLE IF NOT EXISTS `Item`(
    -- `id` INTEGER PRIMARY KEY NOT NULL,
    `name` VARCHAR(50) PRIMARY KEY NOT NULL,
    `latitude` CHAR(1),
    `longitude` UNSIGNED TINYINT(1),
    `details` VARCHAR(255),
    `required` BOOLEAN DEFAULT 1 NOT NULL,
        FOREIGN KEY (`latitude`)  REFERENCES `Latitude`(`value`)
        FOREIGN KEY (`longitude`) REFERENCES `Longitude`(`value`)
);
CREATE INDEX `item_coordinate` ON
    `Item`(`latitude` || `longitude`);

INSERT INTO `Item` (
    `latitude`, `longitude`, `required`, `name`, `details`
) VALUES
    ('B', 7, 1, "Telescope",              "Aryll"),
    ('B', 7, 1, "Hero's Sword",           "Orca"),
    ('B', 7, 1, "Hero's Sheild",          "Granny"),
    ('B', 7, 1, "Spoils Bag",             "Tetra's Pirate Ship - Niko's Rope Challenge"),
    ('A', 1, 1, "Pirate's Charm",         "Tetra"),
    ('D', 2, 1, "Sail",                   "Zunari (80 Rupees)"),
    ('D', 2, 0, "Tingle Tuner",           "Tingle"),
    ('D', 2, 0, "Picto Box",              "Tingle's cell maze"),
    ('F', 2, 1, "Wind Waker",             "The King of Red Lions"),
    ('F', 2, 1, "Delivery Bag",           "Quill"),
    ('F', 2, 1, "Bottle 1",               "Medli"),
    ('F', 2, 1, "Grappling Hook",         "Dragon Roost Cavern"),
    ('F', 2, 1, "Din's Pearl",            "Komali"),
    ('F', 5, 0, "Bottle 2",               "Submarine"),
    ('F', 6, 1, "Deku Leaf",              "Great Deku Tree"),
    ('F', 6, 1, "Boomerang",              "Forbidden Woods"),
    ('F', 6, 1, "Farore's Pearl",         "Great Deku Tree"),
    ('D', 2, 1, "Bombs",                  "Tetra's Pirate Ship - Niko's Rope Challenge"),
    ('B', 7, 1, "Nayru's Pearl",          "Jabun"),
    ('E', 4, 1, "Hero's Bow",             "Tower of the Gods"),
    ('E', 4, 1, "Master Sword",           "Hyrule Castle"),
    ('A', 1, 1, "Skull Hammer",           "Phantom Ganon"),
    ('B', 2, 1, "Fire & Ice Arrows",      "Fairy Queen"),
    ('F', 3, 1, "Power Bracelets",        "Secret Cave"),
    ('C', 7, 1, "Mirror Shield",          "Earth Temple"),
    ('C', 7, 1, "Master Sword Restore 1", "Earth Temple"),
    ('E', 6, 1, "Iron Boots",             "Secret Cave"),
    ('D', 1, 1, "Hookshot",               "Wind Temple"),
    ('D', 1, 1, "Master Sword Restore 2", "Wind Temple"),
    (NULL, NULL, 1, "Bait Bag",           "Beedle Shop Ship"),
    ('D', 2, 1, "Cabana Deed",            "Mrs. Marie (20 Joy Pendants)"),
    (NULL, NULL, 1, "Triforce of Courage", "Triforce Chart x8"),
    ('D', 2, 0, "Deluxe Picto Box",       "Lenzo"),
    ('D', 2, 0, "Hero's Charm",           "Mrs. Marie (40 Joy Pendants)"),
    ('B', 3, 0, "Bottle 3",               "Beedle Special Shop (500 Rupees)"),
    ('D', 2, 0, "Magic Armor",            "Zunari (Exotic Flower)"),
    ('D', 2, 0, "Bottle 4",               "Mila")
;

-- Treasure Charts
--------------------
CREATE TABLE IF NOT EXISTS `TreasureChart`(
    `number` INTEGER PRIMARY KEY NOT NULL,
    `latitude` CHAR(1),
    `longitude` UNSIGNED TINYINT(1),
    `details` VARCHAR(255),
        FOREIGN KEY (`latitude`)  REFERENCES `Latitude`(`value`)
        FOREIGN KEY (`longitude`) REFERENCES `Longitude`(`value`)
);
CREATE INDEX `treasure_chart_coordinate` ON
    `TreasureChart`(`latitude` || `longitude`);

INSERT INTO `TreasureChart` (
    `number`, `latitude`, `longitude`, `details`
) VALUES
    (01, 'F', 6, "In Forbidden Woods"),
    (02, 'D', 2, "Give Maggie's Father 20 Skull Necklaces"),
    (03, 'F', 6, "Small island outside Forest Haven, Deku Leaf"),
    (04, 'B', 3, "Beedle Special Shop (900 Rupees)"),
    (05, 'D', 1, "In Wind Temple"),
    (06, 'E', 4, "In Tower of the Gods"),
    (07, 'D', 2, "Win the Zee Fleet mini-game (2nd)"),
    (08, 'A', 7, "Clear the Secret Cave"),
    (09, 'E', 1, "Clear the Submarine"),
    (10, 'E', 1, "Sitting on the island"),
    (11, 'F', 2, "In Dragon Roost Cavern"),
    (12, 'C', 7, "In Earth Temple"),
    (13, 'D', 7, "Clear the artillery from the reef"),
    (14, 'C', 7, "Clear the Submarine"),
    (15, 'F', 6, "In Forbidden Woods"),
    (16, 'F', 1, "Clear the Platforms"),
    (17, 'C', 2, "Win the Cannon Shoot mini-game (2nd)"),
    (18, 'D', 2, "Win the Auction (2nd)"),
    (19, 'A', 2, "Clear all artillery from the reef"),
    (20, 'C', 7, "In Earth Temple"),
    (21, 'C', 4, "Clear all artillery from the reef"),
    (22, 'C', 1, "Clear the Submarine"),
    (23, 'D', 2, "Win the Zee Fleet mini-game (3rd)"),
    (24, 'D', 2, "Show Lenzo & friend picto to gossip ladies"),
    (25, 'G', 6, "Use Secret Cave to reach it on high cliff"),
    (26, 'D', 4, "Clear all artillery from the reef"),
    (27, 'E', 5, "On top of the cliff"),
    (28, 'A', 7, "Finish the ""Golf"" game with the Boko Nuts"),
    (29, 'D', 2, "Secret room in Lenzo's house"),
    (30, 'E', 4, "In Tower of the Gods"),
    (31, 'D', 2, "Show full moon picto to man on steps"),
    (32, 'A', 4, "Clear all artillery from the reef"),
    (33, 'D', 2, "Show picto of old beauty queen to herself"),
    (34, 'F', 4, "Given by Salvage Corp."),
    (35, 'D', 1, "In Wind Temple"),
    (36, 'E', 6, "Use Fire Arrows on iced chest"),
    (37, 'B', 3, "Clear the Secret Cave"),
    (38, 'D', 2, "Win the Auction (1st)"),
    (39, 'F', 2, "In Dragon Roost Cavern"),
    (40, 'D', 6, "Clear the Platforms"),
    (41, 'B', 6, "Clear the artillery from the reef")
;

-- Triforce Charts
--------------------
CREATE TABLE IF NOT EXISTS `TriforceChart`(
    `number` INTEGER PRIMARY KEY NOT NULL,
    `latitude` CHAR(1),
    `longitude` UNSIGNED TINYINT(1),
    `details` VARCHAR(255),
        FOREIGN KEY (`latitude`)  REFERENCES `Latitude`(`value`)
        FOREIGN KEY (`longitude`) REFERENCES `Longitude`(`value`)
);
CREATE INDEX `triforce_chart_coordinate` ON
    `TriforceChart`(`latitude` || `longitude`);

INSERT INTO `TriforceChart` (
    `number`, `latitude`, `longitude`, `details`
) VALUES
    (01, 'B', 5, "Inside the ""Secret Cave"""),
    (02, 'E', 5, "Clear the Secret Cave (fireplace"),
    (03, 'G', 5, "Use Seagull to hit 5 switchs; In Secret Cave"),
    (04, NULL, NULL, "Clear the Ghost Ship (G7,G3,B4,E1,A6,F5,C2)"),
    (05, 'A', 5, "Defeat Golden Cannon Boat; light ring"),
    (06, 'B', 7, "Clear the Secret Cave (level 30)"),
    (07, 'C', 5, "Clear the Secret Cave"),
    (08, 'G', 1, "Clear the Secret Cave")
;

END;
