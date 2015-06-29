module CoreSpring
  class ItemSession < APIModel
    attr_accessor :id, :item_id, :completed, :components, :attempts

    def initialize(attrs={})
      self.components = {}
      (attrs.delete('components') || {}).each do |key, value|
        self.components[underscore(key)] = Component.new(value)
      end

      super
    end


    def as_json
      JSON.generate({completed: self.completed})
    end
  end
end
