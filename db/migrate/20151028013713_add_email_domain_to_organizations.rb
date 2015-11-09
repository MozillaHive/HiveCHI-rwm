class AddEmailDomainToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :email_domain, :string
  end
end
