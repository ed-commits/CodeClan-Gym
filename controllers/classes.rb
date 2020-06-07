require( 'sinatra' )
require( 'sinatra/contrib/all' )

require_relative('../models/gymclass')

get '/classes' do
    @weeks = GymClass.classes_this_month_friendly
    erb( :classes )
end
