# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "solana_validators_client"

require "minitest/autorun"
require 'webmock/minitest'
