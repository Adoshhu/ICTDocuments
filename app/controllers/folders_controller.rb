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
    @folder = @user.folders.build
    @folder = Folder.new
    @parent = Folder.find_by(id: params[:parent_id])
  end

  def create
    @folder = @user.folders.build(folder_params)
    #@folder = Folder.new(folder_params)
  
    if @folder.parent_id.present?
      parent = Folder.find_by(id: @folder.parent_id)
  
      if parent
        @folder.parent_id = parent.id
      else
        render :new
        return
      end
    end
  
    if @folder.save
      redirect_to user_folders_path(@user, @folder), notice: "Folder was successfully created."
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
    @folder.subfolders.each do |subfolder|
      subfolder.destroy
    end
    @folder.destroy 
    @folder.files.purge
    redirect_to folders_url, notice: 'Folder was successfully destroyed.'
  end
  

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_folder
    @folder = @user.folders.find(params[:id])
  end

  def folder_params
    params.require(:folder).permit(:name, :parent_id,:user_id, files: [])
  end
end
