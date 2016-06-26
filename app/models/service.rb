class Service
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :description, type: String
  field :requirement, type: String
  field :incremental_id, type: Integer
  field :visible, type: Boolean, default: false


  has_many :offers
  before_create :set_id

  rails_admin do
    navigation_label 'Serviços e Ofertas'

      list do
        field :name
        field :visible, :toggle do
          column_width 100
        end
      end

      edit do
        field :name, :string
        field :description
        field :requirement
        field :visible
      end

      show do
        field :name, :string
        field :description
        field :requirement
        field :offers
        field :visible
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
