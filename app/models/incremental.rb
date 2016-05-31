class Incremental
  include Mongoid::Document
  include Mongoid::Timestamps


  field :name, type: String
  field :value, type: Integer

  rails_admin do

      navigation_label 'Administração'

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
