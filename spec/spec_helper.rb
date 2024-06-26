require 'capybara/rspec'
require 'devise'

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  Capybara.configure do |capybara_config|
    capybara_config.default_driver = :selenium
  end
end
