class StaticPagesController < ApplicationController
  def welcome
  end

  def shortcuts
    @side_feeds = Feed.all
  end
end
