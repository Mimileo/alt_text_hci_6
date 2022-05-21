require 'open-uri'

class AltTextsController < ApplicationController
  before_action :set_alt_text, only: %i[ show edit update destroy ]

  # GET /alt_texts or /alt_texts.json
  def index
    #@alt_texts = AltText.select('DISTINCT alt_id')
    search = params[:alt_id].present? ? params[:alt_id] : nil
    if search.nil?
       @alt = Alt.new
       @alt_texts = policy_scope(AltText.select('DISTINCT alt_id'))
    else
      @alt = Alt.new
      @alt_texts = policy_scope(AltText.where(alt_id: search))
    end
    #@alt = Alt.new
   # @alt_texts = policy_scope(AltText.select('DISTINCT alt_id'))
    authorize @alt_texts
  end

  # GET /alt_texts/1 or /alt_texts/1.json
  def show
  end

  def history
    @alt_texts = policy_scope(AltText.select('DISTINCT alt_id'))
    authorize @alt_texts
  end

  # GET /alt_texts/new
  def new
    @alt_text = AltText.new
    authorize @alt_text
  end
 
  # GET /alt_texts/1/edit
  def edit
    authorize @alt_text
  end

 

  # POST /alt_texts or /alt_texts.json
  def create
    @alt_text = AltText.new(alt_text_params)

    respond_to do |format|
      if @alt_text.save
        format.html { redirect_to alt_text_url(@alt_text), notice: "Alt text was successfully created." }
        format.json { render :show, status: :created, location: @alt_text }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @alt_text.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alt_texts/1 or /alt_texts/1.json
  def update
    respond_to do |format|
      if @alt_text.update(alt_text_params)
        format.html { redirect_to alt_text_url(@alt_text), notice: "Alt text was successfully updated." }
        format.json { render :show, status: :ok, location: @alt_text }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @alt_text.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alt_texts/1 or /alt_texts/1.json
  def destroy
    authorize @alt_text
    @alt_text.destroy

    respond_to do |format|
      format.html { redirect_to alt_texts_url, notice: "Alt text was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alt_text
      @alt_text = AltText.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def alt_text_params
      params.require(:alt_text).permit(:body, :user_id, :alt_id)
    end
end
