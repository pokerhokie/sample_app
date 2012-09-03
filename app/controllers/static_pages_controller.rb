class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @microposts = current_user.feed.paginate(page: params[:page])
      @micropost = current_user.microposts.build
    end 
  end

  def help
  end
  
  def about
  end

  def contact
  end

end
