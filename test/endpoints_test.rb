# frozen_string_literal: true

require "test_helper"

class EndpointsTest < Minitest::Test
  def setup
    @stage_url = "https://stage.validators.app/api/v1"
    @testnet_network = "testnet"
    @mainnet_network = "mainnet"
    @account = "DDnAqxJVFo2GVTujibHt5cjevHMSE9bo8HJaydHoshdp" # BlockLogic
    @client = SolanaValidatorsClient.new(token: ENV["API_TOKEN"], url: @stage_url)
  end

  def test_get_ping_returns_correct_json
    expected_response = { "answer": "pong" }.to_json
    

    VCR.use_cassette "get_ping" do
      resp = @client.get_ping
      assert_equal expected_response, resp.body
    end
  end

  def test_get_validators_returns_correct_json
    VCR.use_cassette "get_validators" do
      resp = @client.get_validators(network: @testnet_network)
      response = JSON.parse(resp.body)

      assert_equal 200, resp.code
      assert_equal 4322, response.count
    end
  end

  def test_get_validators_with_optional_params_returns_correct_json
    VCR.use_cassette "get_validators_w_params" do
      resp = @client.get_validators(network: @testnet_network, limit: 5, page: 2, order: "name")
      response = JSON.parse(resp.body)

      assert_equal 200, resp.code
      assert_equal 5, response.count
    end
  end

  def test_get_validator_returns_correct_json
    VCR.use_cassette "get_validator" do
      resp = @client.get_validators(network: @mainnet_network, id: @account)
      response = JSON.parse(resp.body)

      assert_equal 200, resp.code
      assert_equal @account, response["account"]
    end
  end

  def test_get_validator_block_history_returns_correct_json
    

    VCR.use_cassette "get_validator_block_history" do
      resp = @client.get_validator_block_history(network: @mainnet_network, id: @account)
      response = JSON.parse(resp.body)

      assert_equal 200, resp.code
      assert_equal 9999, response.count
      assert_equal 334, response.last["blocks_produced"]
    end
  end

  def test_get_validator_block_history_with_limit_returns_correct_json
    VCR.use_cassette "get_validator_block_history_with_limit" do
      resp = @client.get_validator_block_history(
        network: @mainnet_network,
        id: @account,
        limit: 100
      )
      response = JSON.parse(resp.body)

      assert_equal 200, resp.code
      assert_equal 100, response.count
    end
  end

  def test_get_epochs_returns_correct_json
    VCR.use_cassette "get_epochs" do
      resp = @client.get_epochs(network: @testnet_network)
      response = JSON.parse(resp.body)

      assert_equal 200, resp.code
      assert_equal 104, response["epochs_count"]
    end
  end

  def test_get_commission_changes_returns_correct_json
    VCR.use_cassette "get_commission_changes" do
      resp = @client.get_commission_changes(network: @testnet_network)
      response = JSON.parse(resp.body)

      assert_equal 200, resp.code
      assert_equal 25, response["commission_histories"].count
      assert_nil response["commission_histories"][0]["commission_before"]
      assert_equal 100, response["commission_histories"][0]["commission_after"]
    end
  end

  def test_get_commission_changes_with_params_returns_correct_json
    VCR.use_cassette "get_commission_changes_with_params" do
      resp = @client.get_commission_changes(
        network: @testnet_network,
        per: 5,
        page: 2
      )
      response = JSON.parse(resp.body)

      assert_equal 200, resp.code
      assert_equal 5, response["commission_histories"].count
    end
  end

  def test_get_stake_pools_returns_correct_json
    VCR.use_cassette "get_stake_pools" do
      resp = @client.get_stake_pools(
        network: @testnet_network,
        per: 5,
        page: 1
      )
      response = JSON.parse(resp.body)

      assert_equal 200, resp.code
      assert_equal 1, response["stake_pools"].count
    end
  end

  def test_get_stake_accounts_returns_correct_json
    VCR.use_cassette "get_stake_accounts" do
      resp = @client.get_stake_accounts(
        network: @testnet_network,
        per: 5,
        page: 2
      )
      response = JSON.parse(resp.body)

      assert_equal 200, resp.code
      assert_equal 5, response["stake_accounts"].count
    end
  end

  def test_post_ping_thing_returns_correct_json
    expected_response = {"status": "created"}.to_json

    VCR.use_cassette "post_ping_thing" do
      resp = @client.post_ping_thing(
        network: @testnet_network,
        application: "cli",
        commitment_level: "finished",
        signature: "tested_signature",
        reported_at: DateTime.now,
        success: true,
        time: 123,
        transaction_type: "transfer"
      )

      assert_equal 201, resp.code
      assert_equal expected_response, resp.body
    end
  end

  def test_post_ping_thing_batch_returns_correct_json
    expected_response = {"status": "created"}.to_json

    VCR.use_cassette "post_ping_thing_batch" do
      resp = @client.post_ping_thing_batch(
        network: @testnet_network,
        transactions: [
          {
            application: "cli",
            commitment_level: "finished",
            signature: "tested_signature",
            reported_at: DateTime.now,
            success: true,
            time: 123,
            transaction_type: "transfer"
          }
        ]
      )

      assert_equal 201, resp.code
      assert_equal expected_response, resp.body
    end
  end

  def test_get_ping_thing_returns_correct_json
    VCR.use_cassette "get_ping_thing" do
      resp = @client.get_ping_thing(
        network: @testnet_network,
        limit: 5
      )
      response = JSON.parse(resp.body)

      assert_equal 200, resp.code
      assert_equal 5, response.count
    end
  end

  def test_get_sol_prices_returns_correct_json
    exchange = "coin_gecko"
    VCR.use_cassette "get_sol_prices" do
      resp = @client.get_sol_prices(
        exchange: exchange
      )
      response = JSON.parse(resp.body)

      assert_equal 200, resp.code
      assert_equal 29, response.count
      assert_equal [exchange], response.map{ |p| p["exchange"] }.uniq
    end
  end
end
