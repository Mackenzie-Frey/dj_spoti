class Party < ApplicationRecord
  belongs_to :admin, :foreign_key=> 'admin_id', :class_name=> 'User'
  has_many :party_users, dependent: :destroy
  has_many :users, through: :party_users

  # def current_song
  #   unless defined?(@current_song)
  #
  #     @current_song ||= begin
  #       calculate_current_song
  #     end
  #     @current_song
  #   end
  # end

  def current_song
    @current_song ||= calculate_current_song
  end


  private

  def calculate_current_song
    SongFacade.new(self.admin.access_token).current_song
  end

end
