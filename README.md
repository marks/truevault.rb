truevault.rb
============

A super quick Ruby client for [TrueVault](http://truevault.com) ("handles HIPAA compliance so that you don’t have to") powered by [HTTParty](https://github.com/jnunemaker/httparty).

Developed by [@Skram](http://twitter.com/skram) of [Social Health Insights](http://socialhealthinsights.com).

How to use
----------
1. Clone this repository to your computer. Notice that all the code is in `lib/truevault.rb`
2. Set up the following environment variables: `TV_API_KEY` and `TV_ACCOUNT_ID`, `TV_A_VAULT_ID`.
  ```
    cp .env.sample .env
  ```
3. Install required dependencies: `bundle install`
4. Run the example file: `bundle exec ruby example_usage.rb`
5. Profit and then contribute back to an open source project, please.

How to run tests
----------------
1. Follow steps 1 through 3 under 'How to use'
2. `bundle exec rake`

Resources
---------
* [TrueVault REST API Documentation](https://docs.truevault.com/)

To do
-----
* Better error handling
* More tests
* Flush out README.md with details such as
	* Dependency/platforms tested on
	* Info on contributing
