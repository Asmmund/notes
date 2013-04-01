class ArticlesController < ApplicationController
before_filter :authorize, only: [:create, :update, :destroy]
  respond_to :json

  def index
    respond_with Article.all
  end
  def show
    respond_with Article.find(params[:id])
  end
  def create
    respond_with Article.create(params[:article])
  end
  def update
    respond_with Article.update(params[:id],params[:article])
  end
  def destroy
    respond_with Article.destroy(params[:id])
  end
end
