class StaticPagesController < ApplicationController
  def welcome
    redirect_to unread_articles_path if user_signed_in?
  end

  def shortcuts
    @side_feeds = Feed.all.recently
  end
end
