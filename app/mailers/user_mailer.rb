class UserMailer < ApplicationMailer
	def verification_email ver_key,ruser
		@ruser = ruser
		@ver_key = ver_key
		puts "Hi"
		@link = "http://localhost:3000/register/verify?ver_code="+ver_key
		mail(to: @ruser['email'], subject: 'Please Verify Your Ride W/ Me Email')
	end
end
