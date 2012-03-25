class Movie < ActiveRecord::Base

  def self.all_ratings
    select("rating").group("rating").map(&:rating)
  end

  def self.find_similar(movie)
    Movie.where(:director => movie.director).where("id != ?", movie.id)
  end
end
