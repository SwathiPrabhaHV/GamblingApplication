require 'dm-core'
require 'dm-migrations'


# DataMapper.setup(:default,"sqlite3://#{Dir.pwd}/user.db")


class User
  include DataMapper::Resource
  property :id, Serial
  property :username, String
  property :password, String
  property :win, Integer
  property :loss, Integer
  property :profit, Integer
end
DataMapper.finalize

configure :development, :test do
DataMapper.setup(:default,"sqlite3://#{Dir.pwd}/user.db")
end

configure :production do
DataMapper.setup(:default,ENV['DATABASE_URL'])
end
# DataMapper.auto_migrate!
#User.auto_upgrade!

# User.create(username:"user",password:"pass",win:10000 ,loss:0,profit:10000)
# user=User.new username:"user",password:"pass",won:10000 ,loss:0,profit:10000
# user.save
