require_relative 'database'
require_relative 'post'
require 'pry'

class User
  class << self
    def create_user_table
      sql =  <<-SQL
          CREATE TABLE users (
          id SERIAL,
          username varchar(255) NOT NULL UNIQUE,
          PRIMARY KEY (ID)
          )
          SQL
      Database.new.connection(sql)
    end

    def insert_user(user_name)
      sql =  <<-SQL
                INSERT INTO 
                users (username) 
                Values
                ('#{user_name}')
                SQL
      Database.new.connection(sql)
    end

    def user_posts(user_name)
      user = fetch_user(user_name)

      if user.nil?
        insert_user(user_name)
        user = fetch_user(user_name)
      end

      user_id = user["id"].to_i
      begin
        post =  Post.insert_post("demo", "This is a demo content", "127.0.0.1", user_id)
        response_code = 200
        response_body = [post.to_json]
        puts [response_body, response_code]
      rescue
        response_code = 422
        response_body = [{ errors: "data not validate" }.to_json]
        puts [response_body, response_code]
      end
    end

    def fetch_user(user_name)
      sql = <<-SQL
            SELECT * from users where username = '#{user_name}'
            SQL
      Database.new.connection(sql).first
    end
  end
end

# User.create_user_table
# User.insert_user('demo')
# User.insert_user('demo1')