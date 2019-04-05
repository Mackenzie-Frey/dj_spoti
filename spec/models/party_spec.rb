require 'rails_helper'

RSpec.describe Party, type: :model do
  describe 'validations' do
    it { should have_one(:admin)}
  end
end
