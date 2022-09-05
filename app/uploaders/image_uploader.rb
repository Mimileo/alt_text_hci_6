require "image_processing/mini_magick"

class ImageUploader < Shrine
  plugin :validation_helpers
  plugin :determine_mime_type
	plugin :add_metadata
 
  Attacher.validate do
    validate_max_size 15*1024*1024 # 5 MB 
  end

  Attacher.derivatives do |original|
    validate_mime_type %w[image/jpeg image/png image/webp image/tiff]
    validate_extension %w[jpg jpeg png webp]
    magick = ImageProcessing::MiniMagick.source(original)
 
    { 
      small:    magick.resize_to_fit!(800, 800),
    }
    
  end
end