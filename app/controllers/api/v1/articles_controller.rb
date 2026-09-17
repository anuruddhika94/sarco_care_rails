module Api
  module V1
    class ArticlesController < ApplicationController
      def index
        articles = Article.all
        articles = articles.where(category: params[:category]) if params[:category].present?
        render json: articles
      end

      def show
        render json: Article.find(params[:id])
      end
    end
  end
end
