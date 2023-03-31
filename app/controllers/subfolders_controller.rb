class SubfoldersController < ApplicationController
    before_action :set_user_folder
  
    def new
      @subfolder = @folder.subfolders.build
    end
  
    def create
      @subfolder = @folder.subfolders.build(subfolder_params)
      if @subfolder.save
        redirect_to user_folder_path(@user, @folder), notice: 'Subfolder was successfully created.'
      else
        render :new
      end
    end
  
    private
  
    def set_user_folder
      @user = User.find(params[:user_id])
      @folder = @user.folders.find(params[:folder_id])
    end
  
    def subfolder_params
      params.require(:folder).permit(:name, :parent_id)
    end
  end
  