class PostFilesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  def new
     @postfiles = PostFile.new
  end
  
  def create
    @postfiles = PostFile.create(post_files_params)
    @postfiles.user_id = current_user.id
    @postfiles.save
    redirect_to post_files_path
  end

  def index
    @postfiles_all = PostFile.all
  end

  def show
    @postfiles = PostFile.find(params[:id])  
    @postcomment = PostComment.new
  end
  
  def edit
    @postfiles = PostFile.find(params[:id])  
  end
  
  def update
    @postfiles = PostFile.find(params[:id])
    if @postfiles.update
      redirect_to post_file_path(@postfiles)
    else
      render :edit
    end
  end
  
  def destroy
    @postfiles = PostFile.find(params[:id])
    #@postfiles.files.purge
    @postfiles.destroy
    redirect_to user_path(current_user)
  end
  
  
  private
  
  def post_files_params
    params.require(:post_file).permit(:title,:introduction, files: [] ) 
  end
  
  def ensure_correct_user
    @postfiles = PostFile.find(params[:id])
    unless @postfiles.user == current_user
      redirect_to user_path(current_user)
    end
  end
  
end
