class ImageDupCheckJob < ApplicationJob
  require 'sidekiq/api'
  queue_as :urgent

  def perform(alt)
    alt.is_duplicate
  end
end
