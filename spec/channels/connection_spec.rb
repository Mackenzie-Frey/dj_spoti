# require "rails_helper"
#
# RSpec.describe ApplicationCable::Connection, :type => :channel do
#   it "successfully connects" do
#     user = create(:user)
#     admin = create(:user)
#     party = create(:party, admin: admin)
#     party.users << user
#     # binding.pry
#     connect "/cable?us_id=#{user.id}"
#     expect(connection.user_id).to eq "323"
#   end
# end
