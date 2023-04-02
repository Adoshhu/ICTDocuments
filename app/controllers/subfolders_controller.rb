class SubfoldersController < ApplicationController
    before_action :set_user_folder, only: [:new, :create]
  
    # GET /subfolders/new
    def new
      @subfolder = Subfolder.new
      @subfolder.parent_id = params[:parent_id] if params[:parent_id].present?
    end

    def index
      @subfolders = Subfolder.all
    end

    def show
      @subfolder = Subfolder.find(params[:id])
      @current_folder = @subfolder
    end

    # POST /subfolders
    def create
      @subfolder = Subfolder.new(subfolder_params)
      @subfolder.folder = @folder
  
      if @subfolder.save
        redirect_to user_folder_path(@user, @folder), notice: 'Subfolder was successfully created.'
      else
        render :new
      end
    end
  
    # ...
  
    private
  
    def set_user_folder
      @user = User.find(params[:user_id])
      @folder = @user.folders.find(params[:folder_id])
    end
  
    def subfolder_params
      params.require(:subfolder).permit(:name, :parent_id)
    end
  end
  