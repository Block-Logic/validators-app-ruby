# frozen_string_literal: true

require 'httparty'
require_relative "solana_validators_client/version"

class SolanaValidatorsClient
  class Error < StandardError; end
  class InvalidArgumentError < StandardError; end

  include HTTParty

  VALIDATORS_PATH = "https://validators.app/api/v1"
  AVAILABLE_NETWORKS = %w(mainnet testnet).freeze

  def initialize(token, url = VALIDATORS_PATH)
    @token = token
    @url = url
  end

  # EXAMPLE: get_validators(network: "mainnet")
  def method_missing(method, **args)
    network = validate_network(args[:network])
    path = prepare_path(method, network, args[:id])
    params = args.reject{ |a| [:network, :id].include?(a) }

    if method.to_s.start_with?("get_")
      response = self.class.get(path, query: params, headers: headers)
    elsif method.to_s.start_with?("post_")
      response = self.class.post(path, body: params.to_json, headers: headers)
    else
      super
    end

    response_or_error(response)
  end

  def prepare_path(path, network = nil, id = nil)
    [@url, path.to_s.split("_")[1..-1].join("-"), network, id].compact.join("/")
  end

  def validate_network(network = nil)
    return nil unless network

    raise InvalidArgumentError, "Allowed networks are: #{AVAILABLE_NETWORKS.join(', ')}." \
      unless AVAILABLE_NETWORKS.include?(network)

    network
  end

  def headers
    {
      "Content-Type" => "application/json",
      "Token" => @token
    }
  end

  def response_or_error(response)
    if response.code >= 300
      raise ArgumentError, "Request failed with #{response.code}: #{response.message} for #{response.request.last_uri}"
    else
      response
    end
  end
end
