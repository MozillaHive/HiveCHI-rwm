class ServiceProviderDomainValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if record.role_type == "ServiceProvider"
      domain_match = value.match(/@(.+)\z/)
      unless domain_match && Organization.find_by(domain_name: domain_match[1])
        record.errors[attribute] << "does not belong to a registered organization"
      end
    end
  end
end
