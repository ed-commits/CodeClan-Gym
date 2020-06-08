require( 'sinatra' )
require( 'sinatra/contrib/all' )

require_relative('../models/member')

get '/terminate' do
    erb( :terminate )
end

post '/terminate' do
    member = Member.by_pin(params['pin'])
    if member
        member.terminate
        erb(:terminate_successful)
    else
        erb(:terminate_failed)
    end
end
