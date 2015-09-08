class StudentsController < ApplicationController
  def new
    @student = Student.new
    @student.build_user
  end

  def create
    @student = Student.new(student_params)
    if ENV["DISABLE_REGISTRATIONS"] == "TRUE"
      render 'new'
    elsif @student.save
      session[:user_id] = @student.user.id
      redirect_to users_verify_path
    else
      render 'new'
    end
  end

  private

  def student_params
    params.require(:student).permit(
      :username, :school_id, :address, :nudges_enabled,
      user_attributes: [:id, :email, :phone, :password, :password_confirmation,
      :time_zone])
  end

end
