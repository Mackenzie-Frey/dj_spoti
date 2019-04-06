class PartyUser < ApplicationRecord
  belongs_to :party
  belongs_to :user
end

# In order to get the json objects for top_plays for all party users
# at specific party, I will make a class method for PartyUser which takes an argument
# of the party_id and find all party_users where_party_id matches

# Then I will make an api call for SpotifyService.(token).top_plays for each party_user
# at the party. This endpoint for the top_plays is updated once a day. We are
# using the param of medium_term on this endpoint, which is the last 6 months and likely
# won't change frequently. Thinking I'll memoize this api call for each party user( potifyService.(token).top_plays )
# I'm not sure how to go about invalidating this yet, as presumably we wouldn't want the
# top plays for a user to be frozen forever based on the first api call. Haven't figured out this part yet.
# We'll need some sort of logic
# From there I'm thinking of making a model instance method for Party to
#
