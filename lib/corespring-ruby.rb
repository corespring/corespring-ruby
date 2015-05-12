require 'httparty'
require 'corespring/api_client'
require 'corespring/player_options'

module CoreSpring
  include HTTParty
  self.base_uri 'https://platform.corespring.org'
end
