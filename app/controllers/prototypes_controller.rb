class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :delete]
  before_action :move_to_index, except: [:index, :show]
  # before_action :move_to_index2, only: [:edit]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
    if  @prototype.user == current_user
      render :edit
    else
      redirect_to action: :index
    end
  end

  def update
    @prototype = Prototype.find(params[:id])
    @prototype.update(prototype_params)
    if @prototype.save
      redirect_to action: :show
    else
      render :edit
    end
    
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
    # unless current_user.id == prototype_user.id?
    #   redirect_to action: :index
    # end
    # if  prototype.user == current_user
    #   render :index
    # end
  end
end
