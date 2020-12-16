require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Allow asset lookup in `node_modules`
    config.assets.paths << Rails.root.join('node_modules')

    # Setup host for mailer
    config.action_mailer.default_url_options = {
      host: ENV['RAILS_ENV'] == 'test' ? 'localhost:3000' : ENV['HOST']
    }

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
