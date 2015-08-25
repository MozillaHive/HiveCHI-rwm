class UserMailer < ApplicationMailer
	def verification_email url,ruser
		@ruser = ruser
		@link = url
		mail(to: @ruser['email'], subject: 'Please Verify Your Ride W/ Me Email')
	end

	def password_reset_email(url, user)
		@link = url
		@user = user
		mail(to: @user.email, subject: "Your Ride W/ Me password has been reset")
	end
end
