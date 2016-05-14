class Place
  include Mongoid::Document

  field :cnes_id, type: String
  field :name, type: String
  field :description, type: String
  field :address, type: String
  field :owner, type: String
  field :phone, type: String
  field :openHour, type: String
  field :openDay, type: String

  has_many :offers

  rails_admin do
      navigation_label 'Unidades'
      list do
        exclude_fields :_id, :description, :openDay, :openHour, :address, :services

      end

      edit do
        exclude_fields :_id,:created_at, :updated_at, :services
      end

      show do
        exclude_fields :id, :created_at, :updated_at
      end
      # object_label_method do
      #   :custom_label_method
      # end
    end

    # def custom_label_method
    #     "#{self.year}"
    # end





end
