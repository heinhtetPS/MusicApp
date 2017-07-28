class UsersController < ActionController::Base

  def new
    @user = User.new
    render :new
  end

  def show
    render :show
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      redirect_to user_url(@user.id)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def login(user)
   session[:session_token] = user.reset_token!
   @current_user = user
  end


  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
