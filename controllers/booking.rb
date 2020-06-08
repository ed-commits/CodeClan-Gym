require( 'sinatra' )
require( 'sinatra/contrib/all' )

require_relative('../models/member')
require_relative('../models/gymclass')
require_relative('../models/booking')

get '/book/:class' do
    erb( :signup )
end
