-- Zelda Wind Waker Checklist

PRAGMA foreign_keys = ON;

BEGIN;

DROP VIEW IF EXISTS `SunkenThing`;

DROP TABLE IF EXISTS `Island`;
DROP TABLE IF EXISTS `Item`;
DROP TABLE IF EXISTS `SunkenTriforceShard`;
DROP TABLE IF EXISTS `SunkenChart`;
DROP TABLE IF EXISTS `SunkenHeartPiece`;
DROP TABLE IF EXISTS `SunkenRupee`;
DROP TABLE IF EXISTS `HeartContainer`;
DROP TABLE IF EXISTS `HeartPiece`;
DROP TABLE IF EXISTS `OtherChart`;
DROP TABLE IF EXISTS `TreasureChart`;
DROP TABLE IF EXISTS `TriforceChart`;
DROP TABLE IF EXISTS `TriforceShard`;

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
    `value` TINYINT(1) PRIMARY KEY NOT NULL
);
INSERT INTO `Latitude` ( `value` ) VALUES
    (1), (2), (3), (4), (5), (6), (7);

-- Location
--------------------
CREATE TABLE IF NOT EXISTS `Location`(
    `id` INTEGER PRIMARY KEY NOT NULL,
    `coordinate` CHAR(2) NOT NULL,
    `longitude` TINYINT(1) NOT NULL,
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

--------------------------------------------------------------------
-- Features
--------------------
-- Heart Containers
--------------------
CREATE TABLE IF NOT EXISTS `HeartContainer`(
    `id` INTEGER PRIMARY KEY NOT NULL,
    `details` VARCHAR(100) NOT NULL
);

INSERT INTO `HeartContainer` (
    `id`, `details`
) VALUES
    (01, "Dragon Roost Cavern"),
    (02, "Forbidden Woods"),
    (03, "Tower of the Gods"),
    (04, "2nd visit"),
    (05, "Earth Temple"),
    (06, "Wind Temple")
;

-- Heart Pieces
--------------------
CREATE TABLE IF NOT EXISTS `HeartPiece`(
    `id` INTEGER PRIMARY KEY NOT NULL,
    `task` VARCHAR(100) NOT NULL
);

INSERT INTO `HeartPiece` (
    `id`, `task`
) VALUES
    (01, "Locked in a jail cell; Use button to open door"),
    (02, "Use Treasure Chart 38"),
    (03, "Use Seagull to hit switch to put out flames"),
    (04, "Use Treasure Chart 23"),
    (05, "Clear the Secret Cave"),
    (06, "950 Rupees at Beedle's Shop Ship"),
    (07, "Use Treasure Chart 2"),
    (08, "Defeat Cannon Boats and get from Light Ring"),
    (09, "Use Deku Leaf from spiral island to ledge"),
    (10, "Give Traveling Merchant a Shop Guru Statue"),
    (11, "Hit Orca 500 times"),
    (12, "Carry large pig to black dirt and use bait"),
    (13, "Clear the Secret Cave (all 50 floors)"),
    (14, "Win the Cannon Shoot mini-game (1st)"),
    (15, "Defeat the Big Octo (12 eyes)"),
    (16, "Destroy th Cannons on the Platform"),
    (17, "Use Seagull to fetch from top of mountain"),
    (18, "Win the hide-and-seek game with the kids"),
    (19, "Win the Zee Fleet mini-game (1st)"),
    (20, "Get the two people to start datig"),
    (21, "Win the Auction (3rd item)"),
    (22, "Decorate the town and talk to man on bench"),
    (23, "Light the lighthouse; Talk to operator"),
    (24, "Light the lighthouse; Chest on small island"),
    (25, "Give Moe's letter to Maggie"),
    (26, "Clear the Submarine"),
    (27, "Use Treasure Chart 4"),
    (28, "Use Treasure Chart 11"),
    (29, "Use Treasure Chart 30"),
    (30, "At the back of the Turtle Dome Secret Cave"),
    (31, "Use Treasure Chart 15"),
    (32, "On the top of the block-puzzle mountain"),
    (33, "Defeat the Big Octo (12 eyes)"),
    (34, "Letter after defeating Kalle Demos"),
    (35, "Letter after delivering part-timer's letter"),
    (36, "Letter after give 20 Golden Feathers to guard"),
    (37, "Clear the Secret Cave"),
    (38, "Use Treasure Chart 20"),
    (39, "Complete the Wilted Deku Tree side quest"),
    (40, "Use Treasure Chart 31"),
    (41, "Win the Bird-Man Contest mini-game"),
    (42, "Use Treasure Chart 5"),
    (43, "Clear the Submarine"),
    (44, "Use Treasure Chart 33")
;

-- Items
--------------------
CREATE TABLE IF NOT EXISTS `Item`(
    `id` INTEGER PRIMARY KEY NOT NULL,
    `name` VARCHAR(25) NOT NULL,
    `details` VARCHAR(45) NOT NULL,
    `required` BOOLEAN NOT NULL DEFAULT 1
);
CREATE UNIQUE INDEX `item_name` ON
    `Item`(`name`);

INSERT INTO `Item` (
    `id`, `required`, `name`, `details`
) VALUES
    (01, 1, "Telescope",              "Aryll"),
    (02, 1, "Hero's Sword",           "Orca"),
    (03, 1, "Hero's Sheild",          "Granny"),
    (04, 1, "Spoils Bag",             "Tetra's Pirate Ship - Niko's Rope Challenge"),
    (05, 1, "Pirate's Charm",         "Tetra"),
    (06, 1, "Sail",                   "Zunari (80 Rupees)"),
    (07, 0, "Tingle Tuner",           "Tingle"),
    (08, 0, "Picto Box",              "Tingle's cell maze"),
    (09, 1, "Wind Waker",             "The King of Red Lions"),
    (10, 1, "Delivery Bag",           "Quill"),
    (11, 1, "Bottle 1",               "Medli"),
    (12, 1, "Grappling Hook",         "Dragon Roost Cavern"),
    (13, 1, "Din's Pearl",            "Komali"),
    (14, 0, "Bottle 2",               "Submarine"),
    (15, 1, "Deku Leaf",              "Great Deku Tree"),
    (16, 1, "Boomerang",              "Forbidden Woods"),
    (17, 1, "Farore's Pearl",         "Great Deku Tree"),
    (18, 1, "Bombs",                  "Tetra's Pirate Ship - Niko's Rope Challenge"),
    (19, 1, "Nayru's Pearl",          "Jabun"),
    (20, 1, "Hero's Bow",             "Tower of the Gods"),
    (21, 1, "Master Sword",           "Hyrule Castle"),
    (22, 1, "Skull Hammer",           "Phantom Ganon"),
    (23, 1, "Fire & Ice Arrows",      "Fairy Queen"),
    (24, 1, "Power Bracelets",        "Secret Cave"),
    (25, 1, "Mirror Shield",          "Earth Temple"),
    (26, 1, "Master Sword Restore 1", "Earth Temple"),
    (27, 1, "Iron Boots",             "Secret Cave"),
    (28, 1, "Hookshot",               "Wind Temple"),
    (29, 1, "Master Sword Restore 2", "Wind Temple"),
    (30, 1, "Bait Bag",               "Beedle Shop Ship"),
    (31, 1, "Cabana Deed",            "Mrs. Marie (20 Joy Pendants)"),
    (32, 1, "Triforce of Courage",    "Triforce Chart x8"),
    (33, 0, "Deluxe Picto Box",       "Lenzo"),
    (34, 0, "Hero's Charm",           "Mrs. Marie (40 Joy Pendants)"),
    (35, 0, "Bottle 3",               "Beedle Special Shop (500 Rupees)"),
    (36, 0, "Magic Armor",            "Zunari (Exotic Flower)"),
    (37, 0, "Bottle 4",               "Mila")
;

-- Rupees
--------------------
CREATE TABLE IF NOT EXISTS `Rupee`(
    `id` INTEGER PRIMARY KEY NOT NULL,
    `value` UNSIGNED INTEGER NOT NULL,
    `color` VARCHAR(12) NOT NULL,
);
CREATE UNIQUE INDEX `rupee_value` ON
    `Rupee`(`value`);
CREATE UNIQUE INDEX `rupee_color` ON
    `Rupee`(`color`);

INSERT INTO `Rupee` (
    `id`, `value`, `color`
) VALUES
    (001, 001, 'green'),
    (005, 005, 'blue'),
    (010, 010, 'yellow'),
    (020, 020, 'red'),
    (050, 050, 'purple'),
    (100, 100, 'orange'),
    (200, 200, 'silver')
;

-- Spoils
--------------------
CREATE TABLE IF NOT EXISTS `Spoil`(
    `id` INTEGER PRIMARY KEY NOT NULL,
    `name` VARCHAR(20) NOT NULL
);
CREATE INDEX `spoil_name` ON
    `Spoil`(`name`);

INSERT INTO `Spoil` (
    `id`, `name`
) VALUES
    (01, "Red Chu Jelly"),
    (02, "Green Chu Jelly"),
    (03, "Blue Chu Jelly"),
    (04, "Boko Baba Seed"),
    (05, "Joy Pendant"),
    (06, "Knight's Crest"),
    (07, "Golden Feather"),
    (08, "Skull Necklace")
;

-- Treasure Charts
--------------------
CREATE TABLE IF NOT EXISTS `TreasureChart`(
    `number` INTEGER PRIMARY KEY NOT NULL,
    `chartNumber` UNSIGNED INTEGER NOT NULL,
    `details` VARCHAR(50) NOT NULL
);
CREATE UNIQUE INDEX `treasure_chart_number` ON
    `TreasureChart`(`chartNumber`);

INSERT INTO `TreasureChart` (
    `number`, `chartNumber`, `details`
) VALUES
    (01, 01, "In Forbidden Woods"),
    (02, 02, "Give Maggie's Father 20 Skull Necklaces"),
    (03, 03, "Small island outside Forest Haven, Deku Leaf"),
    (04, 04, "Beedle Special Shop (900 Rupees)"),
    (05, 05, "In Wind Temple"),
    (06, 06, "In Tower of the Gods"),
    (07, 07, "Win the Zee Fleet mini-game (2nd)"),
    (08, 08, "Clear the Secret Cave"),
    (09, 09, "Clear the Submarine"),
    (10, 10, "Sitting on the island"),
    (11, 11, "In Dragon Roost Cavern"),
    (12, 12, "In Earth Temple"),
    (13, 13, "Clear the artillery from the reef"),
    (14, 14, "Clear the Submarine"),
    (15, 15, "In Forbidden Woods"),
    (16, 16, "Clear the Platforms"),
    (17, 17, "Win the Cannon Shoot mini-game (2nd)"),
    (18, 18, "Win the Auction (2nd)"),
    (19, 19, "Clear all artillery from the reef"),
    (20, 20, "In Earth Temple"),
    (21, 21, "Clear all artillery from the reef"),
    (22, 22, "Clear the Submarine"),
    (23, 23, "Win the Zee Fleet mini-game (3rd)"),
    (24, 24, "Show Lenzo & friend picto to gossip ladies"),
    (25, 25, "Use Secret Cave to reach it on high cliff"),
    (26, 26, "Clear all artillery from the reef"),
    (27, 27, "On top of the cliff"),
    (28, 28, "Finish the ""Golf"" game with the Boko Nuts"),
    (29, 29, "Secret room in Lenzo's house"),
    (30, 30, "In Tower of the Gods"),
    (31, 31, "Show full moon picto to man on steps"),
    (32, 32, "Clear all artillery from the reef"),
    (33, 33, "Show picto of old beauty queen to herself"),
    (34, 34, "Given by Salvage Corp."),
    (35, 35, "In Wind Temple"),
    (36, 36, "Use Fire Arrows on iced chest"),
    (37, 37, "Clear the Secret Cave"),
    (38, 38, "Win the Auction (1st)"),
    (39, 39, "In Dragon Roost Cavern"),
    (40, 40, "Clear the Platforms"),
    (41, 41, "Clear the artillery from the reef")
;

-- Triforce Charts
--------------------
CREATE TABLE IF NOT EXISTS `TriforceShardChart`(
    `id` INTEGER PRIMARY KEY NOT NULL,
    `chartNumber` UNSIGNED INTEGER NOT NULL,
    `details` VARCHAR(50) NOT NULL
);
CREATE UNIQUE INDEX `triforce_chart_number` ON
    `TriforceChart`(`chartNumber`);

INSERT INTO `TriforceChart` (
    `number`, `chartNumber`, `details`
) VALUES
    (01, 01, "Inside the ""Secret Cave"""),
    (02, 02, "Clear the Secret Cave (fireplace"),
    (03, 03, "Use Seagull to hit 5 switchs; In Secret Cave"),
    (04, 04, "Clear the Ghost Ship (G7,G3,B4,E1,A6,F5,C2)"),
    (05, 05, "Defeat Golden Cannon Boat; light ring"),
    (06, 06, "Clear the Secret Cave (level 30)"),
    (07, 07, "Clear the Secret Cave"),
    (08, 08, "Clear the Secret Cave")
;

-- Triforce Shards
--------------------
CREATE TABLE IF NOT EXISTS `TriforceShard`(
    `id` INTEGER PRIMARY KEY NOT NULL
);

INSERT INTO `TriforceShard` (
    `id`
) VALUES
    (01), -- B4
    (02), -- B7
    (03), -- C5
    (04), -- D1
    (05), -- D5
    (06), -- D7
    (07), -- F1
    (08)  -- G6
;

-- Other Charts
--------------------
CREATE TABLE IF NOT EXISTS `OtherChart`(
    `id` INTEGER PRIMARY KEY NOT NULL,
    `name` VARCHAR(17) NOT NULL,
    `details` VARCHAR(50) NOT NULL
);
CREATE UNIQUE INDEX `other_chart_name` ON
    `OtherChart`(`name`);

INSERT INTO `OtherChart` (
    `id`, `name`, `details`
) VALUES
    (01, "Ghost Ship Chart",    "Clear the Secret Cave"), -- A6
    (02, "Tingle's Chart",      "Free Tingle from jail"), -- D2
    (03, "IN-credible Chart",   "Letter, after Zelda"),
    (04, "Octo Chart",          "Use Treasure Chart 26"), -- D3
    (05, "Great Fairy Chart",   "Use Treasure Chart 41"), -- A2
    (06, "Island Hearts Chart", "Use Treasure Chart 19"), -- G2
    (07, "Sea Hearts Chart",    "Use Treasure Chart 32"), -- F7
    (08, "Secret Cave Chart",   "Use Treasure Chart 13"), -- G1
    (09, "Light Ring Chart",    "Use Treasure Chart 21"), -- C4
    (10, "Platform Chart",      "Clear the Submarine"),   -- G2
    (11, "Beedle's Chart",      "Letter, after Bombs"),
    (12, "Submarine Chart",     "Clear the Secret Cave")  -- F7
;

-- Wind Waker Songs
--------------------
CREATE TABLE IF NOT EXISTS `WindWakerSong`(
    `id` INTEGER PRIMARY KEY NOT NULL,
    `name` VARCHAR(20) NOT NULL
);
CREATE UNIQUE INDEX `wind_waker_song_name` ON
    `WindWakerSong`(`name`);

INSERT INTO `WindWakerSong` (
    `id`, `name`
) VALUES
    (01, "Wind's Requiem"),    -- F2 Dragon Roost Island                    Wind Shrine
    (02, "Song of Passing"),   -- D2 Windfall Island                        Tott
    (03, "Command Melody"),    -- E4 Tower of the Gods                      monument
    (04, "Ballad of Gales"),   -- ~~ Great Sea (B2/D2/F2/C3/B4/E4/D6/F6/B7) Cyclos
    (05, "Earth's God Lyric"), -- C7 Headstone Island                       monument
    (06, "Wind's God Aria")    -- D1 Gale Isle                              monumen
;

-- Great Fairies
--------------------
CREATE TABLE IF NOT EXISTS `GreatFairy`(
    `id` INTEGER PRIMARY KEY NOT NULL
);

INSERT INTO `GreatFairy` (
    `id`
) VALUES
    (01), -- C1
    (02), -- B7
    (03), -- D7
    (04), -- D6
    (05), -- E3
    (06), -- B2
    (07), -- A3
    (08)  -- G4
;

-- Great Fairy Upgrades
--------------------
CREATE TABLE IF NOT EXISTS `GreatFairyUpgrade`(
    `id` INTEGER PRIMARY KEY NOT NULL,
    `name` INTEGER NOT NULL,
    `greatFairyId` INTEGER NOT NULL,
        FOREIGN KEY (`greatFairyId`) REFERENCES
            `GreatFairy`(`id`)
);

INSERT INTO `GreatFairyUpgrade` (
    `id`, `greatFairyId`, `name`
) VALUES
    (01, 01, 'Wallet'),
    (02, 02, 'Wallet'),
    (03, 03, 'Magic Meter'),
    (04, 04, 'Bomb'),
    (05, 05, 'Bomb'),
    (06, 06, 'Fire & Ice Arrows'),
    (07, 07, 'Arrow'),
    (08, 08, 'Arrow')
;

-- Great Fairy Access Requirement Item
--------------------
CREATE TABLE IF NOT EXISTS `GreatFairyAccessRequirementItem`(
    `id` INTEGER PRIMARY KEY NOT NULL,
    `greatFairyId` INTEGER NOT NULL,
    `itemId` INTEGER NOT NULL,
        FOREIGN KEY (`greatFairyId`) REFERENCES
            `GreatFairy`(`id`),
        FOREIGN KEY (`itemId`) REFERENCES
            `Item`(`id`)
);

INSERT INTO `GreatFairyAccessRequirementItem` (
    `id`, `greatFairyId`, `itemId`
) VALUES
    (01, 02, 15), -- (Deku Leaf) & Bombs
    (02, 02, 18), -- Deku Leaf & (Bombs)
    (03, 03, 16), -- Boomerang
    (04, 04, 18), -- Bombs
    (05, 05, 18), -- Bombs
    (06, 07, 22), -- Skull Hammer
    (07, 08, 22)  -- Skull Hammer
;

-- Great Fairy Access Requirement Item
--------------------
CREATE TABLE IF NOT EXISTS `GreatFairyAccessRequirementWindWakerSong`(
    `id` INTEGER PRIMARY KEY NOT NULL,
    `greatFairyId` INTEGER NOT NULL,
    `windWakerSongId` INTEGER NOT NULL,
        FOREIGN KEY (`greatFairyId`) REFERENCES
            `GreatFairy`(`id`),
        FOREIGN KEY (`windWakerSongId`) REFERENCES
            `WindWakerSong`(`id`)
);

INSERT INTO `GreatFairyAccessRequirementWindWakerSong` (
    `id`, `greatFairyId`, `windWakerSongId`
) VALUES
    (01, 06, 04), -- Ballad of Gales
;


------------------------------------------------------------------------

-- Sunken Chest
--------------------
CREATE TABLE IF NOT EXISTS `SunkenChest`(
    `id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    `expectedLocation` CHAR(2) NOT NULL,
        FOREIGN KEY (`expectedLocation`) REFERENCES
            `Location`(`coordinate`)
);

INSERT INTO `SunkenChest` (
    `id`, `expectedLocation`
) VALUES
    (01, 'A1'),
    (02, 'A2'),
    (03, 'A3'),
    (04, 'A4'),
    (05, 'A5'),
    (06, 'A6'),
    (07, 'A7'),
    (08, 'B1'),
    (09, 'B2'),
    (10, 'B3'),
    (11, 'B4'),
    (12, 'B5'),
    (13, 'B6'),
    (14, 'B7'),
    (15, 'C1'),
    (16, 'C2'),
    (17, 'C3'),
    (18, 'C4'),
    (19, 'C5'),
    (20, 'C6'),
    (21, 'C7'),
    (22, 'D1'),
    (23, 'D2'),
    (24, 'D3'),
    (25, 'D4'),
    (26, 'D5'),
    (27, 'D6'),
    (28, 'D7'),
    (29, 'E1'),
    (30, 'E2'),
    (31, 'E3'),
    (32, 'E4'),
    (33, 'E5'),
    (34, 'E6'),
    (35, 'E7'),
    (36, 'F1'),
    (37, 'F2'),
    (38, 'F3'),
    (39, 'F4'),
    (40, 'F5'),
    (41, 'F6'),
    (42, 'F7'),
    (43, 'G1'),
    (44, 'G2'),
    (45, 'G3'),
    (46, 'G4'),
    (47, 'G5'),
    (48, 'G6'),
    (49, 'G7')
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
    `sunkenChestId` INTEGER NOT NULL,
    `otherChartId` INTEGER NOT NULL,
        FOREIGN KEY (`treasureChartNumber`) REFERENCES
            `TreasureChart`(`number`),
        FOREIGN KEY (`sunkenChestId`) REFERENCES
            `SunkenChest`(`id`),
        FOREIGN KEY (`otherChartId`) REFERENCES
            `OtherChart`(`id`)
);
CREATE UNIQUE INDEX `sunken_chart_tcNum` ON
    `SunkenChart`(`treasureChartNumber`);
CREATE INDEX `sunken_chart_scNum` ON
    `SunkenChart`(`sunkenChestId`);
CREATE UNIQUE INDEX `sunken_chart_ocNum` ON
    `SunkenChart`(`otherChartId`);

INSERT INTO `SunkenChart` (
    `treasureChartNumber`, `sunkenChestId`, `otherChartId`
) VALUES
    (41, 02, 05), -- A2 Four-Eye Reef            Great Fairy Chart
    (21, 18, 09), -- C4 Cyclops Reef             Light Ring Chart
    (26, 24, 04), -- D3 Northern Triangle Island Octo Chart
    (32, 42, 07), -- F7 Boating Course           Sea Hearts Chart
    (13, 43, 08), -- G1 Overlook Island          Secret Cave Chart
    (19, 44, 06)  -- G2 Flight Control Platform  Island Hearts Chart
;

-- Sunken Treasure → Rupees
--------------------
CREATE TABLE IF NOT EXISTS `SunkenRupee`(
    `id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    `treasureChartNumber` INTEGER NOT NULL,
    `location` CHAR(2) NOT NULL,
    `rupeeValue` INTEGER NOT NULL,
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
    `treasureChartNumber`, `location`, `rupeeValue`
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

-- This view only actually works without needing to join to a
--  SunkenThings table because there is only ever 1 thing in a chest.
--  If that changes, this schema breaks, and we would need to ID each
--  SunkenChest.
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
    `SunkenRupee`.`rupeeValue`||(
        CASE WHEN `SunkenRupee`.`rupeeValue` <= 1 THEN
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

-- Secret Caves
--------------------
CREATE TABLE IF NOT EXISTS `SecretCave`(
    `id` INTEGER PRIMARY KEY NOT NULL,
    `location` CHAR(2) NOT NULL,
    `treasures` VARCHAR(50) NOT NULL,
        FOREIGN KEY (`location`) REFERENCES `Location`(`coordinate`)
);
CREATE INDEX `secret_cave_location` ON
    `SecretCave`(`location`);

INSERT INTO `SecretCave` (
    `id`, `location`, `treasures`
) VALUES
    (01, 'A5', '100 Rupees'),
    (02, 'A6', 'Joy Pendant, Ghost Ship Chart'),
    (03, 'A7', 'Treasure Chart 8'),
    (04, 'B1', 'Heart Piece'),
    (05, 'B3', 'Treasure Chart 37'),
    (06, 'B5', 'Triforce Chart 1'),
    (07, 'B7', 'Triforce Chart 6, Heart Piece'),
    (08, 'C5', 'Triforce Chart 7'),
    (09, 'C6', '200 Rupees'),
    (10, 'E2', 'Heart Piece, Joy Pendant, 50 Rupees'),
    (11, 'E2', '200 Rupees'),
    (12, 'E5', 'Triforce Chart 2'),
    (13, 'E6', 'Iron Boots, 100 Rupees'),
    (14, 'E7', '200 Rupees'),
    (15, 'F2', '50 Rupees'),
    (16, 'F3', 'Power Bracelets'),
    (17, 'F5', 'Heart Piece'),
    (18, 'F7', 'Submarine Chart'),
    (19, 'G1', 'Triforce Chart 8'),
    (20, 'G5', 'Triforce Chart 3'),
    (21, 'G6', 'Joy Pendant')
;

-- Secret Cave → Heart Pieces
--------------------
CREATE TABLE IF NOT EXISTS `SecretCaveHeartPiece`(
    `id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    `secretCaveId` INTEGER NOT NULL,
    `heartPieceId` INTEGER NOT NULL,
        FOREIGN KEY (`secretCaveId`) REFERENCES
            `SecretCave`(`id`),
        FOREIGN KEY (`heartPieceId`) REFERENCES
            `HeartPiece`(`id`)
);
CREATE INDEX `secret_cave_heart_piece_scId` ON
    `SecretCaveHeartPiece`(`secretCaveId`);
CREATE INDEX `secret_cave_hert_piece_hpId` ON
    `SecretCaveHeartPiece`(`heartPieceId`);

INSERT INTO `SecretCaveHeartPiece` (
    `secretCaveId`, `heartPieceId`
) VALUES
    (04, 05), -- B1
    (07, 13), -- B7
    (10, 30), -- E2
    (17, 37)  -- F5
;

-- Secret Cave → Items
--------------------
CREATE TABLE IF NOT EXISTS `SecretCaveItem`(
    `id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    `secretCaveId` INTEGER NOT NULL,
    `itemId` INTEGER NOT NULL,
        FOREIGN KEY (`secretCaveId`) REFERENCES
            `SecretCave`(`id`),
        FOREIGN KEY (`itemId`) REFERENCES
            `Item`(`id`)
);
CREATE INDEX `secret_cave_item_scId` ON
    `SecretCaveItem`(`secretCaveId`);
CREATE INDEX `secret_cave_item_itId` ON
    `SecretCaveItem`(`itemId`);

INSERT INTO `SecretCaveItem` (
    `secretCaveId`, `itemId`
) VALUES
    (13, 27), -- E6
    (16, 24)  -- F3
;

-- Secret Cave → Rupees
--------------------
CREATE TABLE IF NOT EXISTS `SecretCaveRupee`(
    `id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    `secretCaveId` INTEGER NOT NULL,
    `rupeeValue` INTEGER NOT NULL,
        FOREIGN KEY (`secretCaveId`) REFERENCES
            `SecretCave`(`id`)
);
CREATE INDEX `secret_cave_rupee_scId` ON
    `SecretCaveRupee`(`secretCaveId`);
CREATE INDEX `secret_cave_rupee_value` ON
    `SecretCaveRupee`(`rupeeValue`);

INSERT INTO `SecretCaveRupee` (
    `secretCaveId`, `rupeeValue`
) VALUES
    (01, 100), -- A5
    (09, 200), -- C6
    (10, 050), -- E2
    (11, 200), -- E2
    (13, 100), -- E6
    (14, 200), -- E7
    (15, 050)  -- F2
;

-- Secret Cave → Spoils
--------------------
CREATE TABLE IF NOT EXISTS `SecretCaveSpoil`(
    `id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    `secretCaveId` INTEGER NOT NULL,
    `spoilId` INTEGER NOT NULL,
        FOREIGN KEY (`secretCaveId`) REFERENCES
            `SecretCave`(`id`)
);
CREATE INDEX `secret_cave_spoil_scId` ON
    `SecretCaveSpoil`(`secretCaveId`);
CREATE INDEX `secret_cave_spoil_sId` ON
    `SecretCaveSpoil`(`spoilId`);

INSERT INTO `SecretCaveSpoil` (
    `secretCaveId`, `spoilId`
) VALUES
    (02, 05), -- A6
    (10, 05), -- E2
    (21, 05)  -- G6
;

-- Secret Cave → Treasure Charts
--------------------
CREATE TABLE IF NOT EXISTS `SecretCaveTreasureChart`(
    `id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    `secretCaveId` INTEGER NOT NULL,
    `treasureChartNumber` INTEGER NOT NULL,
        FOREIGN KEY (`secretCaveId`) REFERENCES
            `SecretCave`(`id`),
        FOREIGN KEY (`treasureChartNumber`) REFERENCES
            `TreasureChart`(`number`)
);
CREATE INDEX `secret_cave_treasure_chart_scId` ON
    `SecretCaveTreasureChart`(`secretCaveId`);
CREATE INDEX `secret_cave_treasure_chart_tcNum` ON
    `SecretCaveTreasureChart`(`treasureChartNumber`);

INSERT INTO `SecretCaveTreasureChart` (
    `secretCaveId`, `treasureChartNumber`
) VALUES
    (03, 08), -- A7
    (05, 37)  -- B3
;

-- Secret Cave → Triforce Charts
--------------------
CREATE TABLE IF NOT EXISTS `SecretCaveTriforceChart`(
    `id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    `secretCaveId` INTEGER NOT NULL,
    `triforceChartNumber` INTEGER NOT NULL,
        FOREIGN KEY (`secretCaveId`) REFERENCES
            `SecretCave`(`id`),
        FOREIGN KEY (`triforceChartNumber`) REFERENCES
            `TriforceChart`(`number`)
);
CREATE INDEX `secret_cave_triforce_chart_scId` ON
    `SecretCaveTriforceChart`(`secretCaveId`);
CREATE INDEX `secret_cave_triforce_chart_trNum` ON
    `SecretCaveTriforceChart`(`triforceChartNumber`);

INSERT INTO `SecretCaveTriforceChart` (
    `secretCaveId`, `triforceChartNumber`
) VALUES
    (06, 01), -- B5
    (07, 06), -- B7
    (08, 07), -- C5
    (12, 02), -- E5
    (19, 08), -- G1
    (20, 03)  -- G5
;

-- Secret Cave → Other Charts
--------------------
CREATE TABLE IF NOT EXISTS `SecretCaveOtherChart`(
    `id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    `secretCaveId` INTEGER NOT NULL,
    `otherChartNumber` INTEGER NOT NULL,
        FOREIGN KEY (`secretCaveId`) REFERENCES
            `SecretCave`(`id`),
        FOREIGN KEY (`otherChartNumber`) REFERENCES
            `OtherChart`(`number`)
);
CREATE INDEX `secret_cave_other_chart_scId` ON
    `SecretCaveOtherChart`(`secretCaveId`);
CREATE INDEX `secret_cave_other_chart_ocNum` ON
    `SecretCaveOtherChart`(`otherChartNumber`);

INSERT INTO `SecretCaveOtherChart` (
    `secretCaveId`, `otherChartNumber`
) VALUES
    (02, 01), -- A6 Ghost Ship Chart
    (18, 12)  -- F7 Submarine Chart
;

END;
