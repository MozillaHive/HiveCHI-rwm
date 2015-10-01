require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  let(:student) { create(:verified_student) }

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

  describe "GET #edit" do
    before { get :edit, nil, user_id: student.user.id }
    specify { expect(response).to render_template("edit") }
    specify { expect(assigns(:student)).to eq(student) }
  end

  describe "PATCH #update" do
    context "with valid information" do
      before do
        patch :update, { student: { username: "newusername" } }, user_id: student.user.id
      end
      specify { expect(response).to redirect_to(dashboard_path) }
      specify { expect(student.reload.username).to eq("newusername") }
    end

    context "with invalid information" do
      before do
        patch :update, { student: { username: "" } }, user_id: student.user.id
      end
      specify { expect(response).to render_template("edit") }
      specify { expect(student.reload.username).not_to eq("") }
    end
  end

  describe "DELETE #destroy" do
    before { delete :destroy, nil, user_id: student.user.id }
    specify { expect(Student.count).to eq(0) }
    specify { expect(User.count).to eq(0) }
    specify { expect(session[:user_id]).to be_nil }
  end
end
