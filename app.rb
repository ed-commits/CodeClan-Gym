require( 'sinatra' )
require( 'sinatra/contrib/all' )

require_relative('controllers/signup')

get '/' do
    erb( :index )
end

get '/about-us' do
    erb( :aboutus )
end

get '/terminate' do
    erb( :terminate )
end
