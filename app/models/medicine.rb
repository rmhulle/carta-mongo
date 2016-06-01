class Medicine

  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  field :owner, type: String
  field :description, type: String
  field :standard, type: Boolean
  field :incremental_id, type: Integer

  has_many :presentations
  has_many :requirements
  has_many :pcdts

  accepts_nested_attributes_for :requirements

  before_create :set_id

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
        actual = Incremental.where(name: "medicines").first
        new_value = actual.value + 1
        actual.update_attribute(:value, new_value)
        self.incremental_id = new_value
    end



end
