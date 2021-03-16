class MemosController < ApplicationController
  
  def create
    memo = Memo.new(memo_params)
    memo.user_id = current_user.id
    memo.save
    redirect_to user_path(current_user.id)
  end
  
  def destroy
    Memo.find_by(id: params[:id], user_id: params[:user_id]).destroy
    redirect_to user_path(current_user.id)
  end
  
  private
  
  def memo_params
    params.require(:memo).permit(:memotext)
  end
end
