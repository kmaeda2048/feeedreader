class ArticlesController < ApplicationController
  def index
    @side_feeds = Feed.all
    @articles = Article.where(unread: true)
    @now_page = '全フィード'
    @articles_count = @articles.size
  end
  
  def update
    article = Article.find(params[:id])

    if params[:ajax] == 'unread'
      article.update(unread: false)
      head :no_content
    else
      if article.starred
        article.update(starred: false)
      else
        article.update(starred: true)
      end
    end
  end
  
  def starred
    @side_feeds = Feed.all
    @q = Article.where(starred: true).ransack(params[:q])
    @articles = @q.result(distinct: true)
    @now_page = 'スター付き'
    @articles_count = @articles.size
  end
end
