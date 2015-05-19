require 'httparty'
require 'corespring/api_client'
require 'corespring/player_options'
require 'corespring/player_token'

module CoreSpring
  include HTTParty
  self.base_uri 'https://platform.corespring.org'
end
