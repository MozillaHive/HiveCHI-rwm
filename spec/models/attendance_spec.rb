require 'rails_helper'

RSpec.describe Attendance do
  describe 'description' do
    before :each do
      @attendance = create :attendance
    end

    it 'should return that a user is going to the event when commitment status is yes' do
      @attendance.commitment_status = Attendance::YES
      expect(@attendance.description).to eq(I18n.t(:user_going_to_event))
    end

    it 'should return that a user is watching the event when commitment status is yes' do
      @attendance.commitment_status = Attendance::MAYBE
      expect(@attendance.description).to eq(I18n.t(:user_watching_event))
    end

    it 'should return that a user backed out of the event when commitment status is yes' do
      @attendance.commitment_status = Attendance::NO
      expect(@attendance.description).to eq(I18n.t(:user_backed_out_of_event))
    end
  end

end
