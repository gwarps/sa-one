class Movie < ActiveRecord::Base
 def self.sort_rate(ratings,sort_by)
  keys = []
  keys = ratings.keys if !ratings.nil?
  data = Movie.where(:rating=>keys)
  return data.order(sort_by)
 end
 

 def self.rating_list
  rating = Movie.select("distinct(rating)").order(:rating)
  return rating.collect{|x| x.rating}
 end
end
