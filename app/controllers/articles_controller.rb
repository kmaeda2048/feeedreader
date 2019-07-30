class ArticlesController < ApplicationController
  def index
    @articles = Article.all
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

  private

  def article_params
    params.require(:article).permit(:memo)
  end
end
