require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module VendeloApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    
    # available_locales: son los idiomas que vamos a tener disponibles en nuestra aplicación.
    config.i18n.available_locales = [:es, :en]
    # default_locale: es el idioma por defecto que tendrá nuestra aplicación.
    config.i18n.default_locale = :es
  end
end
