#specify db to connect to.  Rake creates tables
#through migrations.  Otherwise you have to
#make tables by hand, which sucks.

require 'zlib'
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'

ActiveRecord::Base.establish_connection(
    :database => 'musical_api2',
    :adapter => 'mysql2'
)
