require_relative '../lib/db.rb'

class MediaScanner
    def initialize(root_path='.')
        @root_path = root_path

        # These are the types of supported music files 
        @glob_patterns = [
            '*.mp3',
            '*.flac',
            '*.ogg',
        ]
    end

    def scan(add_to_db = true)
        # Store the scan results as a set to guarantee no dupes    
        files = Set.new

        # Do a deep search of the directory for each pattern describing music files
        @glob_patterns.each do |pattern|
            Dir.glob(File.join(@root_path, '**', pattern)).each {|file| files.add(file)}
        end
        
        # Add each discovered file to the files table
        if add_to_db
            files.each do |f|
                DB.execute "INSERT INTO #{FILES_TABLE} [path] VALUES ('#{f}')"
            end
        end

        # Return the files list in case someone else wants to know about them
        files
    end
end

