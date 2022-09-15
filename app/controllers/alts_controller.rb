class AltsController < ApplicationController
  require 'phashion'
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_alt, only: %i[ edit update destroy ]
  protect_from_forgery prepend: true
  # helper_method :scrape

  
  # GET /alts or /alts.json
  def index
    @fav = AltFavorite.new
    @alt = Alt.new
    if params[:query].present?
      query = params[:query].presence
      @alts = Alt.search(query, where:{verified: true, flag: false, flag: nil, banned_image: nil, check_performed: true}, fields:[:title, :tags, :body], operator: "or", page: params[:page], per_page: 20)
    elsif params[:tag].present?
      query = params[:tag].presence
      @alts = Alt.search(query, where:{verified: true, flag: false, flag: nil, banned_image: nil, check_performed: true}, fields:[:title, :tags, :body], operator: "or", page: params[:page], per_page: 20)
    else
      @alts = Alt.where(verified: true, flag: [false, nil], banned_image: [false, nil], check_performed: true).order(created_at: :asc).page(params[:page]).per(100)
      @alts = Alt.where(verified: true, flag: [false, nil], banned_image: [false, nil], check_performed: true).order(created_at: :asc).page(params[:page]).per(100)
    end
  end

  # GET /alts/1 or /alts/1.json
  def show
    @fav = AltFavorite.new
    @alt = Alt.find(params[:id])
    if @alt.banned_image == true || @alt.flag == true
      redirect_to alts_path
    else
      @alt_show = Alt.find(params[:id])
      @alt = Alt.find(params[:id])
      authorize @alt
    end
  end

  def verify
    if params[:query].present? 
      query = params[:query].presence
       @alts = Alt.search(query, fields:[:title, :tags, :body], operator: "or")
    else
      @alts = Alt.all
      @alts = @alts.where(verified: [false, nil], flag: [false, nil], banned_image: [false, nil]).sample(1)
      @alt = Alt.new
    end
  end

  # GET /alts/new
  def new
    @alt = Alt.new
    authorize @alt
  end

  # GET /alts/1/edit
  def edit
    @alt = Alt.find(params[:id])
  end

  # POST /alts or /alts.json
  def create
    @alt = Alt.new(alt_params)
    authorize @alt
    respond_to do |format|
      if @alt.save
        @alt.image_derivatives!
        @alt.image_attacher.add_metadata(caption: @alt.title, alt: @alt.body)
        @alt.save
        build_alt_text_versions
        @user = current_user
        image_duplication_check(@alt, @user)
        format.html { redirect_to root_path, alert: "Checking database for duplicates. This could take a while. Check your email for updates. Take this time to browse seven.army and add, edit, or favorite images." }
        format.json { render :show, status: :created, location: @alt }
        format.js
      else
        format.js
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @alt.errors, status: :unprocessable_entity }
      end
    end
  end

  def image_duplication_check(alt, user)
    ImageDupCheckJob.perform_later(alt, user)
  end

  # PATCH/PUT /alts/1 or /alts/1.json
  def update
    authorize @alt
    respond_to do |format|
      if @alt.update(update_alt_params)
          build_alt_text_versions
          format.html { redirect_to alt_url(@alt), notice: "Alt was successfully updated." }
          format.json { render :show, status: :ok, location: @alt }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @alt.errors, status: :unprocessable_entity }
      end
    end
  end

  def flag_alt_image
   # @alt.flag = @alt.flag
    @alt.save
    @flag = Flag.new(user_id: @alt.user_id, alt_id: @alt.id) # add other params here too
    @flag.save
  end

 
  # adds metadata 
  def image_modification_alt
    #if is_duplicate == true
    #  @alt.destroy
    #  return false
   # end
    #img2 = Alt.find_by(id: 10)
    #i2 = Phashion::Image.new(img2.image.url)
    
   # puts "\nImage Dup Test\n"
    #puts i1.duplicate?(i2)
    #if foundDup = true
    @alt.save
    return true
    
  end

  def build_alt_text_versions
    @alt_text = AltText.new(body: @alt.body, user_id: current_user.id, alt_id: @alt.id)
    @alt_text.save
  end

  # DELETE /alts/1 or /alts/1.json
  def destroy
    @alt.destroy
    authorize @alt

    respond_to do |format|
      format.html { redirect_to alts_url, notice: "Alt was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def favorite 
    @alt = Alt.find(params[:id])
    @fav = AltFavorite.create(alt_id: @alt.id, user_id: current_user.id);
  end

  def unfavorite 
    @alt = Alt.find(params[:id])
    @fav = AltFavorite.all.where(alt_id: @alt.id, user_id: current_user.id)
    if !@fav.nil?
      @fav.destroy_all
    end
  end

  private

  # Does Kate still Instagram scrape?

  # def scrape
  #   puts "scraping"
  #   base_url = "https://www.instagram.com"
  #   user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.117 Safari/537.36"

  
  #   url = "#{base_url}/agustd/"
  #   data = URI.open(url, "User-Agent" => user_agent).read
  #   if data.nil? || data == 0
  #     return false
  #   end
  #   matches = data.match(/window._sharedData =(.*);<\/script>/)
  #   shared_data = JSON.parse(matches[1])
  #   #puts data
   
  #   if shared_data["entry_data"]["ProfilePage"].nil? || data == 0
  #     puts "Timed out"
  #     return false
  #   end
  #   sharedData = shared_data["entry_data"]["ProfilePage"][0]
    
    
    
  #   contents = []
  #   edges = sharedData["graphql"]["user"]["edge_owner_to_timeline_media"]["edges"].map { |n| n["node"] }
  #   edges.each do |x| 
  #     post = {}
  #     if x["__typename"] == "GraphImage"
  #       #puts "Height: " + x["dimensions"]["height"].to_s
  #       #puts "Width: " + x["dimensions"]["width"].to_s
  #       #puts "Display Url: " + x["display_url"]
  #       #puts "Alt Text: " + x["accessibility_caption"]
  #       post[:body] = x["accessibility_caption"]
  #       post[:image] = x["display_url"]
  #       post[:title] = ""
  #       post[:original_url] = x["display_url"]
  #       post[:original_source] = x["display_url"]
       
  #       puts "\n\n"
  #       contents.push(post)
  #     elsif x["__typename"] == "GraphSidecar"
  #       side_car = x["edge_sidecar_to_children"]["edges"]
  #       side_car.each do |i| 
  #           n = i["node"]
  #           #puts "Type: " + n["__typename"]
  #           #puts "Height: " + n["dimensions"]["height"].to_s
  #           #puts "Width: " + n["dimensions"]["width"].to_s
  #           #puts "Display Url: " + n["display_url"]
  #           #puts "Alt Text: " + n["accessibility_caption"]
  #           #puts "\n\n"
  #           post[:body] = n["accessibility_caption"]
  #           post[:image] = ""
  #           post[:title] = n["id"]
  #           post[:original_url] = n["display_url"]
  #           post[:original_source] = n["display_url"]
  #           contents.push(post)
  #       end
        
  #       puts "\n\n"
        
  #     end
  #   end
  #    #binding.pry
  #   #puts contents
  #   # store item content to Alt model and attach meta data for content image
  #   i = 0
  #   contents.each do |c|
  #     file = URI.open(c[:original_url])
  #     if i == 20
  #      break
  #     end
     
  #     #a = Alt.where(original_url: c[:original_url]).first_or_create
  #     a = Alt.where(title: c[:title], user_id: 1, body: c[:body], original_url: c[:original_url], original_source: c[:original_source], verified: false).first_or_create

  #     #puts a.title
      
  #     a.image_attacher.assign(file)
     
  #     a.image_derivatives!
  #     a.image_attacher.add_metadata(caption: a.title, alt: a.body)
  #     a.save

      
  #     i += 1
  #   end

  #   return true 
  # end

  

    # Use callbacks to share common setup or constraints between actions.
    def set_alt
      @alt = Alt.find(params[:id])
    end

    # Only allow a list of trusted parameters through.

    def update_alt_params
      params.require(:alt).permit(:check_performed, :image_dup_locate, :duplicate_check, :banned_image, :body, :image, :flag, :title, :original_url, :original_source, :verified, :tag_list, :flag_reason)
    end

    def alt_params
      params.require(:alt).permit(:check_performed, :image_dup_locate, :duplicate_check, :banned_image, :body, :image, :flag, :title, :original_url, :original_source, :verified, :tag_list, :user_id, :flag_reason)
    end
end