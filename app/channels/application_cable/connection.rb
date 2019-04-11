# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base

    def connect
      logger.add_tags 'ActionCable', "Connect method"  

    end

    # identified_by :current_user
    #
    # # identified_by :current_user
    #
    # def connect
    #   self.current_user = find_verified_user
    #   logger.add_tags "ActionCable", "User #{current_user.name}"
    # end
    #
    # protected
    # def find_verified_user
    #   if current_user = User.find_by(id: 1)
    #     current_user
    #   else
    #     reject_unauthorized_connection
    #   end
    # end

  end
end
