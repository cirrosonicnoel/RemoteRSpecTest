require "rubygems"
require "bundler/setup"

require "rspec"
# require "capybara/rspec"
# require "capybara/mechanize"
# require "steak"

require "remote_http_testing"

require 'pry'
require 'ap'

require 'net-http-spy'
Net::HTTP.http_logger_options = {:verbose => true}

# Add the 'spec' path in the load path
spec_dir = File.dirname(__FILE__)
$LOAD_PATH.unshift(spec_dir)

# Require all ruby files in the 'support' folder
Dir[File.join(spec_dir, "support/**/*.rb")].each {|f| require f}

module RemoteHttpTesting
  def server
    "http://events.dev"
  end

  def response
    last_response
  end

  def headers(value={})
    self.headers_for_request = value
  end

  # For debug
  # alias_method :old_create_request, :create_request
  # def create_request(url, http_method, params = {}, request_body = nil)
  #   request = old_create_request(url, http_method, params, request_body)
  #   binding.pry
  #   request
  # end

end

module Net
  class HTTPResponse
    def status
      self.code.to_i
    end
  end
end

# RSpec config here
RSpec.configure do |config|

  # Use color in STDOUT
  config.color_enabled = true

  # Use color not only in STDOUT but also in pagers and files
  #config.tty = true

  # Use the specified formatter
  config.formatter = :documentation # :progress, :html, :textmate

  # # Capybara config here
  # Capybara.configure do |capybara|
  #   # Don't run a rack app
  #   capybara.run_server = false

  #   # Define your app host here
  #   capybara.app_host = "http://events.dev"

  #   # I'm using the mechanize driver but your free to use your favorite one (env-js, selenium, ...)
  #   capybara.default_driver = :mechanize
  # end

  # # Don't forget to tell to RSpec to include Capybara :)
  
  config.include RemoteHttpTesting
end


def md5(value)
  Digest::MD5.hexdigest(value)
end