class PrototypesController < ApplicationController
  before_action :authenticate_user!,except: [:index,:show]
  before_action :move_to_index,only: [:edit,:destroy]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.create(prototype_params)
      if @prototype.save
        redirect_to root_path
      else
       render :new
      end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments_list = @prototype.comments.includes(:user)
  end

  def edit
  end

  def destroy
    @prototype.destroy
    redirect_to root_path
  end

  def update
    @prototype = Prototype.find(params[:id])
    @prototype.update(prototype_params)
    if @prototype.save
      redirect_to root_path
     else
      render :edit
    end
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title,:catch_copy,:concept,:image).merge(user_id: current_user.id)
  end

 def move_to_index
    @prototype = Prototype.find(params[:id])
    unless user_signed_in? && current_user.id == @prototype.user_id
    redirect_to root_path
   end
 end
end