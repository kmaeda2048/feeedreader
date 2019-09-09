class ArticlesController < ApplicationController
  def index
    @feeds = Feed.all
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
    @feeds = Feed.all
    @starred_articles = Article.where(starred: true)
    @now_page = 'スター付き'
    @articles_count = @starred_articles.size
  end
end
