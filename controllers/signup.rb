require( 'sinatra' )
require( 'sinatra/contrib/all' )

get '/sign-up' do
    erb( :signup )
end
