require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "sinatra/content_for"

configure do
	enable :sessions
	set :session_secret, 'secret'
end

before do
	session[:lists] ||= []
end

get "/" do
	redirect "/lists"
end

get "/lists" do
	@lists = session[:lists]
	erb :lists, layout: :layout
end

get "/lists/new" do
	erb :new_list, layout: :layout
end

post "/lists" do
	@airline = params[:airline_name]
	@flight_number = params[:flight_number]
	@destination = params[:destination]
	@departure_time = params[:departure_time]
	session[:lists] << {"airline"=>@airline, "flight_number"=>@flight_number, "destination"=>@destination, "departure_time"=>@departure_time}
	session[:success] = "Flight Details Added"
	redirect "/lists"
end
