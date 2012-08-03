class Movie < ActiveRecord::Base
 def self.sorted_data(sort_by=nil)
   return Movie.order(sort_by)
 end
end
