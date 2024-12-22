-- Find the quarterback who threw the longest throw in 2016. 
-- Output the quarterback name along with their corresponding longest throw.
-- The 'lg' column contains the longest completion by the quarterback.
;
create schema espn_hard_level;
use espn_hard_level;
CREATE TABLE qbstats_2015_2016 (
    att BIGINT,
    cmp BIGINT,
    game_points BIGINT,
    home_away VARCHAR(10),
    `int` BIGINT,
    lg VARCHAR(10),
    loss BIGINT,
    qb VARCHAR(40),
    rate FLOAT,
    sack BIGINT,
    td BIGINT,
    yds BIGINT,
    year BIGINT,
    ypa FLOAT
);
INSERT INTO qbstats_2015_2016 (
        att,
        cmp,
        game_points,
        home_away,
        `int`,
        lg,
        loss,
        qb,
        rate,
        sack,
        td,
        yds,
        year,
        ypa
    )
VALUES (
        40,
        25,
        21,
        'home',
        1,
        '85',
        0,
        'Tom Brady',
        105.5,
        2,
        3,
        315,
        2016,
        7.8
    ),
    (
        35,
        20,
        14,
        'away',
        2,
        '67',
        1,
        'Aaron Rodgers',
        98.2,
        3,
        2,
        280,
        2016,
        6.5
    ),
    (
        50,
        30,
        27,
        'home',
        0,
        '75',
        0,
        'Drew Brees',
        112.3,
        1,
        4,
        350,
        2016,
        7.0
    ),
    (
        28,
        18,
        17,
        'away',
        1,
        '60',
        1,
        'Russell Wilson',
        96.7,
        2,
        1,
        220,
        2016,
        6.8
    ),
    (
        45,
        28,
        24,
        'home',
        2,
        '78',
        0,
        'Matt Ryan',
        101.5,
        1,
        3,
        300,
        2016,
        7.2
    ),
    (
        38,
        22,
        20,
        'away',
        1,
        '90',
        0,
        'Ben Roethlisberger',
        110.0,
        0,
        2,
        340,
        2016,
        8.0
    ),
    (
        30,
        18,
        16,
        'home',
        1,
        '63',
        1,
        'Philip Rivers',
        92.5,
        3,
        2,
        240,
        2016,
        7.1
    );
SELECT qb,
    lg
FROM qbstats_2015_2016
WHERE lg =(
        SELECT MAX(lg)
        FROM qbstats_2015_2016
        WHERE year = 2016
    );