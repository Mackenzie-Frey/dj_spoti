class PartyController < ApplicationController
  def new
    @party = Party.new
  end

  def create
    binding.pry
  end

end
