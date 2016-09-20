require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ScaleAnnotateDemo
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.assets.paths << Rails.root.join("vendor","assets","bower_components")
    config.assets.paths << Rails.root.join("vendor","assets","bower_components","bootstrap-sass-official","assets","fonts")
    config.assets.precompile << %r(.*.(?:eot|svg|ttf|woff|woff2)$)

    if Rails.application.secrets.s3_bucket
      config.paperclip_defaults = {
        storage: :s3,
        s3_credentials: {
          bucket: Rails.application.secrets.s3_bucket,
          access_key_id: Rails.application.secrets.s3_access_key_id,
          secret_access_key: Rails.application.secrets.s3_secret_access_key,
          s3_region: Rails.application.secrets.s3_region,
        }
      }
    end

  end
end
