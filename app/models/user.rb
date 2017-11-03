class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable
          #:omniauthable
  include DeviseTokenAuth::Concerns::User

  has_many :lists, dependent: :destroy

  def list_count
    List.where(user_id: self.id).count
  end
end
