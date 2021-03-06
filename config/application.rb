require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HobosBlog
  class Application < Rails::Application
    # Hobo: the admin subsite loads admin.css & admin.js
    config.assets.precompile += %w(admin.css admin.js)
    # Hobo: Named routes have changed in Hobo 2.0.   Set to false to emit both the 2.0 and 1.3 names.
    config.hobo.dont_emit_deprecated_routes = true
    # Hobo: the front subsite loads front.css & front.js
    config.assets.precompile += %w(front.css front.js ajax-loader.gif)
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Warsaw'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.fallbacks = [:en]
    config.i18n.default_locale = :pl

    config.pg_tsearch = {
        dictionary: 'polish',
        prefix: true,
        highlight: {
            StartSel: '<mark>',
            StopSel: '</mark>',
            MinWords: 40,
            MaxWords: 60,
            ShortWord: 2,
            FragmentDelimiter: '&hellip;',
            MaxFragments: 2
        }
    }

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.autoload_paths << Rails.root.join('lib')
    config.autoload_paths << Rails.root.join('app/lib')

    config.action_dispatch.rescue_responses.merge!('ActionController::Forbidden' => :forbidden)
  end
end
