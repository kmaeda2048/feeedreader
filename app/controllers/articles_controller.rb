class ArticlesController < ApplicationController
  def unread
    @side_feeds = Feed.all
    @q = Article.unread.ransack(params[:q])
    @articles = @q.result(distinct: true).order_pub
    @now_page = '全フィード'
    @articles_count = @articles.size
  end
    
  def starred
    @side_feeds = Feed.all
    @q = Article.starred.ransack(params[:q])
    @articles = @q.result(distinct: true).order_star
    @now_page = 'スター付き'
    @articles_count = @articles.size
  end
  
  def update
    article = Article.find(params[:id])

    if params[:ajax] == 'unread'
      article.read
      head :no_content
    else
      article.toggle_star
    end
  end
end
