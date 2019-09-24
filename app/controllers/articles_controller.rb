class ArticlesController < ApplicationController
  def unread
    @side_feeds = Feed.all
    @q = Article.where(unread: true).ransack(params[:q])
    @articles = @q.result(distinct: true).order_pub
    @now_page = '全フィード'
    @articles_count = @articles.size
  end
    
  def starred
    @side_feeds = Feed.all
    @q = Article.where(starred: true).ransack(params[:q])
    @articles = @q.result(distinct: true).order_star
    @now_page = 'スター付き'
    @articles_count = @articles.size
  end
  
  def update
    article = Article.find(params[:id])

    if params[:ajax] == 'unread'
      article.update(unread: false)
      head :no_content
    else
      if article.starred
        article.update(starred: false, starred_at: nil)
      else
        article.update(starred: true, starred_at: Time.now)
      end
    end
  end
end
