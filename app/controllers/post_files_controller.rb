class PostFilesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  
  def new
     @postfiles = PostFile.new
  end
  
  def create
    @postfiles = PostFile.create(post_files_params)
    @postfiles.user_id = current_user.id
    tag_list = params[:post_file][:name].split(",")
    @postfiles.save
    @postfiles.save_tags(tag_list)
    redirect_to post_files_path(user_id: current_user.id,targeturl: "" ,targetyear: Date.today.year, targetmonth: Date.today.month, targetday: Date.today.day)
  end

  def index
    #@postfiles_all = PostFile.all
    @postfiles_all = PostFile.order("#{sort_column} #{sort_direction}")
  end

  def show
    @postfiles = PostFile.find(params[:id])  
    @postcomment = PostComment.new
  end
  
  def edit
    @postfiles = PostFile.find(params[:id])  
    @tag_list = @postfiles.tags.pluck(:name).join(",")
  end
  
  def update
    #@postfiles = PostFile.find(params[:id])
      @postfiles = PostFile.where(id: params[:id])
      @tag_list = params[:post_file][:name].split(",")
      @postfiles[0].title = params[:post_file][:title]
      @postfiles[0].introduction = params[:post_file][:introduction]
      @postfiles[0].evaluation = params[:post_file][:evaluation]
      @postfiles[0].files.each do |file|
        file.purge
      end
      @postfiles[0].files = params[:post_file][:files]
      if @postfiles = @postfiles[0]
        @postfiles.save
        @postfiles.save_tags(@tag_list)
        redirect_to post_file_path(@postfiles)
      else
        render :edit
      end
  end
  
  def search_tag
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @postfiles_all = @tag.post_files.all
  end
  
  def destroy
    @postfiles = PostFile.find(params[:id])#find(params[:id])
    @postfiles.destroy
    redirect_to user_path(current_user)
  end
  
  def sort_favorited
    @postfiles_all = PostFile.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
  end
  
  def sort_commented
    @postfiles_all = PostFile.includes(:post_commented_users).sort {|a,b| b.post_commented_users.size <=> a.post_commented_users.size}
  end
  
  private
  
  def post_files_params
    params.require(:post_file).permit(:title,:introduction,:evaluation, files: [] ) 
  end
  
  def ensure_correct_user
    @postfiles = PostFile.find(params[:id])
    unless @postfiles.user == current_user
      redirect_to user_path(current_user)
    end
  end
  
  #ソート機能
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
  
  def sort_column
    PostFile.column_names.include?(params[:sort]) ? params[:sort] : 'title'
  end
end
