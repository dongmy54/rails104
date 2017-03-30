class PostsController < ApplicationController
	before_action :authenticate_user!, :only => [:new, :create]

	def new
		@group = Group.find(params[:group_id])
		@post = Post.new
	end

	def create
		@group = Group.find(params[:group_id])
		@post = Post.new(post_params)
		@post.user = current_user
		@post.group = @group
		
		if @post.save
			redirect_to group_path(@group)
		else
			render :new 
	   end
	end

	def edit
		@post = Post.find(params[:id])
		@group = Group.find(params[:group_id])
	end

	def update
		@post = Post.find(params[:id])
        
	 if	@post.update(post_params)
		flash[:notice] = "post修改成功"
		redirect_to account_posts_path
     else
		render :edit
	 end
	 end

	 def destroy
	 	@post = Post.find(params[:id])
	 	@post.destroy
	 	redirect_to account_posts_path
	 end

	   private

	   def post_params
	   	params.require(:post).permit(:content)
	   end
end
