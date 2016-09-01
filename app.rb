require "sinatra"
require "sinatra/contrib"
require "sinatra/reloader"
require "data_mapper"
require "pry"

configure do
  enable :sessions
  set :session_secret, "jasdfi8nndndf9ndf73"
end

configure do
  DataMapper::Logger.new($stdout, :debug)
  DataMapper.setup(:default, "sqlite3:///data/data.db")
  DataMapper.finalize
  DataMapper.auto_upgrade!
end

class Player
  include DataMapper::Resource

  property :id, Serial
  property :name, String

  belongs_to :gameplayer
  has n, :scores
end

class Game
  include DataMapper::Resource

  property :id, Serial
  property :date, Date

  belongs_to :gameplayer
  has n, :scores
end

class GamePlayer
  include DataMapper::Resource

  property :id, Serial
  property :id_game, Integer
  property :id_player, Integer

  has n, :players
  has n, :games
end

class Score
  include DataMapper::Resource

  property :id, Serial
  property :id_game, Serial
  property :id_player, Serial

  belongs_to :game
  belongs_to :player
end

get "/" do
  erb :index
end
