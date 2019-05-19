require 'pry'
class Song

  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name,artist=nil,genre=nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
    self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create(name)
      song = Song.new(name)
      song.save
      song
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    if !genre.songs.include?(self)
      genre.songs << self
    end
  end

  def self.find_or_create_by_name(name)
    if !self.find_by_name(name)
        self.create(name)
      else
        self.find_by_name(name)
  end
end

  def self.find_by_name(name)
      self.all.find{|song| song.name == name}
  end

  def self.new_from_filename(filename)
    artist_name = filename.split(" - ")[0]
    song_name = filename.split(" - ")[1]
    genre_name = filename.split(" - ")[2].gsub(".mp3", "")
    song = Song.new(song_name)
    song.artist = Artist.find_or_create_by_name(artist_name)
    song.genre = Genre.find_or_create_by_name(genre_name)
    song
  end

  def self.create_from_filename(filename)
      filename = Song.new_from_filename(filename)
      filename.save
      filename
  end

end
