
class PartiesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "parties:#{party.identifier}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end


end
