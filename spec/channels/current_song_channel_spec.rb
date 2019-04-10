require 'rails_helper'

RSpec.describe CurrentSongChannel, type: :channel do
  it "successfully subscribes" do
    user = create(:user)
    admin = create(:user)
    party = create(:party, admin: admin)
    party.users << user

    subscribe
    expect(subscription).to be_confirmed
  end

  it "successfully subscribes a user" do
    user = create(:user)
    stub_connection user_id: user.id
    subscribe
    expect(subscription).to be_confirmed
    expect(subscription.user_id).to eq(user.id)
  end

  it "successfully subscribes to a specific party" do
    user = create(:user)
    admin = create(:user)
    party = create(:party, admin: admin)
    party.users << user

    stub_connection user_id: user.id
    subscribe(party: party.identifier)
    expect(subscription).to have_stream_from("current_song_#{party.identifier}")
  end
end
