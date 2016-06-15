class Pcdt
  include Mongoid::Document
  include Mongoid::Timestamps

  field :clinical_situation, type: String
  field :ministerial_order, type: String
  field :order_url, type: String
  field :order_date, type: String
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
      object_label_method do
         :custom_label_method
       end

    end
    def custom_label_method
      "#{self.ministerial_order}"
    end
    def set_id
        actual = Incremental.where(name: "presentations").first
        new_value = actual.value + 1
        actual.update_attribute(:value, new_value)
        self.incremental_id = new_value
    end
end
