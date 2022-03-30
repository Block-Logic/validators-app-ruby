# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "validators_app_ruby"
require "dotenv/load"
require "minitest/autorun"
require "webmock/minitest"
require "minitest-vcr"

VCR.configure do |c|
  c.cassette_library_dir = "test/cassettes"
  c.hook_into :webmock
  c.filter_sensitive_data("<API_TOKEN>") { ENV["API_TOKEN"] }
end
