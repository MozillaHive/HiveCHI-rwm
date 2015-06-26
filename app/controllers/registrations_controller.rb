class RegistrationsController < ApplicationController
	@@plength = 10
	def new
		@schools = School.all
		@ruser = session[:registering_user]
	end

	def checkinput
		tempUser = User.new
		@errors = []
		tempUser.email = params[:email]
		tempUser.username = params[:username]
		tempUser.phone = params[:phone].gsub(/\D/,"")
		pass = params[:password]
		tempUser.password = pass
		passconf = params[:passwordConf]
		tempUser.school_id = params[:school].to_i
		checkEmail(tempUser.email)
		checkUsername(tempUser.username)
		checkPhone(tempUser.phone)
		checkPassword(pass,passconf)
		session[:registering_user] = tempUser
		flash[:reg_errors] = @errors
		if @errors.length > 0
			redirect_to :action => "new", :controller => "registrations"
		else
			session[:registering_user].phone = "+1"+session[:registering_user].phone
			session[:verification_key] = SecureRandom.base64(10)
			client_redirect "/register/tos"
		end
	end

	def tos

	end

	def tos_confirm
		tos_status = params[:tos]
		if tos_status == "agree"
			textKey()
			client_redirect "/register/verify"
			session[:tos] = true
		else
			client_redirect "/login"
		end
	end

	def pending
		if !session[:tos]
			client_redirect "/register/tos"
		elsif params[:ver_code]
			if params[:ver_code] == session[:verification_key]
				u = User.create(session[:registering_user])
				reset_session
				session[:user_id] = u.id
				flash[:notice] = "Welcome to your Ride W/ Me dashboard #{u.username}" 
				client_redirect "/dashboard"
			else
				@error_message = "Invalid Verification Key"
			end
		end
	end

	private
	def checkEmail(email)
		@errors.append "Invalid Email" unless (email =~/.+@.+\..+/) #matches 
		e = User.find_by(email: email)
		@errors.append "Email is already registered" if e
	end

	private
	def checkUsername(username)
		@errors.append "Username is empty" if username.strip.length == 0
		u = User.find_by(username: username)
		@errors.append "Username is taken" if u
	end

	private
	def checkPhone(phone)
		@errors.append "Invalid phone number" unless  /\A\d{10}\Z/ =~ phone
		p = User.find_by(phone: "+1"+phone)
	#	@errors.append "Phone is already registered" if p
	end

	private
	def checkPassword(p,conf)
		@errors.append "Password cannot have leading or trailing whitespace" if p.strip.length < p.length
		@errors.append "Password must be at least #{@@plength} characters" if p.length < @@plength
		@errors.append "Password and Confirmation must match" if p != conf
	end

	private
	def textKey
		account_sid = "ACf08a1e62643f15d3123929d2bd6f1f31"
		auth_token = "51fa5a33400c42f2363dba65cb753a12"
		client = Twilio::REST::Client.new account_sid, auth_token
 
		from = "+12245209278" # Your Twilio number

		client.account.messages.create(
    		:from => from,
    		:to => session[:registering_user]["phone"],
    		:body => "Your RideW/Me verification code is #{session[:verification_key]}"
    		)
  
	end

end
