require( 'sinatra' )
require( 'sinatra/contrib/all' )

require_relative('../models/member')

get '/terminate' do
    erb( :terminate )
end

post '/terminate' do
    member = Member.by_pin(params['pin'])
    if member
        @name = member.name
        member.terminate
        erb(:'terminate/successful')
    else
        erb(:'terminate/failed')
    end
end
