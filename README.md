# ValidatorsAppRuby

This gem helps to utilize the validators.app API. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'validators_app_ruby'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install validators-app-ruby

## Usage

Please note that in order to use this client, you need to obtain the api token from https://validators.app.

Full api documentation is available on https://www.validators.app/api-documentation.

If you want to use any of the api method just create a new ValidatorsAppRuby object providing your api token as follows:

```ruby
client = ValidatorsAppRuby.new(token: "your_api_token")
```

then you can use any endpoint as follows:

```ruby
client.<post || get>_<endpoint_path>(params)
```

Example:

```ruby
client = ValidatorsAppRuby.new(token: "your_api_token")
response = client.get_validators(network: "testnet", order: "score")
response.body # response in json format
response.parsed_response # response as a ruby hash

# returns a list of validators from testnet ordered by score
```

## List of available endpoints:

```ruby
client = ValidatorsAppRuby.new(token: "your_api_token")

# Server ping
# The ping endpoint will allow you to test your connection to the server.

client.get_ping


# Validators List
# The Validators endpoint will return a list of validators for the requested network. 

client.get_validators(
    network: "mainnet",
    order: "score",
    limit: 100,
    page: 1,
    q: "Block Logic"
)


# Validator Detail
# The Validators endpoint will return a single validator for the requested network and account.

client.get_validators(
    network: "mainnet",
    id: "DDnAqxJVFo2GVTujibHt5cjevHMSE9bo8HJaydHoshdp",
    with_history: true
)


# Validator Block Production History
# The Validator Block History endpoint will return a history of block production stats for the requested network and account.

client.get_validator_block_history(network: "testnet", id: "DDnAqxJVFo2GVTujibHt5cjevHMSE9bo8HJaydHoshdp")


# Epoch Index
# The Epoch endpoint will return all epoch data.

client.get_epochs(network: "testnet", per: 10, page: 2)


# Commission Change Index
# The Commission Change endpoint will return all the changes in commission for a given period of time.

client.get_commission_changes(
    network: "mainnet",
    date_from: DateTime.now - 30.days,
    date_to: DateTime.now,
    per: 100,
    page: 1,
    query: "Block Logic"
)


# Stake Pools
# The Stake Pools endpoint will return all the stake pools.

client.get_stake_pools(network: "testnet")


# Stake Accounts
# The Stake Accounts endpoint will return all the stake accounts grouped by vote accounts.

client.get_stake_accounts(
    network: "testnet",
    filter_account: "example",
    sort_by: "epoch_desc",
    per: 10,
    page: 1
)


# Ping Thing Post
# The Ping Thing Post endpoint allows you to push information about transaction times.

client.post_ping_thing(
    network: "testnet",
    application: "cli",
    commitment_level: "finished",
    signature: "tested_signature",
    reported_at: DateTime.now,
    success: true,
    time: 123,
    transaction_type: "transfer"
)


# Ping Thing Post Batch
# The Ping Thing Batch endpoint allows you to push multiple transaction informations at once.

client.post_ping_thing_batch(
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


# Ping Thing List
# This Ping Thing List endpoint will return a list of pings for the requested network.

client.get_ping_thing(network: "testnet", limit: 100, page: 1)


# Sol Prices
# The Sol Prices endpoind will return prices gathered from multiple exchanges.

client.get_sol_prices(
    from: DateTime.now - 30.days,
    to: DateTime.now,
    exchange: "coin_gecko"
)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Block-Logic/validators-app-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/Block-Logic/validators-app-ruby/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the validators-app-ruby project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/Block-Logic/validators-app-ruby/blob/master/CODE_OF_CONDUCT.md).
