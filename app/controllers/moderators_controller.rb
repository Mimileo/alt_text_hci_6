class ModeratorsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :create, :update, :new, :destroy]
  before_action :set_moderator, only: %i[ show edit update destroy ]

  # GET /moderators or /moderators.json
  def index
     search = params[:query].present? ? params[:query] : nil
    if search.nil?
       @moderators = Moderator.all
       @users = User.all

    else
      @moderators =  Moderator.search(search, fields:[:user_id, :first_name, :last_name, :email], operator: "or")
      @users = @moderators
    end
   
    authorize @moderators
  end

  # GET /moderators/1 or /moderators/1.json
  def show
    @moderator = Moderator.find(params[:id])
    @user = @moderator.user
    authorize @moderator
  end

  # GET /moderators/new
  def new
    @users = User.all
    @moderator = Moderator.new
    authorize @moderator
  end

  # GET /moderators/1/edit
  def edit
    @users = User.all
    @moderator = Moderator.find(params[:id])
    authorize @moderator
  end

  # POST /moderators or /moderators.json
  def create
    @moderator = Moderator.new(moderator_params)
    authorize @moderator

    respond_to do |format|
      if @moderator.save
        format.html { redirect_to moderator_url(@moderator), notice: "Moderator was successfully created." }
        format.json { render :show, status: :created, location: @moderator }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @moderator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /moderators/1 or /moderators/1.json
  def update
    authorize @moderator
    respond_to do |format|
      if @moderator.update(moderator_params)
        moderator2 = Moderator.find(params[:id])
        update_user_information(moderator2)

        format.html { redirect_to moderator_url(@moderator), notice: "Moderator was successfully updated." }
        format.json { render :show, status: :ok, location: @moderator }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @moderator.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_user_information(moderator2)
    u = User.find_by(email: moderator2.email)
    u.update(flag: moderator2.flag, referee: moderator2.referee, contributor: moderator2.contributor, super_user: moderator2.super_admin)
  end

  # DELETE /moderators/1 or /moderators/1.json
  def destroy
    authorize @moderator
    @moderator.destroy

    respond_to do |format|
      format.html { redirect_to moderators_url, notice: "Moderator was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_moderator
      @moderator = Moderator.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def moderator_params
      params.require(:moderator).permit(:user_id, :title, :description, :super_admin, :referee, :contributor, :flag, :email, :first_name, :last_name)
    end
end
