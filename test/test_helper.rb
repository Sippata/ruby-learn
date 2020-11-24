require 'coveralls'
Coveralls.wear!

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include FactoryBot::Syntax::Methods
  include AuthHelper
end

if ENV['BULLET']
  Bullet.enable = true

  require 'minitest/unit'

  module MiniTestWithBullet
    def before_setup
      Bullet.start_request
      super if defined?(super)
    end

    def after_teardown
      super if defined?(super)

      if Bullet.warnings.present?
        warnings = Bullet.warnings.map { |_k, warning| warning }.flatten.map { |warn| warn.body_with_caller }.join("\n-----\n\n")

        flunk(warnings)
      end

      Bullet.end_request
    end
  end

  class ActiveSupport::TestCase
    include MiniTestWithBullet
  end
end
