class Offer

include Mongoid::Document


  field :contact, type: String
  field :requirement, type: String
  field :avaiableHour, type: String
  field :avaiableDay, type: String

  belongs_to :place
  belongs_to :service
  

  rails_admin do
      navigation_label 'Serviços e Ofertas'

      list do
        exclude_fields :_id, :requirement, :service
      end

      edit do
        exclude_fields :created_at, :updated_at, :place
        field :service do
          inline_add true
          inline_edit true
        #  inverse_of :offers
        end
      end

      show do
        exclude_fields :created_at, :updated_at
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







end
