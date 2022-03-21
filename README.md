# ValidatorsAppRuby

This gem helps to utilize the validators.app API. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'validators-app-ruby'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install validators-app-ruby

## Usage

Please note that in order to use this client, you need to obtain the api token from https://validators.app.

Full api documentation is available on https://www.validators.app/api-documentation.

If you want to use any of the api method just create a new SolanaValidatorsClient object providing your api token as follows:

```ruby
client = SolanaValidatorsClient.new("your_api_token")
```

then you can use any endpoint as follows:

```ruby
client.<post || get>_<endpoint_path>(params)
```

Example:

```ruby
client = SolanaValidatorsClient.new("your_api_token")
client.get_validators(network: "testnet", order: "score")

# returns a list of validators from testnet ordered by score
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
