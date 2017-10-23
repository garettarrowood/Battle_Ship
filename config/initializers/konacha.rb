# frozen_string_literal: true

if defined?(Konacha)
  Konacha.configure do |config|
    config.spec_dir     = 'spec/javascripts'
    config.spec_matcher = /_spec\.|_test\./
    config.stylesheets  = %w[application]
    config.driver       = :selenium
  end
end
