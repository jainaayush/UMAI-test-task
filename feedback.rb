require_relative 'database'
require 'pry'

class FeedBack < Database
  class << self
    def create_feedback_table
      sql =  <<-SQL
          CREATE TABLE feedback (
          owner_id int NOT NULL,
          comment varchar(255) NOT NULL,
          user_id INT NOT NULL,
          post_id INT NOt NULL,
          FOREIGN KEY (user_id) REFERENCES users(id),
          FOREIGN KEY (post_id) REFERENCES posts(id)
          )
          SQL
      Database.new.connection(sql)
    end

    def insert_feedback(params)
      sql =  <<-SQL
            INSERT INTO 
            feedback (owner_id, comment, user_id, post_id) 
            Values
            (#{params["owner_id"]}, '#{params["feedback"]}', #{params["user_id"]}, #{params["post_id"]})
            SQL
      Database.new.connection(sql)
    end

    def fetch_feedback(params)
      feedback = fetch(params)
      if feedback.empty?
        insert_feedback(params)
      end
      return fetch(params)
    end

    def fetch(params)
      sql =  <<-SQL
              select comment from feedback where owner_id = '#{params["owner_id"]}' and user_id = '#{params["user_id"]}' and post_id = '#{params["post_id"]}';
              SQL
      Database.new.connection(sql)
    end
  end
end
