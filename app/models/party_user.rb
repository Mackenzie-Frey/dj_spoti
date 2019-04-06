class PartyUser < ApplicationRecord
  belongs_to :party
  belongs_to :user
end

# In order to get the json objects for top_plays for all party users
# at specific party, I will make a class method for PartyUser which takes an argument
# of the party_id and find all party_users where_party_id matches ie method name:

# Then I will make an api call for SpotifyService.(token).top_plays for each party_user
# at the party. This endpoint for the top_plays is updated once a day. We are
# using the param of medium_term on this endpoint, which is the last 6 months and likely
# won't change frequently. Thinking I'll memoize this api call for each party user( SpotifyService.(token).top_plays )
# I'm not sure how to go about invalidating this yet, as presumably we wouldn't want the
# top plays for a user to be frozen forever based on the first api call. Haven't figured out this part yet.
# We'll need some sort of logic
# From there I'm thinking of making a model instance method for PartyUsers to
# get their

# As we can only submit 5 artists, my thoughts are to 
# shuffle.limit(5)

# END Get 5 artist ids ->>The Spotify Service recommended_playlist method takes a
# argument of "artist_id1,artist_id2,etc" with up to 5 artist ids.
