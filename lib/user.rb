require 'pg'

class User
  attr_reader :email_address, :password

  def initialize(email_address, password)
    @email_address = email_address
    @password = password
  end

  def self.create(email_address, password)
    if ENV['ENVIRONMENT'] == 'test'
      conn = PG.connect(dbname: 'makersbnb_test')
    else
      conn = PG.connect(dbname: 'makersbnb')
    end
    conn.exec(
      "INSERT INTO users (email_address, password) VALUES('#{email_address}', '#{password}');",
    )
  end

  def self.check(params)
    if ENV['ENVIRONMENT'] == 'test'
      conn = PG.connect(dbname: 'makersbnb_test')
    else
      conn = PG.connect(dbname: 'makersbnb')
    end
    result = conn.exec('SELECT * FROM users;')
    result_array = result.map { |user| user }

    if result_array.each { |user| user == params }
      return true
    else
      return false
    end
  end
end
