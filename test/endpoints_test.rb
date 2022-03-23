# frozen_string_literal: true

require "test_helper"

class EndpointsTest < Minitest::Test
  def test_custom_method_with_get_returns_correct_json
    expected_response = { "answer": "pong" }
    client = SolanaValidatorsClient.new(ENV["API_TOKEN"], "https://stage.validators.app/api/v1")

    VCR.use_cassette "get_ping" do
      resp = client.get_ping
      assert_equal expected_response, JSON.parse(resp.body).transform_keys(&:to_sym)
    end
  end
end
