require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.enable_reloading = false

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both threaded web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  # Ensures that a master key has been made available in ENV["RAILS_MASTER_KEY"]
  config.require_master_key = false

  # Enable serving static files - required for Railway
  config.public_file_server.enabled = true

  # Compress CSS using a preprocessor.
  # config.assets.css_compressor = :sass

  # Do not fall back to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.asset_host = "http://assets.example.com"

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for Apache
  # config.action_dispatch.x_sendfile_header = "X-Accel-Redirect" # for NGINX

  # Mount Action Cable outside main process or domain.
  config.action_cable.mount_path = nil
  config.action_cable.url = "wss://#{ENV['RAILWAY_STATIC_URL']}/cable"
  config.action_cable.allowed_request_origins = [
    "https://#{ENV['RAILWAY_STATIC_URL']}",
    "http://#{ENV['RAILWAY_STATIC_URL']}",
    /https:\/\/.*\.railway\.app/,
    /http:\/\/.*\.railway\.app/
  ]

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  config.force_ssl = true

  # Log to STDOUT by default
  config.logger = ActiveSupport::Logger.new(STDOUT)
    .tap  { |logger| logger.formatter = ::Logger::Formatter.new }
    .then { |logger| ActiveSupport::TaggedLogging.new(logger) }

  # Prepend all log lines with the following tags.
  config.log_tags = [ :request_id ]

  # Set to debug to see more detailed logs
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "debug")

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  config.action_mailer.perform_caching = false

  # Enable locale fallbacks for I18n
  config.i18n.fallbacks = true

  # Allow requests from Railway domains
  config.hosts << ".railway.app"
  config.hosts << ENV["RAILWAY_STATIC_URL"] if ENV["RAILWAY_STATIC_URL"].present?

  # Create directory for downloads in production
  FileUtils.mkdir_p(Rails.root.join('public', 'downloads')) unless File.directory?(Rails.root.join('public', 'downloads'))
end
