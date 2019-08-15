class ArticlesController < ApplicationController
  def index
    @articles = Article.all.page(params[:page])
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
