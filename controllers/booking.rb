require( 'sinatra' )
require( 'sinatra/contrib/all' )

require_relative('../models/member')
require_relative('../models/gymclass')
require_relative('../models/booking')

get '/book/:class' do
    @class = GymClass.by_id(params[:class])
    erb( :'booking/confirmation' )
end

post '/book/confirm' do
    if Booking.create_for_class_and_pin(params["id"], params["pin"])
        erb( :'booking/successful' )
    else
        erb( :'booking/failed' )
    end
end
