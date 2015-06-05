module CoreSpring
  class Item < APIModel
    attr_accessor :id, :author, :title, :primary_subject, :related_subject, :copyright_owner, :credentials, :grade_level, 
                  :item_type, :standards, :key_skills, :blooms_taxonomy, :prior_use

    def initialize(attrs={})
      self.standards = (attrs.delete('standards') || []).map {|standard| Standard.new(standard)}
      self.primary_subject = PrimarySubject.new(attrs.delete('primarySubject') || {})
      self.prior_use = PriorUse.new(attrs.delete('priorUse') || {})

      super
    end
  end
end
