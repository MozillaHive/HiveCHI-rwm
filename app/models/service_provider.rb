class ServiceProvider < ActiveRecord::Base
  has_one :user, as: :role, dependent: :destroy
  belongs_to :organization
  accepts_nested_attributes_for :user

  before_validation :populate_organization

  private

  def populate_organization
    domain_match = user.email.match(/@(.+)\z/)
    if domain_match && (organization = Organization.find_by(domain_name: domain_match[1]))
      self.organization = organization
    end
  end
end
