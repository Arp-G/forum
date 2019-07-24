class CommentsController < ApplicationController


	before_action :authenticate_user!,:correct_user? , only: [:edit,:update,:destroy]


	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.create(comment_params)
		@comment.user_id = current_user.id if current_user  # Assign a owner user to the comment if a current user exixts
															# without user_id the comment wont save

		if @comment.save
			redirect_to post_path(@post) , notice: "successfully posted comment" 
		else
			redirect_to post_path(@post) , notice: "Failed to post comment, comment cannot be blank" 
		end
	end

	def edit
		#@post = Post.find(params[:post_id])
		#@comment = @post.comments.find(params[:id])
	end

	def update
		#@post = Post.find(params[:post_id])
		#@comment = @post.comments.find(params[:id])

		if @comment.update(comment_params)
			redirect_to post_path(@post), notice: "Comment was updated"
		else
			render "edit"
		end
	end



	def destroy
		#@post = Post.find(params[:post_id])
		#@comment = @post.comments.find(params[:id])
		@comment.destroy

		redirect_to @post, notice: "The comment was deleted"
	end

	private

	def comment_params
		params.require("comment").permit(:comment)
	end

	def correct_user?
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])

		if current_user.id != @comment.user_id
			redirect_to posts_path(@post), notice: "You cannot change others comments"
		end

	end
end
