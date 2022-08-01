require_relative 'database'
require 'pry'

class Post
  class << self
    def create_post_table
      sql =  <<-SQL
          CREATE TABLE posts (
          id SERIAL,
          title varchar(50) NOT NULL,
          content varchar(255) NOT NULL,
          ip_address varchar(50) NOT NULL,
          user_id int NOT NULL,
          PRIMARY KEY (id),
          FOREIGN KEY (user_id) REFERENCES users(id)
          )
          SQL
      Database.new.connection(sql)
    end

    def insert_post(params)
      sql =  <<-SQL
          INSERT INTO 
            posts (title, content, ip_address, user_id) 
          Values
          ('#{params["title"]}', '#{params["content"]}', '#{params["ip_address"]}', '#{params["user_id"]}')
          SQL
      Database.new.connection(sql)
      post_fetch(params["user_id"])
    end

    def post_fetch(user_id)
      sql = <<-SQL
            Select * from posts where user_id = '#{user_id}' order by id desc limit 1
            SQL
      Database.new.connection(sql)
    end

    def fetch(params)
      binding.pry
      sql =   <<-SQL
              select p.id, title, content, sum(r.value)/count(r.value) as AverageRating from posts p Inner JOIN rating r ON p.id = r.post_id Group by p.id order by AverageRating desc limit '#{params["n"]}'
              SQL
      Database.new.connection(sql)
    end
  end
end

# Post.create_post_table
# Post.insert_post('test1', 'This is the content of test1', '127.0.0.1', 2)