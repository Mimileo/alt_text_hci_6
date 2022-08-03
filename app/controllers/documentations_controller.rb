class DocumentationsController < ApplicationController
  before_action :set_documentation, only: %i[ show edit update destroy ]

  # GET /documentations or /documentations.json
  def index
    @documentations = Documentation.all
    @documentation_about = Documentation.first
  end

  # GET /documentations/1 or /documentations/1.json
  def show
  end

  # GET /documentations/new
  def new
    if user_signed_in? && super_admin
      @documentation = Documentation.new
    else
      redirect_to documentations_path
    end
  end

  # GET /documentations/1/edit
  def edit
    if user_signed_in? && super_admin
      @documentation = Documentation.find(params[:id])
    else
      redirect_to documentations_path
    end
  end

  # POST /documentations or /documentations.json
  def create
    if user_signed_in? && super_admin
      @documentation = Documentation.new(documentation_params)

      respond_to do |format|
        if @documentation.save
          format.html { redirect_to documentation_url(@documentation), notice: "Documentation was successfully created." }
          format.json { render :show, status: :created, location: @documentation }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @documentation.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to documentations_path
    end
  end

  # PATCH/PUT /documentations/1 or /documentations/1.json
  def update
    if user_signed_in? && super_admin
      respond_to do |format|
        if @documentation.update(documentation_params)
          format.html { redirect_to documentation_url(@documentation), notice: "Documentation was successfully updated." }
          format.json { render :show, status: :ok, location: @documentation }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @documentation.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to documentations_path
    end
  end

  # DELETE /documentations/1 or /documentations/1.json
  def destroy
    if user_signed_in? && super_admin
      @documentation.destroy

      respond_to do |format|
        format.html { redirect_to documentations_url, notice: "Documentation was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      redirect_to documentations_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_documentation
      @documentation = Documentation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def documentation_params
      params.require(:documentation).permit(:body, :description, :seo, :title)
    end
end
