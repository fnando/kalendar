ENV["RAILS_ENV"] = "test"

require "rails"
require "action_controller/railtie"

Bundler.require :default, :test

module Dummy
  class Application < Rails::Application
    config.eager_load = false
    config.active_support.test_order = :random
    config.secret_key_base = SecureRandom.hex(100)
    config.i18n.load_path += Dir["#{__dir__}/config/locales/**/*.yml"]
  end
end

Dummy::Application.initialize!

Rails.application.routes.draw do
  root to: "site#home"
  get "page", to: "pages#show"
  get "article", to: "pages#article"
end

class ApplicationController < ActionController::Base
  prepend_view_path "#{__dir__}/app/views"
end
