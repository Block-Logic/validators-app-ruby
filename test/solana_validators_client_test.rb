# frozen_string_literal: true

require "test_helper"

class ValidatorsAppRubyTest < Minitest::Test
  def setup
    @network = "testnet"
  end

  def test_that_it_has_a_version_number
    refute_nil ::ValidatorsAppRuby::VERSION
  end

  def test_prepare_path_returns_correct_path
    path = "get_ping"
    prepared_path = ValidatorsAppRuby.new(token: "token").prepare_path(path: path)

    assert_equal "https://validators.app/api/v1/ping", prepared_path
  end

  def test_prepare_path_returns_correct_path_with_network
    path = "get_ping"
    prepared_path = ValidatorsAppRuby.new(token: "token").prepare_path(path: path, network: @network)

    assert_equal "https://validators.app/api/v1/ping/testnet", prepared_path
  end

  def test_validate_network_returns_nil_by_default
    network = ValidatorsAppRuby.new(token: "token").validate_network

    assert_nil network
  end

  def test_validate_network_returns_network_with_correct_data_provided
    network = ValidatorsAppRuby.new(token: "token").validate_network(network: @network)

    assert_equal "testnet", network
  end

  def test_validate_network_raises_error_with_incorrect_data
    assert_raises ArgumentError do
      ValidatorsAppRuby.new(token: "token").validate_network(network: @network + "bad")
    end
  end

  def test_custom_method_with_get_returns_correct_json
    expected_response = { "answer": "pong" }
    client = ValidatorsAppRuby.new(token: "token")
    stub_request(:get, "https://validators.app/api/v1/ping")
      .with(
        headers: {
          "Accept" => "*/*",
          "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
          "Content-Type" => "application/json",
          "Token" => "token",
          "User-Agent" => "Ruby"
        }
      )
      .to_return(status: 200, body: expected_response.to_json, headers: {})

    resp = client.get_ping
    assert_equal expected_response, JSON.parse(resp.body).transform_keys(&:to_sym)
  end

  def test_custom_method_with_post_returns_correct_json
    expected_response = {"status":"ok"}
    client = ValidatorsAppRuby.new(token: "token")
    stub_request(:post, "https://validators.app/api/v1/ping-thing/testnet")
      .with(
        headers: {
          "Accept" => "*/*",
          "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
          "Content-Type" => "application/json",
          "Token" => "token",
          "User-Agent" => "Ruby"
        }
      )
      .to_return(status: 200, body: expected_response.to_json, headers: {})

    resp = client.post_ping_thing(network: @network)
    assert_equal expected_response, JSON.parse(resp.body).transform_keys(&:to_sym)
  end

  def test_wrong_custom_method_produces_correct_error
    client = ValidatorsAppRuby.new(token: "token")

    assert_raises NoMethodError do
      client.getting_ping
    end
  end
end
