-- Zelda Wind Waker Checklist

PRAGMA foreign_keys = ON;

BEGIN;

DROP TABLE IF EXISTS `Island`;
DROP TABLE IF EXISTS `HeartContainer`;
DROP TABLE IF EXISTS `HeartPiece`;
DROP TABLE IF EXISTS `Item`;
DROP TABLE IF EXISTS `Chart`;
DROP TABLE IF EXISTS `ChartType`;

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
    `latitude` CHAR(1) NOT NULL,
    `longitude` UNSIGNED TINYINT(1) NOT NULL,
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
SELECT
    ROW_NUMBER() OVER() AS "id",
    `Latitude`.`value`||`Longitude`.`value` AS "coordinate",
    `Latitude`.`value` AS "latitude",
    `Longitude`.`value` AS "longitude"
FROM `Latitude` CROSS JOIN `Longitude`
    ORDER BY `Latitude`.`value`, `Longitude`.`value`
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
    `details` VARCHAR(255) NOT NULL,
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
    `task` VARCHAR(255) NOT NULL,
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
    `name` VARCHAR(50) PRIMARY KEY NOT NULL,
    `location` CHAR(2),
    `details` VARCHAR(255) NOT NULL,
    `required` BOOLEAN DEFAULT 1 NOT NULL,
        FOREIGN KEY (`location`) REFERENCES `Location`(`coordinate`)
);
CREATE INDEX `item_location` ON
    `Item`(`location`);

INSERT INTO `Item` (
    `location`, `required`, `name`, `details`
) VALUES
    ('B7', 1, "Telescope",              "Aryll"),
    ('B7', 1, "Hero's Sword",           "Orca"),
    ('B7', 1, "Hero's Sheild",          "Granny"),
    ('B7', 1, "Spoils Bag",             "Tetra's Pirate Ship - Niko's Rope Challenge"),
    ('A1', 1, "Pirate's Charm",         "Tetra"),
    ('D2', 1, "Sail",                   "Zunari (80 Rupees)"),
    ('D2', 0, "Tingle Tuner",           "Tingle"),
    ('D2', 0, "Picto Box",              "Tingle's cell maze"),
    ('F2', 1, "Wind Waker",             "The King of Red Lions"),
    ('F2', 1, "Delivery Bag",           "Quill"),
    ('F2', 1, "Bottle 1",               "Medli"),
    ('F2', 1, "Grappling Hook",         "Dragon Roost Cavern"),
    ('F2', 1, "Din's Pearl",            "Komali"),
    ('F5', 0, "Bottle 2",               "Submarine"),
    ('F6', 1, "Deku Leaf",              "Great Deku Tree"),
    ('F6', 1, "Boomerang",              "Forbidden Woods"),
    ('F6', 1, "Farore's Pearl",         "Great Deku Tree"),
    ('D2', 1, "Bombs",                  "Tetra's Pirate Ship - Niko's Rope Challenge"),
    ('B7', 1, "Nayru's Pearl",          "Jabun"),
    ('E4', 1, "Hero's Bow",             "Tower of the Gods"),
    ('E4', 1, "Master Sword",           "Hyrule Castle"),
    ('A1', 1, "Skull Hammer",           "Phantom Ganon"),
    ('B2', 1, "Fire & Ice Arrows",      "Fairy Queen"),
    ('F3', 1, "Power Bracelets",        "Secret Cave"),
    ('C7', 1, "Mirror Shield",          "Earth Temple"),
    ('C7', 1, "Master Sword Restore 1", "Earth Temple"),
    ('E6', 1, "Iron Boots",             "Secret Cave"),
    ('D1', 1, "Hookshot",               "Wind Temple"),
    ('D1', 1, "Master Sword Restore 2", "Wind Temple"),
    (NULL, 1, "Bait Bag",               "Beedle Shop Ship"),
    ('D2', 1, "Cabana Deed",            "Mrs. Marie (20 Joy Pendants)"),
    (NULL, 1, "Triforce of Courage",    "Triforce Chart x8"),
    ('D2', 0, "Deluxe Picto Box",       "Lenzo"),
    ('D2', 0, "Hero's Charm",           "Mrs. Marie (40 Joy Pendants)"),
    ('B3', 0, "Bottle 3",               "Beedle Special Shop (500 Rupees)"),
    ('D2', 0, "Magic Armor",            "Zunari (Exotic Flower)"),
    ('D2', 0, "Bottle 4",               "Mila")
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
    `location` CHAR(1),
    `type` VARCHAR(7) NOT NULL,
    `details` VARCHAR(255) NOT NULL,
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

END;
