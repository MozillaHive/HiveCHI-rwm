class Organization < ActiveRecord::Base
  validates :name, presence: true
  validates :domain_name, presence: true, uniqueness: true

  has_many :events
  has_many :service_providers
end
