class Requirement
  include Mongoid::Document
  field :url, type: String
  field :requirement_type, type: String
  field :first_time, type: String
  field :monitoring, type: String
  field :cid10, type: String
  field :incremental_id, type: Integer

  before_create :set_id
  belongs_to :medicine, dependent: :destroy

  rails_admin do

      navigation_label 'Farmácia'

      list do
        exclude_fields :_id, :created_at, :updated_at, :incremental_id
      end

      edit do
        exclude_fields :created_at, :updated_at, :incremental_id
      end

      show do
        exclude_fields :id, :created_at, :updated_at, :incremental_id
      end
      # object_label_method do
      #   :custom_label_method
      # end

    end
    def set_id
        actual = Incremental.where(name: "requirements").first
        new_value = actual.value + 1
        actual.update_attribute(:value, new_value)
        self.incremental_id = new_value
    end
end
