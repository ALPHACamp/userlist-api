class Api::V1::UsersController < ApiController
  def index
    @users = User.all
    render json: {
      results: @users
    }
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end
end
