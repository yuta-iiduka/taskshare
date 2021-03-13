class SearchesController < ApplicationController
  def search
    @range = params[:range]
    search = params[:search]
    word = params[:word]
    sortstyle = params[:sortstyle]
    if @range =='1'
      @users = User.search(search,word)
    else
      @postfiles = PostFile.search(search,word,sortstyle)
    end
  end
end
