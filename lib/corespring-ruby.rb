require 'httparty'
require 'corespring/api_model'
require 'corespring/primary_subject'
require 'corespring/prior_use'
require 'corespring/standard'
require 'corespring/item'
require 'corespring/item_session'
require 'corespring/api_client'
require 'corespring/player_options'
require 'corespring/player_token'

module CoreSpring
  include HTTParty
  self.base_uri 'https://platform.corespring.org'
end
