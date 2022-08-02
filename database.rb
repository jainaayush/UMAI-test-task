require 'pg'

class Database
  def connection(query)
    @conn = PG.connect( dbname: 'test', user: 'postgres', password: 'postgres', port: 5432, host: '127.0.0.1' )
    result = @conn.exec( query ) do |result|
      result.map{|row| row }
    end
    return result
  end
end
