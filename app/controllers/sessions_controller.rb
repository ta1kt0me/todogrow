class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    user = User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to :root  
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root, notice: 'Sign out!!!!'
  end
end
