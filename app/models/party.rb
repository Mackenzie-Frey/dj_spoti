class Party < ApplicationRecord
  belongs_to :admin, :foreign_key=> 'admin_id', :class_name=> 'User'
  has_many :party_users
  has_many :users, through: :party_users
end
