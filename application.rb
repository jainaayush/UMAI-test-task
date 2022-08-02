require_relative 'post'
require_relative 'rating'
require_relative 'feedback'
require_relative 'database'

class Application
  def call(env)
    req = Rack::Request.new(env)
    case env['REQUEST_PATH']
    when '/'
      ['200', {"Content-Type" => 'text/plain'}, ["Hello World!"]]
    
    when '/posts'
      if env['REQUEST_METHOD'] == 'GET'
        params = JSON.parse(req.body.read)
        binding.pry
        result = Post.fetch(params)
        [200, {"Content-Type" => 'application/json'}, result]
      end
      if env['REQUEST_METHOD'] == 'POST'
        params = JSON.parse(req.body.read)
        Post.insert_post(params)
        ['200', {"Content-Type" => 'application/json'}, [params.to_json]]
      end
    
    when '/feedbacks'
      if env['REQUEST_METHOD'] == 'GET'
        params = JSON.parse(req.body.read)
        result = FeedBack.fetch_feedback(params)
        ['200', {"Content-Type" => 'application/json'}, result.to_json]
      end
      if env['REQUEST_METHOD'] == 'POST'
        params = JSON.parse(req.body.read)
        FeedBack.insert_feedback(params)
        ['200', {"Content-Type" => 'application/json'}, [params.to_json]]
      end

    when '/ratings'
      if env['REQUEST_METHOD'] == 'POST'
        params = JSON.parse(req.body.read)
        result = Rating.insert_rating(params)
        ['200', {"Content-Type" => 'application/json'}, [result.to_json]]
      end
    else
      [
        '404',
        {"Content-Type" => 'application/json', "Content-Length" => '13'},
        ["404 Not Found"]
      ]
    end
  end
end
