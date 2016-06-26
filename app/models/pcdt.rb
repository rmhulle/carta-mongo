class Pcdt
  include Mongoid::Document
  include Mongoid::Timestamps

  field :clinical_situation, type: String
  field :ministerial_order, type: String
  field :order_url, type: String
  field :order_date, type: String
  field :incremental_id, type: Integer
  field :visible, type: Boolean, default: false

  before_create :set_id

  has_and_belongs_to_many :medicines

  rails_admin do

      navigation_label 'Farmácia'

      list do
        field :clinical_situation
        field :ministerial_order
        field :order_date
        field :medicines
        field :visible, :toggle

      end

      edit do
        field :clinical_situation, :string
        field :ministerial_order, :string
        field :order_url, :string
        field :order_date
        field :medicines
        field :visible
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
