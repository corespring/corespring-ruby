module CoreSpring
  class PriorUse < APIModel
    def initialize(attrs={})
      self.primary_subject = PrimarySubject.new(attrs.delete('primarySubject'))
      super
    end

    attr_accessor :contributor_name, :credentials, :grade_level, :source_url, :reviews_passed, :use, 
                  :prior_use_other, :p_value, :primary_subject 
  end
end
