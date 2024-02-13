class UsersController <ApplicationController 
  def new 
    @user = User.new
  end 

  def show 
    @user = User.find(params[:id])
    if !session[:user_id]
      flash[:error] = "You must be logged in or registered to access a user's dashboard"
      redirect_to root_path
    end
  end 

  def create 
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to user_path(user)
    else  
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_to register_path
    end 
  end 

  def login_form

  end

  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      cookies.signed[:location] = {value: params[:location], expires: 7.days}
      redirect_to user_path(user)
    else 
      flash[:error] = "Invalid credentials"
      render :login_form
    end
  end

  def logout
    session.destroy
    redirect_to root_path
  end

  private 

  def user_params 
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end 
end 