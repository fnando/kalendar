$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require "bundler/setup"
require "rack/test"
require "minitest/utils"
require "minitest/autorun"
require_relative "support/dummy"
require "ostruct"
