class WikisController < ApplicationController
  before_action :authenticate_user!
  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
  end
  
  def new
    @wiki = Wiki.new
  end
  
  def create
    @wiki = Wiki.new
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    @wiki.user = current_user
    
    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to [@wiki]
    else
      flash.now[:alert] = "There was an error saving. Please try again."
      render :new
    end
  end
  
  def edit
    @wiki = Wiki.find(params[:id])
    @all_collaborators = User.all
  end
  
  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)
    
    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to [@wiki]
    else
      flash.now[:alert] = "There was an error saving. Please try again."
      render :edit
    end
  end
  
  def destroy
    @wiki = Wiki.find(params[:id])
    
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to welcome_index_path
    else
      flash.now[:alert] = "There was an error deleting the post."
      render :show
    end
  end
  
  private
  
  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
  
end
