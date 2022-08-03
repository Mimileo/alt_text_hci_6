class Alt < ApplicationRecord

  include ImageUploader::Attachment(:image)
  #include MeiliSearch::Rails
  searchkick word_middle: [:title, :tags, :body], filterable: [:tags]
  

  acts_as_taggable 
  scope :search_import, -> { includes(:tags) }

  has_rich_text :orginal_url

  belongs_to :user
  has_many :alt_favorites, dependent: :destroy
  has_many :alt_texts
  has_many :verifcations

  # limit what is indexed
  def search_data
  {
    title: title,
    tags: tags.join(" "),
    body: alt_texts.pluck(:body).last,
    verified: verified
 
  }
  end

  def is_duplicate_initiate
    is_duplicate
  end

  def is_duplicate
    require 'phashion'
    file1 = URI.parse(image_url).open
    puts file1.class
   
    img_mod = Phashion::Image.new(file1.path)
    count = 0
    Alt.all.map { |u| 

       if u.image_url != nil
      
         file2 = URI.parse(u.image.url).open
        
        
         if img_mod.duplicate?(Phashion::Image.new(file2.path)) == true
            count = count + 1
             if count == 2
              update(duplicate_check: true)
            else
              update(duplicate_check: false)
            end
         end 
       end
    }
    return false
  end

  def build_alt_text_versions(is_alt_dup)
    @alt_text = alt.new(body: a.body, user_id: current_user.id, alt_id: a.id)
    @alt_text.save
  end



   # attributes that we want to be indexed
  #meilisearch do
  #  attribute :title
  #  attribute :alt_texts do
  #    alt_texts.pluck(:body)
   # end

  #  attribute :tag_list 

   # sortable_attributes [:created_at, :updated_at]
 # end
  
end
