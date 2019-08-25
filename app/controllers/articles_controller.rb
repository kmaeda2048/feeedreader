class ArticlesController < ApplicationController
  def index
    @feeds = Feed.all
    @articles = Article.all.page(params[:page])
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
    @starred = Article.where(starred: true).page(params[:page])
  end
end
