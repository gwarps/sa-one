class Movie < ActiveRecord::Base
 def self.sorted_data(sort_by=nil)
   return Movie.order(sort_by)
 end

 def self.rating_list
  rating = Movie.select("distinct(rating)").order(:rating)
  return rating.collect{|x| x.rating}
 end
end
