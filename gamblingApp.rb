require 'sinatra'
require 'sinatra/reloader' if development?
require './user'

configure do
enable :sessions
end

get '/' do
  redirect '/login'
end

get '/login' do
  erb :login
end

post '/login' do
session[:username]=params[:username]
session[:password]=params[:password]
  @user = User.all(:username.like=>session[:username])
  if (@user.any?) #check if user object is not user does not exists
      if(session[:password] == User.all(:username.like=>session[:username]).first.password && session[:username] == User.all(:username.like=>session[:username]).first.username)
        session[:login]=true
        session[:accountprofit]=User.all(:username.like=>session[:username]).first.profit
        session[:accountloss]=User.all(:username.like=>session[:username]).first.loss
        session[:accountwin]=User.all(:username.like=>session[:username]).first.win
        puts "Successfully logged in!"
        redirect '/home'
      else
        session[:message] ="Username and password does not match! Please try again"
        redirect '/login'
      end
  else
    session[:message] ="Username and password does not match! Please try again"
    redirect '/login'
  end
end

get '/home' do
  if session[:login]
      if session[:sessionprofit]
        puts "Session object exists"
      else
        session[:sessionprofit]=0
        session[:sessionwin]=0
        session[:sessionloss]=0
      end
    erb :home
    else
    redirect '/login'
  end
end



post '/home' do
  @random=rand(1..6) #generating the randomn number between 1 to 6
  if @random == params[:on].to_i
    puts "Inside if"
    session[:winMessage] ="Congratulations!! YOU WON"
    session[:sessionwin] = session[:sessionwin].to_i + 2 * params[:bet].to_i
    session[:accountwin] = session[:accountwin].to_i + 2 * params[:bet].to_i
    session[:sessionprofit] = session[:sessionwin].to_i  - session[:sessionloss].to_i
    session[:accountprofit] = session[:accountwin].to_i  - session[:accountloss].to_i
  else
    session[:winMessage] ="Better luck next time!"
    session[:sessionloss]= session[:sessionloss].to_i + params[:bet].to_i
    session[:accountloss] += params[:bet].to_i
    session[:sessionprofit] = session[:sessionwin].to_i  - session[:sessionloss].to_i
    session[:accountprofit] = session[:accountwin].to_i  - session[:accountloss].to_i
  end
  puts "#{session[:sessionwin]} and  #{params[:bet]}"
  #Updating the account balances to databases
  User.update(profit:session[:accountprofit])
  User.update(loss:session[:accountloss])
  User.update(win:session[:accountwin])
  redirect to('/home')
end

post '/logout' do
  session[:login]=false
  session[:message]="Successfully logout! Please login again "
  User.update(profit:session[:accountprofit])
  User.update(loss:session[:accountloss])
  User.update(win:session[:accountwin])
  session.clear
  redirect '/login'
end
