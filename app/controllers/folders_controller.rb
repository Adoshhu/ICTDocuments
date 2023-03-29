# app/controllers/folders_controller.rb
class FoldersController < ApplicationController
  before_action :set_user
  before_action :set_folder, except: [:index, :new, :create]

  def index
    @folders = @user.folders
  end

  def show
    @subfolders = @folder.children
    @files = @folder.files
  end

  def new
    @folder = @user.folders.build
    @parent_id = params[:parent_id]
    if @parent_id.present?
      @folder.parent = Folder.find_by(id: @parent_id)
      if @folder.parent.present?
        @folder.subfolder_id = @folder.parent.children.count + 1
      else
        @folder.subfolder_id = 1
      end
    end
  end
  
  
  

  def create
    @folder = @user.folders.build(folder_params)
    @folder.parent_id = params[:parent_id]
    if @folder.parent.present?
      @folder.subfolder_id = @folder.parent.subfolders.count + 1
    end
    if @folder.save
      redirect_to user_folder_path(@user, @folder), notice: "Folder was successfully created."
    else
      render :new
    end
  end



  def edit
    @parent_id = @folder.parent_id
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
    redirect_to user_folders_path(@user), notice: "Folder was successfully destroyed."
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_folder
    set_user
    if params[:id]
      @folder = @user.folders.find(params[:id])
    elsif params[:folder_id]
      @folder = @user.folders.find(params[:folder_id])
    end
  end

  def set_subfolder
    @subfolder = @folder.children.find(params[:id])
  end

  def folder_params
    params.require(:folder).permit(:name, :parent_id, :subfolder_id, files: [])
  end
end
