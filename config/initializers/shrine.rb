
require "shrine/storage/file_system"

Shrine.plugin :derivatives
Shrine.plugin :activerecord
Shrine.plugin plugin :data_uri


  require "shrine/storage/s3"
  require 'shrine/plugins/url_options'
 
# in vim change aws credential to match bucket, region and access_key_id, and other i.e. remove :aws
if Rails.env == 'production'  
  s3_options = { 
    bucket:            ENV['AWS_BUCKET'], # Rails.application.credentials.dig(:aws, :aws_bucket), # required 
    region:            "us-west-1", # required 
    access_key_id:     ENV['ACCESS_KEY_ID'], # Rails.application.credentials.dig(:aws, :access_key_id),
    secret_access_key:  ENV['SECRET_ACCESS_KEY'], # Rails.application.credentials.dig(:aws, :secret_access_key),           
  }
else
  s3_options = { 
    bucket:            Rails.application.credentials.dig(:aws_bucket), # required 
    region:            "us-west-1", # required 
    access_key_id:     Rails.application.credentials.dig(:access_key_id),
    secret_access_key: Rails.application.credentials.dig(:secret_access_key),           
  }
end

   
  Shrine.storages = { 
    cache: Shrine::Storage::S3.new(prefix: "cache", **s3_options), # temporary 
    store: Shrine::Storage::S3.new(**s3_options),    # permanent  
  }


  Shrine.plugin :activerecord # or :shrine 
  Shrine.plugin :cached_attachment_data # for retaining the cached file across form redisplays 
  Shrine.plugin :restore_cached_data # re-extract metadata when attaching a cached file
  Shrine.plugin :store_dimensions
  # Shrine.plugin :url_options, store: { host: "http://d2mmrchyq2qjf8.cloudfront.net" }

# enable localhost storage
  # Shrine.storages = { 
  #   cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"), # temporary 
  #   store: Shrine::Storage::FileSystem.new("public", prefix: "uploads"),       # permanent 
  # }
   
  # Shrine.plugin :activerecord # or :shrine 
  # Shrine.plugin :cached_attachment_data # for retaining the cached file across form redisplays 
  # Shrine.plugin :restore_cached_data # re-extract metadata when attaching a cached file
  # Shrine.plugin :store_dimensions

