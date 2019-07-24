class PostsController < ApplicationController

	before_action :find_post, only: [:show,:edit,:update,:destroy]

	before_action :authenticate_user!, except: [:index,:show,:search]

	before_action :correct_user?, only: [:edit,:update,:destroy]

	def index
		@posts = Post.all.order("created_at desc")
	end

	def new
		@post = current_user.posts.build
	end

	def create
		@post = current_user.posts.build(post_params)

		if @post.save
			redirect_to @post
		else
			render "new"
		end

	end

	def show
	end

	def edit
	end

	def update

		if @post.update(post_params)
			redirect_to @post
		else
			render "edit"
		end
	end

	def destroy
		@post.destroy

		redirect_to root_path
	end

	def get_pdf
		@post = Post.find(params[:post_id])
		send_data @post.make_pdf.render,filename: "#{@post.title}.pdf",type: "application/pdf"
	end

	def search
		regexp = Regexp.new(params[:search],"i")

		@matches = []

		Post.all.each do |post|

			if post.title.match(regexp) or post.user.name.match(regexp)
				@matches<<post
			end
		end

	end

	private

	def post_params
		params.require(:post).permit(:title,:content)
	end

	def find_post
		@post = Post.find(params[:id])
	end

	def correct_user?
		find_post

		if current_user.id != @post.user_id
			redirect_to posts_path(@post), notice: "You cannot change others posts"
		end
	end
end
