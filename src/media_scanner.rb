require_relative '../lib/db.rb'
require 'set'

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
        
        puts "Scanned #{files.length} music files. Preparing for DB insert..."
        # Add each discovered file to the files table
        if add_to_db
            files.each do |f|
                print "Inserting #{f} ..."
                DB.execute "INSERT INTO #{FILES_TABLE} (path) VALUES (?)", f
                puts "\t[DONE]"
            end
        end

        # Return the files list in case someone else wants to know about them
        files
    end
end

##################
##### MAIN #######
##################
if __FILE__ == $0
    scanner = MediaScanner.new(ARGV[-1])
    puts "Scanning..."
    songs = scanner.scan
    puts "Found #{songs.length} unique audio files."
end
