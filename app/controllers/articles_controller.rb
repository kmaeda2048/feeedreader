class ArticlesController < ApplicationController
  def unread
    @side_feeds = current_user.feeds.recently
    @q = current_user.articles.unread.ransack(params[:q])
    @articles = @q.result(distinct: true).formerly
    @now_page = '全フィード'
    @articles_count = @articles.size
  end
    
  def starred
    @side_feeds = current_user.feeds.recently
    @q = current_user.articles.starred.ransack(params[:q])
    @articles = @q.result(distinct: true).order_star
    @now_page = 'スター付き'
    @articles_count = @articles.size
  end
  
  def update
    article = current_user.articles.find(params[:id])

    if params[:ajax] == 'unread'
      article.read
      head :no_content
    else
      article.toggle_star
    end
  end
end
