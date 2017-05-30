require_relative './db.rb'

class Playlist
    def initialize(name=nil)
        @name = name
        @files = if @name.nil?
            []
        else
            Playlist.load_from_db(@name)
        end
    end

    def self.load_from_db(name)
        
    end
end
