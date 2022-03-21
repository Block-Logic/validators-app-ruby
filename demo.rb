# frozen_string_literal: true

require_relative "lib/solana_validators_client"

client = SolanaValidatorsClient.new("token")

puts client.getting_ping
