class ParentsController < ApplicationController
  def new
    @parent = Parent.new
    @parent.build_user
  end

  def create
    @parent = Parent.new(parent_params)
    if ENV["DISABLE_REGISTRATIONS"] == "TRUE"
      render 'new'
    elsif @parent.save
      session[:user_id] = @parent.user.id
      redirect_to users_verify_path
    else
      @student = Student.new
      @student.build_user
      render 'users/new'
    end
  end

  private

  def parent_params
    params.require(:parent).permit(
      user_attributes: [:id, :email, :phone, :password, :password_confirmation,
      :time_zone])
  end

end
