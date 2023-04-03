# app/controllers/folders_controller.rb
class FoldersController < ApplicationController
  before_action :set_user
  before_action :set_folder, only: [:show,:edit,:update,:destroy]

  def index
    @user = current_user
    @folders = @user.folders
    @folders = Folder.all
  end

  def show    
    @folder = @user.folders.find(params[:id])
    @subfolders = Subfolder.all
    @current_folder = @folder
  end


  def new
    @parent = Folder.find_by(id: params[:parent_id])
    @folder = @user.folders.build(parent: @parent)
  end
  

  def create
    @folder = @user.folders.build(folder_params)
    
    if @folder.save
      redirect_to user_folders_path(@user), notice: "Folder was successfully created."
    else
      render :new
    end
  end
 
  
  def edit
   
  end

  def update
    if @folder.update(folder_params)
      redirect_to user_folders_path(@user, @folder), notice: "Folder was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @folder = Folder.find(params[:id])
    @folder.destroy
    
    redirect_to user_folder_path(@user, @folder), notice: 'Folder was successfully destroyed.'
  end
  

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_folder
    @folder = @user.folders.find(params[:id])
  end

  def folder_params
    params.require(:folder).permit(:name, :user_id, files: [])
  end
end
