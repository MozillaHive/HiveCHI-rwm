class UserMailer < ApplicationMailer
	def verification_email url,ruser
		@ruser = ruser
		puts "Hi"
		@link = url
		mail(to: @ruser['email'], subject: 'Please Verify Your Ride W/ Me Email')
	end
end
