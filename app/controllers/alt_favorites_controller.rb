class AltFavoritesController < ApplicationController
  before_action :set_alt_favorite, only: %i[ show edit update destroy ]

  # GET /alt_favorites or /alt_favorites.json
  def index
    @alt_favorites = AltFavorite.all
  end

  # GET /alt_favorites/1 or /alt_favorites/1.json
  def show
  end

  # GET /alt_favorites/new
  def new
    @alt_favorite = AltFavorite.new
  end

  # GET /alt_favorites/1/edit
  def edit
  end

  # POST /alt_favorites or /alt_favorites.json
  def create
    @alts = Alt.order(created_at: :asc).page(params[:page]).where(verified: true, flag: false)
    @fav = AltFavorite.new
    @alt_favorite = AltFavorite.new(alt_favorite_params)
    @alt = Alt.find_by(params[:id])

    respond_to do |format|
      if @alt_favorite.save
        session[:return_to] ||= request.referer
        format.html { redirect_to session.delete(:return_to)}
        #format.js {redirect_to session.delete(:return_to), notice: "Added to My Seven Army favorites."}
        format.json { render :show, status: :created, location: @alt_favorite }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @alt_favorite.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alt_favorites/1 or /alt_favorites/1.json
  def update
    respond_to do |format|
      if @alt_favorite.update(alt_favorite_params)
        format.html { redirect_to alt_favorite_url(@alt_favorite)}
        format.json { render :show, status: :ok, location: @alt_favorite }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @alt_favorite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alt_favorites/1 or /alt_favorites/1.json
  def destroy
    @alt_favorite.destroy
   
    respond_to do |format|
      session[:return_to] ||= request.referer
      
      format.html { redirect_to session.delete(:return_to)}
      
      #format.json  { redirect_to session.delete(:return_to), notice: "Removed from My Seven Army favorites." }
      format.js
     
      
    end
  end

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alt_favorite
      @alt_favorite = AltFavorite.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def alt_favorite_params
      params.require(:alt_favorite).permit(:alt_id, :user_id)
    end
end
