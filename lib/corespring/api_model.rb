module CoreSpring
  class APIModel
    def initialize(attrs={})
      attrs.each do |key, value|
       self.send("#{underscore(key)}=", value) 
      end
    end

    private
      def underscore(string)
        string.to_s.gsub(/([a-z])([A-Z])/, '\1_\2').downcase.to_sym
      end
  end
end
