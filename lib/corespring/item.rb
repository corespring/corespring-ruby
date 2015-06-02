module CoreSpring
  class Item < APIModel
    attr_accessor :id, :author, :title, :primary_subject, :related_subject, :copyright_owner, :credentials, :grade_level, 
                  :item_type, :standards, :key_skills, :blooms_taxonomy, :prior_use
  end
end
