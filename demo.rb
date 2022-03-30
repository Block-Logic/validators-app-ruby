# frozen_string_literal: true

require_relative "lib/validators_app_ruby"

client = ValidatorsAppRuby.new("token")

puts client.getting_ping
