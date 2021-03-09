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
  end
  
  def edit
    @postfiles = PostFile.find(params[:id])  
  end
  
  def update
    
  end
  
  def destroy
    @postfiles.destroy
    redirect_to post_files_path
  end
  
  #課題
  def download
    @postfiles = PostFile.find(params[:id])
    @files = @post_files.file.blob.download
    if send_data(@files, disposition: 'attachment',
        filename: @postfiles.file.blob.filename.to_s,
        type: @postfiles.file.blob.content_type)
        head :no_content
    else
        render post_file_path(@postfiles)
    end
  end
  
  private
  
  def post_files_params
    params.require(:post_file).permit(:title,:introduction, files: [] ) #[])  
  end
  
end
