class Service
  include Mongoid::Document

  field :name, type: String
  field :description, type: String
  field :requirement, type: String

  has_many :offers

  rails_admin do
    navigation_label 'Serviços e Ofertas'

      list do
        exclude_fields :_id, :requirement
      end

      edit do
        exclude_fields :created_at, :updated_at, :offers
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
