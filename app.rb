require( 'sinatra' )
require( 'sinatra/contrib/all' )
#require_relative('controllers/zombies_controller')
#require_relative('controllers/victims_controller')
#require_relative('controllers/bitings_controller')

get '/' do
    erb( :index )
end

get '/about-us' do
    erb( :aboutus )
end

get '/sign-up' do
    erb( :signup )
end

get '/terminate' do
    erb( :terminate )
end

get '/classes' do
    erb( :classes )
end
