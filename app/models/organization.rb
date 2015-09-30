class Organization < ActiveRecord::Base
  has_many :events
  has_many :service_providers
end
