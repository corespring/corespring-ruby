require 'httparty'
require 'corespring/api_client'

module CoreSpring
  include HTTParty
  self.base_uri 'https://platform.corespring.org'
end