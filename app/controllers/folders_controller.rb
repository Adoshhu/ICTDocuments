# app/controllers/folders_controller.rb
class FoldersController < ApplicationController
  before_action :set_user
  #before_action :set_folder, only: [:show,:edit,:update,:destroy,:index]

  def index
    @folders = Folder.roots 
  end

  def show    
    @subfolders = @user.folders
    @files = @folder.files
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
      redirect_to user_folder_path(@user, @folder), notice: "Folder was successfully created."
    else
      render :new
    end
  end
  
  def edit
   
  end

  def update
    if @folder.update(folder_params)
      redirect_to user_folder_path(@user, @folder), notice: "Folder was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @folder.destroy 
    @folder.files.purge
    redirect_to folders_url, notice: 'Folder was successfully destroyed.'
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_folder
    set_user
    @folder = Folder.find(params[:id])
  end

  def folder_params
    params.require(:folder).permit(:name, :parent_id,:user_id, files: [])
  end
end
