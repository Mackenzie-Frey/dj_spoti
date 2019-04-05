class Party < ApplicationRecord
  has_one :admin, :class_name => "User", :foreign_key => "id"
end
