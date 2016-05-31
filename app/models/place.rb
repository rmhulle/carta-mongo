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

  has_many :offers

  before_create :set_id

  rails_admin do
      navigation_label 'Unidades'
      list do
        exclude_fields :_id,:created_at, :updated_at, :description, :openDay, :openHour, :address, :services, :incremental_id

      end

      edit do
        exclude_fields :_id,:created_at, :updated_at, :services, :incremental_id
      end

      show do
        exclude_fields :id, :created_at, :updated_at, :incremental_id
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
