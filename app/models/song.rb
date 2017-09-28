class Song < ActiveRecord::Base

  attr_reader :song_genre_id


  belongs_to :artist
  belongs_to :genre
  has_many :notes


  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
  end

  def genre_name=(name)
    self.genre = Genre.find_by(name: name)
  end

  def genre_name
    self.genre.name
  end

  def note_contents=(contents)
    contents = contents.reject do |c|
      c.empty?
    end
     contents.each do |content|
       note = Note.find_or_create_by(content: content)
       self.notes << note
     end
   end

   def note_contents
     self.notes.map do |note|
       note.content
     end
   end

   def artist_name
     if artist.nil?
       nil
     else
       self.artist.name
     end
   end


end
