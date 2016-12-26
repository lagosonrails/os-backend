RSpec.configure do |config|
  config.before(:suite) do
    # truncation is important when using capybara drivers that run web server in a different thread, such as poltergeist
    # so the tests and the server share the same db state
    # there is a demon issue with appointments not getting cleared with the transaction strategy. These seeds have had
    # issues (changed tests may cause passing seeds): 24896* 12753* 56157*
    DatabaseCleaner.clean_with :truncation, { pre_count: true, reset_ids: false }
    DatabaseCleaner.strategy = :transaction
  end

  config.prepend_before(:each) do
    DatabaseCleaner.start
  end

  config.append_after(:each) do
    retries = 3
    begin
      DatabaseCleaner.clean
    rescue ActiveRecord::StatementInvalid, PG::TRDeadlockDetected
      if retries > 0
        retries -= 1
        sleep 1
        retry
      end
    end

    FileUtils.rm_rf(Dir["#{Rails.root}/public/uploads/test"])
  end

  config.around(:each, type: :feature) do |example|
    current_strategy = DatabaseCleaner.connections.first.strategy
    DatabaseCleaner.strategy = :truncation, { pre_count: true, reset_ids: false }
    example.run_with_retry retry: 2
    DatabaseCleaner.strategy = current_strategy
  end

  config.around(:each, truncate: true) do |example|
    current_strategy = DatabaseCleaner.connections.first.strategy
    DatabaseCleaner.strategy = :truncation, { pre_count: true, reset_ids: false }
    example.run
    DatabaseCleaner.strategy = current_strategy
  end
end
