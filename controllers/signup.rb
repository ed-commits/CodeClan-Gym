require( 'sinatra' )
require( 'sinatra/contrib/all' )

require_relative('../models/member')

get '/sign-up' do
    erb( :signup )
end

post '/sign-up' do
    member = Member.by_name_and_dob(params['name'], params['dob'])
    if member
        member.active = 1
        member.update
        @pin = member.pin
        erb(:signup_reactivated)
    else
        member = Member.new(params)
        if member.valid?
            @pin = member.pin
            erb(:signup_created)
        else
            erb(:signup_tooyoung)
        end
    end
end
