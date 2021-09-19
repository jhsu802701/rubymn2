require 'simplecov'
SimpleCov.start :rails do
  add_filter '/test/'
  add_filter '/tmp/'
  add_filter '/app/controllers/admins/omniauth_callbacks_controller.rb'
  add_filter '/app/controllers/users/omniauth_callbacks_controller.rb'
  add_filter '/app/channels/application_cable/channel.rb'
  add_filter '/app/channels/application_cable/connection.rb'
  add_filter '/app/jobs/application_job.rb'
  add_filter '/app/mailers/application_mailer.rb'
end

if ENV['CI'] == 'true'
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

require File.expand_path('../config/environment', __dir__)
require 'rails/test_help'
require File.expand_path('../test/setup_objects.rb', __dir__)

# BEGIN: use minitest-reporters
if ENV['CI'].nil?
  require 'minitest/reporters'
  require 'rake_rerun_reporter'
  Minitest::Reporters.use!

  reporter_options = { color: true, slow_count: 5, verbose: false, rerun_prefix: 'rm -f log/test.log && docker/run bundle exec' }
  Minitest::Reporters.use! [Minitest::Reporters::HtmlReporter.new,
                            Minitest::Reporters::RakeRerunReporter.new(reporter_options)]
end
# END: use minitest-reporters

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

# BEGIN: Capybara setup
require 'capybara/rails'
require 'capybara/email'

# NOTE:
# The ActionDispatch::IntegrationTest class applies to
# integration tests AND controller tests.
class ActionDispatch::IntegrationTest
  # Make app/helpers/application_helper.rb available
  include ApplicationHelper

  # Make the Capybara DSL available
  include Capybara::DSL
  include Capybara::Email::DSL

  # Needed to allow sign_in to work in controller tests
  include Devise::Test::IntegrationHelpers

  # Execute before each integration and controller test
  def setup
    setup_universal
  end

  # Reset sessions and driver after each integration and controller test
  def teardown
    teardown_universal
  end
end
# END: Capybara setup

def teardown_universal
  Capybara.reset_sessions!
  Capybara.use_default_driver
end

# rubocop:disable Metrics/ParameterLists
# rubocop:disable Naming/UncommunicativeMethodParamName
def sign_up_user(name_u, name_l, name_f, e, p1, p2)
  visit root_path
  click_on 'Sign up now!'
  fill_in('Last name', with: name_l)
  fill_in('First name', with: name_f)
  fill_in('Username', with: name_u)
  fill_in('Email', with: e)
  fill_in('Password', with: p1) # not yet changed
  fill_in('Password confirmation', with: p2)
  click_button('Sign up')
end
# rubocop:enable Metrics/ParameterLists
# rubocop:enable Naming/UncommunicativeMethodParamName

def login_user(str_login, str_pwd, status_remember)
  visit root_path
  click_on 'Login'
  fill_in('Login', with: str_login)
  fill_in('Password', with: str_pwd)
  if status_remember == true
    check('Remember me')
  else
    uncheck('Remember me')
  end
  click_button('Log in')
end

# Needed for using Devise tools in testing, such as login_as
include Warden::Test::Helpers

def edit_user_start(user1)
  login_as(user1, scope: :user)
  visit root_path
  click_on 'Edit Settings'
end

def xpath_input_str(str_input)
  str1 = './/input[@value="'
  str2 = str_input
  str3 = '"]'
  output = "#{str1}#{str2}#{str3}"
  output
end

# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/MethodLength
# Assign variables to test fixtures
# To be executed before each test
def setup_universal
  @a1 = admins(:elle_woods)
  @a2 = admins(:vivian_kensington)
  @a3 = admins(:emmett_richmond)
  @a4 = admins(:paulette_bonafonte)
  @a5 = admins(:professor_callahan)
  @a6 = admins(:warner_huntington)

  @u1 = users(:connery)
  @u2 = users(:lazenby)
  @u3 = users(:moore)
  @u4 = users(:dalton)
  @u5 = users(:brosnan)
  @u6 = users(:craig)
  @u7 = users(:blofeld)

  @u8 = users(:bandit)
  @u9 = users(:snowman)
  @u10 = users(:frog)
  @u11 = users(:justice)
  @u12 = users(:junior)
  @u13 = users(:needham)

  @r1 = relationships(:relationship1)
  @r2 = relationships(:relationship2)
  @r3 = relationships(:relationship3)
  @r4 = relationships(:relationship4)
  @r5 = relationships(:relationship5)
  @r6 = relationships(:relationship6)
  @r7 = relationships(:relationship7)
  @r8 = relationships(:relationship8)
  @r9 = relationships(:relationship9)
  @r10 = relationships(:relationship10)
  @r11 = relationships(:relationship11)
  @r12 = relationships(:relationship12)
  @r13 = relationships(:relationship13)

  @sponsor1 = sponsors(:blessed_buy)
  @sponsor2 = sponsors(:sky_store)
  @sponsor3 = sponsors(:island_hoppers)
  @sponsor4 = sponsors(:flag)

  add_user_objects
end
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/MethodLength

def begin_user_password_reset(email1)
  visit root_path
  click_on 'Login'
  click_on 'Forgot your password?'
  fill_in('Email', with: email1)
  click_on 'Send me reset password instructions'
end

# rubocop:disable Metrics/MethodLength
def login_admin(str_login, str_pwd, status_remember)
  visit root_path
  click_on 'Login'
  click_on 'Admin Login'
  fill_in('Login', with: str_login)
  fill_in('Password', with: str_pwd)
  if status_remember == true
    check('Remember me')
  else
    uncheck('Remember me')
  end
  click_button('Log in')
end
# rubocop:enable Metrics/MethodLength

def edit_admin_start(admin1)
  login_as(admin1, scope: :admin)
  visit root_path
  click_on 'Edit Settings'
end

def begin_admin_password_reset(email1)
  visit root_path
  click_on 'Login'
  click_on 'Admin Login'
  click_on 'Forgot your password?'
  fill_in('Email', with: email1)
  click_on 'Send me reset password instructions'
end
