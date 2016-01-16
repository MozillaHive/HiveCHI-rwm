class StudentsController < ApplicationController
  before_filter :require_login, :require_student, except: [:new, :create]
  before_filter :require_no_login, only: [:new, :create]

  def new
    @student = Student.new
    @student.build_user
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      session[:user_id] = @student.user.id
      redirect_to users_verify_path
    else
      render 'new'
    end
  end

  def edit
    if current_user.email == "example@example.com"
      flash[:notice] = "You cannot edit the demo user's profile."
      redirect_to home_path
    else
      @student = current_student
    end
  end

  def update
    @student = current_student
    if @student.update(student_params)
      redirect_to home_path
    else
      render 'edit'
    end
  end

  def destroy
    if current_student.destroy
      reset_session
      flash[:notice] = "Your account has been deleted."
      redirect_to login_path
    end
  end

  private

  def student_params
    params.require(:student).permit(
      :username, :school_id, :home_address, :nudges_enabled,
      user_attributes: [:id, :email, :phone, :password, :password_confirmation,
      :time_zone, :tos_accepted]
    )
  end

end
