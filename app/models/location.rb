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
		opts[1] = self.to_json
		if user.home && self.id == user.home.id
			opts[0] = "My Home"
		elsif self.id == user.school.location.id
			opts[0] = "My School"
		elsif self.name
			opts[0] = self.name
		else
			opts[0] = self.address
		end
		return opts
	end


end
