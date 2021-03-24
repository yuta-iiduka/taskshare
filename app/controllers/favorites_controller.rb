class FavoritesController < ApplicationController
  def create
    @post_file = PostFile.find(params[:post_file_id])
    favorite = current_user.favorites.new(post_file_id: @post_file.id)
    favorite.save
    #redirect_to post_file_path(post_file)
  end
  def destroy
    @post_file = PostFile.find(params[:post_file_id])
    favorite = current_user.favorites.find_by(post_file_id: @post_file.id)
    favorite.destroy
    #redirect_to post_file_path(post_file)
  end
end
