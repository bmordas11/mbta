require File.expand_path('../boot', __FILE__)
require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
ActiveSupport.halt_callback_chains_on_return_false = false

module Mbta
  class Application < Rails::Application
    # Application configuration should go into files in config/initializers

    config.time_zone = 'Eastern Time (US & Canada)'

    # Make public assets requireable in manifest files
    config.assets.paths << Rails.root.join("public", "assets", "stylesheets")
    config.assets.paths << Rails.root.join("public", "assets", "javascripts")

    # config.i18n.default_locale = :de
  end
end
