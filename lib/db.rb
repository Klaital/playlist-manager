require 'sqlite3'

ENV = 'devel'
DATABASE_NAME_BASE = "media-scanner"

PLAYLIST_TABLE = 'playlists'
PLAYLIST_ENTRIES_TABLE = 'playlist_entries'
FILES_TABLE = 'songs'

# Open the  database
DB = SQLite3::Database.new "#{DATABASE_NAME_BASE}-#{ENV}.sqlite3"
