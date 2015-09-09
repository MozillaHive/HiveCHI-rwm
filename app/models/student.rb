class Student < ActiveRecord::Base
  has_one :user, as: :role, dependent: :destroy
  accepts_nested_attributes_for :user
  belongs_to :school

  validates :username, presence: true, uniqueness: true
  validates :school_id, presence: true

end
