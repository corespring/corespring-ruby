module CoreSpring
  class Score < APIModel
    def initialize(attrs={})
      # TODO this logic is duplicated in item_session
      self.components = {}
      (attrs.delete('components') || {}).each do |key, value|
        self.components[underscore(key)] = Component.new(value)
      end

      super(attrs['summary'])
    end

    attr_accessor :max_points, :points, :percentage, :components
  end
end
