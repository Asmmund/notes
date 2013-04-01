class SessionsController < ApplicationController
  respond_to :json

  def create
    @user = User.authenticate params[:email], params[:password]
    if @user
      create_user_session @user
      respond_with @user, location:'/', status: 200
    else
      respond_to do |format|
        format.json { render json: { error: 'invalid email or password' }, status: 401  }
      end
    end
  end

  def destroy
    destroy_user_session
    redirect_to root_path, notice: 'Logged out'
  end
end
