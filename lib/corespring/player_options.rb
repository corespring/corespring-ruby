module CoreSpring
  class PlayerOptions < Struct.new(:item_id, :session_id, :expires, :mode, :secure)
    DEFAULTS = {
      mode: 'view',
      expires: 0,
      secure: false,
      session_id: '*',
      item_id: nil,
    }

    def initialize(options={})
      super
      DEFAULTS.each {|k, v| self[k] = options[k] || v}
    end

    def player_json
      self.item_id = '*' if !item_id && session_id == '*'
      JSON.dump({mode: mode, itemId: item_id, sessionId: session_id, expires: expires, secure: secure}.reject {|k, v| v.nil?})
    end
  end
end
