class UsersController < ApplicationController
    #論理的削除はどうするか？
    before_action :authenticate_user!
    before_action :ensure_correct_user, only: [:edit, :update]
    def show
        
    end
    def index
        
    end
    def edit
        
    end
    def update
        
    end
    
    private
    def user_params
        params.require(:user).permit(:name, :opinion)
    end
    def ensure_correct_user
        @user = User.find(params[:id])
        unless @user == current_user
            redirect_to user_path(current_user)
        end
    end
end
