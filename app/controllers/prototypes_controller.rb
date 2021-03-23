class PrototypesController < ApplicationController
  before_action :authenticate_user!,only: [:index,:show]
  before_action :move_to_index, except: [:index, :show]

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
    @prototype = Prototype.find(params[:id])
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to "http://localhost:3000/"
  end

  def update
    prototype = Prototype.find(params[:id])
    prototype.update(prototype_params)
    if redirect_to root_path
     else
      render :edit
    end
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title,:catch_copy,:concept,:image).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
    redirect_to action: :index
   end
  end
end
