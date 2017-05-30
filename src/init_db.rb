require_relative '../lib/db.rb'

DB.execute "DROP TABLE IF EXISTS #{PLAYLIST_TABLE}"
DB.execute "DROP TABLE IF EXISTS #{PLAYLIST_ENTRIES_TABLE}"
DB.execute "DROP TABLE IF EXISTS #{FILES_TABLE}"

DB.execute <<SQL
create table #{PLAYLIST_TABLE} (
    id   INT PRIMARY KEY,
    name VARCHAR(63) UNIQUE NOT NULL,
    sync BOOLEAN
);
SQL
DB.execute <<SQL
create table #{FILES_TABLE} (
    id   INT PRIMARY KEY,
    path VARCHAR(255) UNIQUE NOT NULL
);
SQL

DB.execute <<SQL
create table #{PLAYLIST_ENTRIES_TABLE} (
    id          INT PRIMARY KEY,
    playlist_id INT NOT NULL,
    file_id     INT NOT NULL,
    ordinal     INT,
    FOREIGN KEY(file_id) REFERENCES #{FILES_TABLE}(id),
    FOREIGN KEY(playlist_id) REFERENCES #{PLAYLIST_TABLE}(id)
);
SQL


