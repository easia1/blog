class ArticlesController < ApplicationController
    def index
        @articles = Article.all
        @article = Article.new
    end

    def show
        @article = Article.find(params[:id])
        @comments = @article.comments
    end

    def new
        @article = Article.new
    end

    def create
        @articles = Article.all
        #@article = Article.new
        # @article.name = params[:name]
        # @article.body = params[:body]
        @article = Article.new(article_params)

        # if @article.save
        #     redirect_to articles_path
        # else
        #     render :new
        # end

        respond_to do |format|
            if @article.save
                format.js
            else
                format.html { render :index }
            end
        end
    end

    def edit
        @article = Article.find(params[:id])
    end

    def update
        @article = Article.find(params[:id])

        if @article.update(article_params)
            redirect_to articles_path
        else
            render :edit
        end
    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy

        redirect_to articles_path
    end

    private

    def article_params
        params.require(:article).permit(:name, :body)
    end

end
