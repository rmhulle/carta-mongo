class Medicine

  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  field :owner, type: String
  field :description, type: String
  field :standard, type: Boolean
  field :incremental_id, type: Integer
  field :medical_url, type: String
  field :citzen_url, type: String
  field :visible, type: Boolean, default: false

  has_many :presentations
  # has_many :requirements
  has_and_belongs_to_many :pcdts

  # accepts_nested_attributes_for :pcdts

  before_create :set_id

  rails_admin do

      navigation_label 'Farmácia'

      list do
        field :name
        field :description
        field :presentations
        field :pcdts
        field :visible, :toggle
      end

      edit do
        field :name, :string
        field :owner, :string
        field :description
        field :standard
        field :presentations
        field :pcdts
        field :medical_url, :string
        field :citzen_url, :string

      end

      show do
        field :name
        field :owner
        field :description
        field :standard
        field :presentations
        field :pcdts
        field :medical_url
        field :citzen_url
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
