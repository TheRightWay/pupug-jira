class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  acts_as_paranoid column: :active, sentinel_value: true

  has_many :access_grants,
           class_name: 'Doorkeeper::AccessGrant',
           foreign_key: :resource_owner_id,
           dependent: :delete_all # or :destroy if you need callbacks

  has_many :access_tokens,
           class_name: 'Doorkeeper::AccessToken',
           foreign_key: :resource_owner_id,
           dependent: :delete_all # or :destroy if you need callbacks

  enum role: {
    admin: 'admin',
    analytic: 'analytic',
    manager: 'manager',
    developer: 'developer'
  }


  def paranoia_restore_attributes
    {
      disabled_at: nil,
      active: true
    }
  end

  def paranoia_destroy_attributes
    {
      disabled_at: current_time_from_proper_timezone,
      active: false
    }
  end
  # after_create do
  #   account = self
  #
  #   # ----------------------------- produce event -----------------------
  #   event = {
  #     event_name: 'AccountCreated',
  #     data: {
  #       public_id: account.public_id,
  #       email: account.email,
  #       full_name: account.full_name,
  #       position: account.position
  #     }
  #   }
  #   Producer.call(event.to_json, topic: 'accounts-stream')
  #   # --------------------------------------------------------------------
  # end
end
