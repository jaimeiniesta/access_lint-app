require File.expand_path("../boot", __FILE__)

require "rails/all"

Bundler.require(:default, :assets, Rails.env)

module AccessLintHosted
  class Application < Rails::Application
    config.autoload_paths << Rails.root.join("lib")
  end
end
