class ViewingPartiesController < ApplicationController 
  before_action :require_user, only: :new
  def new
    @user = User.find(params[:user_id])
    @movie = Movie.find(params[:movie_id])
  end 
  
  def create 
    user = User.find(params[:user_id])
    user.viewing_parties.create(viewing_party_params)
    redirect_to "/users/#{params[:user_id]}"
  end 

  private 

  def viewing_party_params 
    params.permit(:movie_id, :duration, :date, :time)
  end 

  def require_user
    @user = User.find(params[:user_id])
    @movie = Movie.find(params[:movie_id])
    if !session[:user_id]
      flash[:error] = "You must be logged in or registered to create a Viewing Party"
      redirect_to "/users/#{@user.id}/movies/#{@movie.id}"
    end
  end
end 