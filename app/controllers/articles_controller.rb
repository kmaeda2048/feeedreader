class ArticlesController < ApplicationController
  def index
    @feeds = Feed.all
    @articles = Article.all
    @now_page = '全記事'
  end
  
  def update
    article = Article.find(params[:id])
    if article.starred
      article.update(starred: false)
    else
      article.update(starred: true)
    end
  end
  
  def starred
    @feeds = Feed.all
    @starred_articles = Article.where(starred: true)
    @now_page = 'スターつき記事'
  end
end
