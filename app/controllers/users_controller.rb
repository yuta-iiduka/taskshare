class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_correct_user, only: [:edit, :update]
    
    def show
      @user = User.find(params[:id])
      @memo = Memo.new
    end
    def index
      @users = User.all
    end
    def edit
      @user = User.find(params[:id])
    end
    def update
      if @user.update(user_params)
        redirect_to user_path(@user), notice: "You have updated user successfully."
      else
        render "edit"
      end
    end
    def favorites
      @user = User.find(params[:id])
      @post_files = @user.post_files
      favorites = Favorite.where(user_id: current_user.id).pluck(:post_file_id)
      @favorites_all = PostFile.find(favorites)
    end
    
    private
    def user_params
      params.require(:user).permit(:profile_image, :name, :email, :opinion)
    end
    def ensure_correct_user
      @user = User.find(params[:id])
      unless @user == current_user
        redirect_to user_path(current_user)
      end
    end
end
