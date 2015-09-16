class Parent < ActiveRecord::Base
  has_one :user, as: :role

  accepts_nested_attributes_for :user
end
