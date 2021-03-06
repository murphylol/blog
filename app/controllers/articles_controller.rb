class ArticlesController < ApplicationController
	
	 # http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]
  before_action :authenticate_user!
	def index
    	@articles = Article.where(:user_id => current_user.id)
  end

	def show
   	 	@article = Article.find(params[:id])
      @user = User.find(params[:user_id])
      @comment = Comment.new
  end

	def new
  		@article = Article.new
	end

	def edit
    @user = User.find(params[:user_id])
		@article = Article.find(params[:id])
	end

	def create
    @user = User.find(params[:user_id])
 		@article = @user.articles.create(article_params)

  		if @article.save
    			redirect_to @user
  		else
    			render '_form'
  		end
	end
	
	def update
		@article = Article.find(params[:id])
		if @article.update(article_params)
			redirect_to @article
		else
			render "edit"
		end
	end

	
  def destroy
    @article =  Article.find(params[:id])
		@article.destroy
		redirect_to articles_path
	end

	private
  		def article_params
    		params.require(:article).permit(:title, :text, :sender)
  		end
	end