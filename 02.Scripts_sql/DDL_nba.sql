CREATE SCHEMA IF NOT EXISTS nba_dwh_py;


CREATE TABLE nba_dwh_py.dim_games (
    game_id SERIAL PRIMARY KEY,
    game_name VARCHAR(100) NOT NULL
);

CREATE TABLE nba_dwh_py.dim_player (
    player_id INT PRIMARY KEY,
    player_name VARCHAR(100) NOT NULL
);

CREATE TABLE nba_dwh_py.dim_start_position (
    start_position_id INT PRIMARY KEY,
    position_name VARCHAR(50) NOT NULL,
    flag_holder INT
);

CREATE TABLE nba_dwh_py.dim_team (
    team_id INT PRIMARY KEY,
    nickname VARCHAR(100),
    conference VARCHAR(100),
    city VARCHAR(100)
);

CREATE TABLE nba_dwh_py.dim_date (
    date_id INT PRIMARY KEY,
    full_date DATE NOT NULL,
    year INT,
    quarter INT,
    month_number INT,
    month_name VARCHAR(20),
    week_of_year INT,
    day_of_month INT,
    day_of_week_number INT,
    day_of_week_name VARCHAR(20),
    is_weekend BOOLEAN
);

-- =========================
-- Tabla de Hechos
-- =========================

CREATE TABLE nba_dwh_py.fact_statistical (
    game_id INT NOT NULL,
    team_id INT NOT NULL,
    date_id INT NOT NULL,
    player_id INT NOT NULL,
    start_position_id INT NOT NULL,
    sec INT,
    fgm INT,
    fga INT,
    fg3m INT,
    fg3a INT,
    ftm INT,
    fta INT,
    reb INT,
    ast INT,
    stl INT,
    blk INT,
    tos INT,
    pf INT,
    pts INT,
    PRIMARY KEY (game_id, team_id, date_id, player_id, start_position_id),
    FOREIGN KEY (game_id) REFERENCES nba_dwh_py.dim_games(game_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (team_id) REFERENCES nba_dwh_py.dim_team(team_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (date_id) REFERENCES nba_dwh_py.dim_date(date_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (player_id) REFERENCES nba_dwh_py.dim_player(player_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (start_position_id) REFERENCES nba_dwh_py.dim_start_position(start_position_id) ON UPDATE CASCADE ON DELETE RESTRICT
);
