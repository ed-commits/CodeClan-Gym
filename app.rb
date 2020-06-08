require( 'sinatra' )
require( 'sinatra/contrib/all' )

require_relative('controllers/signup')
require_relative('controllers/classes')
require_relative('controllers/terminate')
require_relative('controllers/booking')

get '/' do
    erb( :index )
end

get '/about-us' do
    erb( :aboutus )
end
