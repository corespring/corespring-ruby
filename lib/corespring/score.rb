module CoreSpring
  class Score < APIModel
    attr_accessor :max_points, :points, :percentage, :components

    def initialize(attrs={})
      # TODO this logic is duplicated in item_session
      self.components = {}
      (attrs.delete('components') || {}).each do |key, value|
        self.components[underscore(key)] = Component.new(value)
      end

      super(attrs['summary'])
    end
  end
end
