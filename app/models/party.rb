class Party < ApplicationRecord
  belongs_to :admin, :foreign_key=> 'admin_id', :class_name=> 'User'
  has_many :party_users
  has_many :users, through: :party_users, dependent: :destroy

  def current_song
    @current_song ||= calculate_current_song
  end


  private

  
  def calculate_current_song
    SongFacade.new(self.admin.access_token).current_song
  end
end
