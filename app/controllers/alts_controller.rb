
require 'phashion'

class AltsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_alt, only: %i[ edit update destroy ]
  helper_method :scrape

  
  # GET /alts or /alts.json
  def index
    search = params[:query].present? ? params[:query] : nil
    @alts = Alt.search(search)
  
      
    @alt = Alt.new
  
    #@alts = Alt.search(params[:query])
    #@alts = Alt.all
    #@alt = Alt.new
  end


  # GET /alts/1 or /alts/1.json
  def show
    @alt_show = Alt.find(params[:id])
    @alt = Alt.find(params[:id])
  end

  # GET /alts/new
  def new
    @alt = Alt.new
  end

  # GET /alts/1/edit
  def edit
  end

  # POST /alts or /alts.json
  def create
    @alt = Alt.new(alt_params)

    respond_to do |format|
      if @alt.save
        if image_modification_alt == false
          format.js
          format.html { render :new, status: :unprocessable_entity }
          flash[:alert] = "The image was a duplicate. Please upload another image" 
        else
          build_alt_text_versions
          format.js
          format.html { redirect_to alt_url(@alt), notice: "Alt was successfully created." }
          format.json { render :show, status: :created, location: @alt }
        end
      else
        format.js
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @alt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alts/1 or /alts/1.json
  def update
    respond_to do |format|
      if @alt.update(alt_params)
        if image_modification_alt == false
          format.js
          format.html { render :new, status: :unprocessable_entity }
          flash[:alert] = "The image was a duplicate. Please upload another image" 
        else
          build_alt_text_versions
          format.html { redirect_to alt_url(@alt), notice: "Alt was successfully updated." }
          format.json { render :show, status: :ok, location: @alt }
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @alt.errors, status: :unprocessable_entity }
      end
    end
  end


  def is_duplicate
    a = Alt.find_by(id: @alt.id)
    img_mod = Phashion::Image.new(a.image.url)

    Alt.all.map { |u| 
       if img_mod.duplicate?(Phashion::Image.new(u.image.url)) == true
          return true  
       end 
    }
    return false
  end
 
  # adds metadata 
  def image_modification_alt
    @alt.image_derivatives!
    @alt.image_attacher.add_metadata(caption: @alt.title, alt: @alt.body)
    
    if is_duplicate == true
      @alt.destroy
      return false
    end
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

    respond_to do |format|
      format.html { redirect_to alts_url, notice: "Alt was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  def scrape
    puts "scraping"
    base_url = "https://www.instagram.com"
    user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.117 Safari/537.36"

  
    url = "#{base_url}/agustd/"
    data = URI.open(url, "User-Agent" => user_agent).read
    if data.nil? || data == 0
      return false
    end
    matches = data.match(/window._sharedData =(.*);<\/script>/)
    shared_data = JSON.parse(matches[1])
    #puts data
   
    if shared_data["entry_data"]["ProfilePage"].nil? || data == 0
      puts "Timed out"
      return false
    end
    sharedData = shared_data["entry_data"]["ProfilePage"][0]
    
    
    
    contents = []
    edges = sharedData["graphql"]["user"]["edge_owner_to_timeline_media"]["edges"].map { |n| n["node"] }
    edges.each do |x| 
      post = {}
      if x["__typename"] == "GraphImage"
        #puts "Height: " + x["dimensions"]["height"].to_s
        #puts "Width: " + x["dimensions"]["width"].to_s
        #puts "Display Url: " + x["display_url"]
        #puts "Alt Text: " + x["accessibility_caption"]
        post[:body] = x["accessibility_caption"]
        post[:image] = x["display_url"]
        post[:title] = ""
        post[:original_url] = x["display_url"]
        post[:original_source] = x["display_url"]
       
        puts "\n\n"
        contents.push(post)
      elsif x["__typename"] == "GraphSidecar"
        side_car = x["edge_sidecar_to_children"]["edges"]
        side_car.each do |i| 
            n = i["node"]
            #puts "Type: " + n["__typename"]
            #puts "Height: " + n["dimensions"]["height"].to_s
            #puts "Width: " + n["dimensions"]["width"].to_s
            #puts "Display Url: " + n["display_url"]
            #puts "Alt Text: " + n["accessibility_caption"]
            #puts "\n\n"
            post[:body] = n["accessibility_caption"]
            post[:image] = ""
            post[:title] = n["id"]
            post[:original_url] = n["display_url"]
            post[:original_source] = n["display_url"]
            contents.push(post)
        end
        
        puts "\n\n"
        
      end
    end
     #binding.pry
    #puts contents
    # store item content to Alt model and attach meta data for content image
    i = 0
    contents.each do |c|
      file = URI.open(c[:original_url])
      if i == 20
       break
      end
     
      #a = Alt.where(original_url: c[:original_url]).first_or_create
      a = Alt.where(title: c[:title], user_id: 1, body: c[:body], original_url: c[:original_url], original_source: c[:original_source]).first_or_create

      #puts a.title
      
      a.image_attacher.assign(file)
     
      a.image_derivatives!
      a.image_attacher.add_metadata(caption: a.title, alt: a.body)
      a.save
      i += 1
    end

    return true
  
    
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_alt
      @alt = Alt.find(params[:id])
    end

    # Only allow a list of trusted parameters through.

    def alt_params
      params.require(:alt).permit(:body, :image, :title, :original_url, :original_source, :verified, :tag_list, :user_id)
    end
end
