class SubfoldersController < ApplicationController
  before_action :set_user_folder, only: [:show, :new, :create]

  def new
    @subfolder = Subfolder.new
    @subfolder.folder_id = params[:folder_id]
    @subfolder.parent_id = params[:parent_id] if params[:parent_id].present?
  end

  def index
    @user = current_user
    @subfolders = Subfolder.joins(:folder).where(folders: { user_id: @user.id }, parent_id: nil)
  end
  
  

  def show
    @subfolder = Subfolder.find(params[:id])
  @current_folder = @subfolder.folder
  end

  def create
    @subfolder = Subfolder.new(subfolder_params)
    set_user_folder # move set_user_folder here
    if @subfolder.parent_id.present?
      parent = Subfolder.find_by(id: @subfolder.parent_id)
  
      if parent
        @subfolder.parent_id = parent.id
      else
        render :new
        return
      end
    end
    @subfolder.folder = @folder # set folder after set_user_folder is called
  
    if @subfolder.save
      redirect_to user_folder_subfolder_path(@user, @folder, @subfolder), notice: "Successfully created"
    else
      render :new
    end    
    
    puts @subfolder.id.inspect
    
  end
  

  private

  def set_user_folder
    @user = current_user
    @folder = @user.folders.find_by(id: params[:folder_id])
    @subfolder = @folder
  end

  def subfolder_params
    params.require(:subfolder).permit(:name, :parent_id, :folder_id)
  end
end
