class Organization < ActiveRecord::Base
  validates :name, presence: true

  has_many :events
  has_many :service_providers
end
