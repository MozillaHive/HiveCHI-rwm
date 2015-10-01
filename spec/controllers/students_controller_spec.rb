require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  describe "POST #create" do
    context "with valid attributes" do
      before { post :create, student: FactoryGirl.attributes_for(:student) }
      specify { expect(response).to redirect_to(users_verify_path) }
      specify { expect(Student.count).to eq(1) }
      specify { expect(User.count).to eq(1) }
      specify { expect(session[:user_id]).not_to be_nil }
    end

    context "with invalid attributes" do
      before do
        post :create, student: FactoryGirl.attributes_for(:student)
          .merge(user_attributes: FactoryGirl.attributes_for(:user).merge(email: "invalid@email") )
      end
      specify { expect(response).to render_template("new") }
      specify { expect(Student.count).to eq(0) }
      specify { expect(User.count).to eq(0) }
      specify { expect(session[:user_id]).to be_nil }
    end
  end

end
