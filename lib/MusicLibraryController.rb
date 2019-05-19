require 'pry'
class MusicLibraryController

  def initialize(path ='./db/mp3s' )
    @path = path
    MusicImporter.new(path).import
  end
  def call
    input = ""
    while input != "exit"
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    input = gets.strip
    if input == "list songs"
      list_songs
    elsif input == "list artists"
      list_artists
    elsif input == "list genres"
      list_genres
    elsif input == "list artist"
      list_artist
    elsif input == "list genre"
      list_genre
    elsif input == "play song"
      play_song
    input = "exit"
    end
  end
end

  def list_songs
    song_names = Song.all.sort{ |a,b| a.name <=> b.name}
    song_names.each_with_index do |song, index|
      puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    song_names = Artist.all.sort{ |a,b| a.name <=> b.name}
    song_names.each_with_index do |artist, index|
      puts "#{index+1}. #{artist.name}"
    end
  end

  def list_genres
    genre_names = Genre.all.sort{ |a,b| a.name <=> b.name}
    genre_names.each_with_index do |genre, index|
      puts "#{index+1}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip
    if artist = Artist.find_by_name(input)
      artist.songs.sort{|a,b| a.name <=> b.name}.each_with_index do |song, index|
        puts "#{index+1}. #{song.name} - #{song.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip
    if genre = Genre.find_by_name(input)
      genre.songs.sort{|a,b| a.name <=> b.name}.each_with_index do |song, index|
        puts "#{index+1}. #{song.artist.name} - #{song.name}"
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.chomp.to_i

    song = Song.all.sort{|a,b| a.name <=> b.name}
    if(1..song.length).include?(input)

    puts "Playing #{song.name} by #{song.artist.name}"
  end
end

end
