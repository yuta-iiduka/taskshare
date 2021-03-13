class PostCommentsController < ApplicationController
    
  def create
    post_file = PostFile.find(params[:post_file_id])
    comment = PostComment.new(post_comment_params)
    comment.user_id = current_user.id
    comment.post_file_id = post_file.id
    comment.save
    redirect_to post_file_path(post_file)
  end
  
  def destroy
    PostComment.find_by(id: params[:id], post_file_id: params[:post_file_id]).destroy
    redirect_to post_file_path(params[:post_file_id])
  end
  
  private
  
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
