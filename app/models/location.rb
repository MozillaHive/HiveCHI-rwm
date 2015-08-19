class Location < ActiveRecord::Base
	has_and_belongs_to_many :organizations
	has_many :events
	has_and_belongs_to_many :users
	has_many :schools

	def print_full
		res = ""
		if self.name
			res+= "#{self.name}\n"
		end
		res += "#{self.address}\n#{self.city}, #{self.state} #{self.zipcode}"
	end

	def menu_opts(user)
		opts = []
		if self.name
			opts[0] = self.name
		else
			opts[0] = self.address
		end
		return opts
	end


end
