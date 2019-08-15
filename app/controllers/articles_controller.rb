class ArticlesController < ApplicationController
  def index
    @articles = Article.all.page(params[:page])
  end

  def starred
    @starred = Article.where(starred: true).page(params[:page])
  end

  def star
  end
end
