require 'httparty'
require 'corespring/api_client'

module CoreSpring
  include HTTParty
  self.base_uri 'staging.corespring.org'
end