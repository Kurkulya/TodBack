class List < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy

  validates :label, presence: true
end
