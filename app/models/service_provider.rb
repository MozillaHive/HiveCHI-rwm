class ServiceProvider < ActiveRecord::Base
  validates :organization_id, presence: true

  has_one :user, as: :role
  belongs_to :organization
  accepts_nested_attributes_for :user
end
