class StudentsController < ApplicationController
  def new
    @student = Student.new
  end

  def create
  end
end
