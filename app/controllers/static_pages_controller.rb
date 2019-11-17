class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :welcome

  def welcome
    redirect_to unread_articles_path if user_signed_in?
  end

  def shortcuts
    @side_feeds = current_user.feeds.recently
  end
end
