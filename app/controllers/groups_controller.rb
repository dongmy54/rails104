class GroupsController < ApplicationController
    before_action :authenticate_user! ,only: [:new, :create, :update, :edit, :destroy]

    def index
    	@groups = Group.all
    end

    def new
    	@group = Group.new
    end

    def show
    	@group = Group.find(params[:id])
    end

    def create
    	@group = Group.new(group_params)
        @group.user = current_user
    	if @group.save
    		redirect_to groups_path
    		flash[:notice] = "群创建成功！"
    	else
    		render :new
    	end
    end

    def edit
    	@group = Group.find(params[:id])

        if current_user != @group.user
            redirect_to root_path, alert: "你不是群的拥有者，不能进行编辑"
        end
        @group.title = "ruby"
        @group.save
    end

    def update
         if current_user != @group.user
            redirect_to root_path, alert: "你不是群的拥有者，不能进行修改"
         else
    	 @group = Group.find(params[:id])
    	 if @group.update(group_params)
    	    redirect_to groups_path, notice: "修改成功"
         else
         render :edit
         end
         end
    end

    def destroy
        if current_user != @group.user
            redirect_to root_path, alert: "你不是群的拥有者，不能进行删除"
        else
    	@group = Group.find(params[:id])
    	@group.destroy
    	redirect_to groups_path
        flash[:alert] = "此群已被你删除"  
        end     
    end

    private

    def group_params
    	params.require(:group).permit(:title, :description)
    end
end
