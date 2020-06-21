require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'erubis' )

require_relative('controllers/signup')
require_relative('controllers/classes')
require_relative('controllers/class')
require_relative('controllers/terminate')
require_relative('controllers/booking')

helpers do
    def attr_esc(text)
      "\"" + Rack::Utils.escape_path(text) + "\""
    end
  end

get '/' do
    erb( :index )
end

get '/about-us' do
    erb( :aboutus )
end
