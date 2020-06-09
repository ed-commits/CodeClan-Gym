require( 'sinatra' )
require( 'sinatra/contrib/all' )

require_relative('../models/member')

get '/sign-up' do
    erb( :signup )
end

post '/sign-up' do
    member, status = Member.sign_up(params['name'], params['dob'])
    case status
    when :success
        @pin = member.pin
        erb(:'signup/created')
    when :reactivated
        @pin = member.pin
        erb(:'signup/reactivated')
    else
        erb(:'signup/tooyoung')
    end
end
