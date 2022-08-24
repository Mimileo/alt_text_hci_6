class ImageDupCheckJob < ApplicationJob
  require 'sidekiq/api'
  queue_as :default
  sidekiq_options retry: 2

  def perform(alt, user)
    alt.is_duplicate(user)
  end

end
