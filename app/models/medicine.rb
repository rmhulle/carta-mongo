class Medicine

  include Mongoid::Document

  field :name, type: String
  field :salt, type: String
  field :owner, type: String
  field :description, type: String
  field :standard, type: Boolean

  rails_admin do

      navigation_label 'Farmácia'

      list do
        exclude_fields :_id, :created_at, :updated_at
      end

      edit do
        exclude_fields :created_at, :updated_at
      end

      show do
        exclude_fields :id, :created_at, :updated_at
      end
      # object_label_method do
      #   :custom_label_method
      # end

    end


end
