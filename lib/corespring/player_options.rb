module CoreSpring
  class PlayerOptions < Struct.new(:item_id, :session_id, :expires, :mode, :secure)
    def initialize(options={})
      super

      # TODO DRY this up
      self.mode = options[:mode] || 'view'
      self.expires = options[:expires] || 0
      self.secure = options[:secure] || false
      self.item_id = options[:item_id] 
      self.session_id = options[:session_id] || '*'
    end

    def player_json
      self.item_id = '*' if !item_id && session_id == '*'
      JSON.dump({mode: mode, itemId: item_id, sessionId: session_id, expires: expires, secure: secure}.reject {|k, v| v.nil?})
    end
  end
end
