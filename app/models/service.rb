class Service
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :description, type: String
  field :requirement, type: String
  field :service_type, type: String
  field :incremental_id, type: Integer


  has_many :offers
  before_create :set_id

  rails_admin do
    navigation_label 'Serviços e Ofertas'

      list do
        exclude_fields :_id, :requirement, :incremental_id
      end

      edit do
        exclude_fields :created_at, :updated_at, :offers, :incremental_id
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

    def set_id
        actual = Incremental.where(name: "services").first
        new_value = actual.value + 1
        actual.update_attribute(:value, new_value)
        self.incremental_id = new_value
    end





end
