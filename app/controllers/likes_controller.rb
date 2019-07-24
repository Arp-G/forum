class LikesController < ApplicationController

	before_action :authenticate_user!

	def create
		@post = Post.find(params[:post_id])
		@like = Like.new
		@like.user_id = current_user.id
		@like.post_id = @post.id

		if @like.save
			redirect_to post_path(@post), notice: "Liked post"
		else
			redirect_to post_path(@post), notice: "Failed to like post"
		end
	end

	def destroy
		@post = Post.find(params[:post_id])
		@like = Like.find_by( post_id: @post.id , user_id: current_user.id )

		if @like
			@like.destroy
			redirect_to post_path(@post), notice: "Unliked post"
		else
			redirect_to post_path(@post), notice: "Cannot unlike post"
		end

	end



end
