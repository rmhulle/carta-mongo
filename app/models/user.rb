class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable

  field :name,               type: String, default: ""
  field :email,              type: String, default: ""
  field :role,               type: String, default: "Visualizador"


  field :encrypted_password, type: String, default: ""
  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  rails_admin do

      navigation_label 'Administração'

      list do
        exclude_fields :_id,
                        :created_at,
                        :updated_at,
                        :sign_in_count,
                        :current_sign_in_at,
                        :last_sign_in_at,
                        :current_sign_in_ip,
                        :last_sign_in_ip,
                        :remember_created_at,
                        :reset_password_sent_at
      end

      edit do
        exclude_fields  :created_at,
                        :updated_at,
                        :sign_in_count,
                        :current_sign_in_at,
                        :last_sign_in_at,
                        :current_sign_in_ip,
                        :last_sign_in_ip,
                        :remember_created_at,
                        :reset_password_sent_at
      end

      show do
        exclude_fields :id, :created_at, :updated_at,:remember_created_at,:last_sign_in_ip
      end
      # object_label_method do
      #   :custom_label_method
      # end
    end
    def role_enum
      ['Administrador', 'Editor' ,'Visualizador' ,'Banido']
    end
    # def custom_label_method
    #     "#{self.year}"
    # end

end
