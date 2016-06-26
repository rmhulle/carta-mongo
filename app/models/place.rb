class Place
  include Mongoid::Document
  include Mongoid::Timestamps

  field :cnes_id, type: String
  field :name, type: String
  field :description, type: String
  field :address, type: String
  field :owner, type: String
  field :phone, type: String
  field :openHour, type: String
  field :openDay, type: String
  field :incremental_id, type: Integer
  field :visible, type: Boolean, default: false

  has_many :offers

  before_create :set_id

  rails_admin do
      navigation_label 'Unidades'
      list do
        field :cnes_id
        field :name
        field :owner
        field :phone
        field :visible, :toggle
      end

      edit do
        field :cnes_id, :string
        field :name, :string
        field :description
        field :address, :string
        field :owner, :string
        field :phone, :string
        field :openHour, :string
        field :openDay, :string
        field :offers
        field :visible
      end

      show do
        field :cnes_id
        field :name
        field :owner
        field :phone
        field :visible
        field :description
        field :address
        field :openHour
        field :openDay
        field :visible
      end
      # object_label_method do
      #   :custom_label_method
      # end
    end

    # def custom_label_method
    #     "#{self.year}"
    # end

private

def set_id
    actual = Incremental.where(name: "places").first
    new_value = actual.value + 1
    actual.update_attribute(:value, new_value)
    self.incremental_id = new_value
end


end
