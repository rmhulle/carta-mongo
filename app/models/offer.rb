class Offer

include Mongoid::Document
include Mongoid::Timestamps


  field :contact, type: String
  field :requirement, type: String
  field :avaiableHour, type: String
  field :avaiableDay, type: String
  field :incremental_id, type: Integer
  field :visible, type: Boolean, default: false

  belongs_to :place
  belongs_to :service

  before_create :set_id

  rails_admin do
      navigation_label 'Serviços e Ofertas'

      list do
        field :place
        field :service
        field :contact
        field :visible, :toggle

        # field :requirement
        # field :avaiableHour
        # field :avaiableDay


      end

      edit do
        field :contact, :string
        field :requirement
        field :avaiableHour, :string
        field :avaiableDay, :string
        field :service do
          inline_add false
          inline_edit false
        #  inverse_of :offers
        end
      end

      show do
        exclude_fields :created_at, :updated_at, :incremental_id
      end
      object_label_method do
         :custom_label_method
      end
    end

    def custom_label_method
      result = Service.where(:_id => self.service_id)
      if result.size > 0
        "#{result[0].name}"
      else
        self._id
      end
    end


    def set_id
        actual = Incremental.where(name: "offers").first
        new_value = actual.value + 1
        actual.update_attribute(:value, new_value)
        self.incremental_id = new_value
    end



end
