module CoreSpring
  class ItemSession < APIModel
    def initialize(attrs={})
      self.components = {}
      (attrs.delete('components') || {}).each do |key, value|
        self.components[underscore(key)] = Component.new(value)
      end

      super
    end

    attr_accessor :id, :item_id, :components
  end
end
