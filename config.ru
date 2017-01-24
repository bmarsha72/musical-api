require 'sinatra/base'

#controllers
require './controllers/application_controller'
require './controllers/account_controller'
require './controllers/artist_controller'
require './controllers/song_controller'

#models
require './models/artist'
require './models/song'
require './models/account'

#map controllers to routes
map('/') { run ApplicationController }
map('/account') { run AccountController }
map('/artist') { run ArtistController }
