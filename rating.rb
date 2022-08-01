require_relative 'database'
require 'pry'

class Rating < Database
  class << self
    def create_rating_table
      sql =  <<-SQL
          CREATE TABLE rating (
          id SERIAL,
          value INT CHECK(value < 6 AND value > 0),
          post_id INT NOT NULL,
          FOREIGN KEY (post_id) REFERENCES posts(id)
          )
          SQL
      Database.new.connection(sql)
    end

    def insert_rating(params)
      sql =  <<-SQL
              INSERT INTO rating (value, post_id) 
              Values
              ('#{params["value"]}', '#{params["post_id"]}')
              SQL
      begin
        puts sql
        Database.new.connection(sql)
        average_rating_per_post(params["value"], params["post_id"])
      rescue
        response_body = [{ errors: "Please give the rating out of 5 #{value}" }.to_json]
        return [response_body, 422]
      end
    end

    def average_rating_per_post(value, post_id)
      sql =  <<-SQL
            select r.post_id, sum(r.value)/count(r.value) as AverageRating from rating r where r.post_id = post_id Group By r.post_id
            SQL
      result = Database.new.connection(sql)
      result.select{|data| data["post_id"] == post_id.to_s }
    end
  end
end
