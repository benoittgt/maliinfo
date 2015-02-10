class PostsController < ApplicationController
	def index
		@posts = Post.all

		respond_to do |format|
      		format.html
      		format.rss { render :layout => false }
    	end
	end

	def new
		@post = Post.new
		set_available_data
	end

	def create
		post = Post.new(post_params)
  		if post.save
				redirect_to action: 'index'
			else
				redirect_to action: 'new', error: post.error_messages
		end
	end

	def edit
		@post = Post.find params[:id]
		set_available_data
	end

	def update
		post = Post.find params[:id]
		post.update_attributes(post_params)
			if post.save
				redirect_to action: 'index'
			else
				redirect_to action: 'new', error: post.error_messages
		end
	end

	private

  def set_available_data
    @available_posts = Post.all
    @available_tags = I18n.t(:tags)
  end

	def post_params
		params.require(:post).permit(:title, :picture, :content, tags: [])
	end
end