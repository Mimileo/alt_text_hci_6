require_relative "boot"

require "rails/all"
require 'phashion'


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AltTextHci6
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.

    config.load_defaults 7.0

    config.action_view.form_with_generates_remote_forms
    config.active_storage.variant_processor = :vips
    config.action_view.image_loading = "lazy"
    config.active_job.queue_adapter = :sidekiq

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = "Pacific Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.active_job.queue_adapter = :sidekiq
  end
end
