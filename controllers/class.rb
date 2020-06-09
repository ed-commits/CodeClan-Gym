require( 'sinatra' )
require( 'sinatra/contrib/all' )

require_relative('../models/member')
require_relative('../models/gymclass')
require_relative('../models/booking')

get '/class/:class' do
    @class = GymClass.by_id(params[:class])
    erb( :'class' )
end
