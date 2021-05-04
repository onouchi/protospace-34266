class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  def show
    @user = User.find(params[:id])
    @name = @user.name
    @prototypes = @user.prototypes.includes(:user)
    @profile = @user.profile
    @occupation = @user.occupation
    @position = @user.position
  end
end
