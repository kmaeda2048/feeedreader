class ArticlesController < ApplicationController
  def index
    @articles = Article.all.page(params[:page])
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article, notice: "「#{@article.title}」のメモを更新しました。"
    else
      render :edit
    end
  end

  def starred
    @starred = Article.where(starred: true).page(params[:page])
  end

  def star
  end

  private

  def article_params
    params.require(:article).permit(:memo)
  end
end
