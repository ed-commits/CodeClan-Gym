require( 'sinatra' )
require( 'sinatra/contrib/all' )

require_relative('../models/member')

get '/sign-up' do
    erb( :signup )
end

post '/sign-up' do
    member = Member.new(params)
    if member.valid?
        erb(:signup_created)
    else
        erb(:signup_tooyoung)
    end
end
