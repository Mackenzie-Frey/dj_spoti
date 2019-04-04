# frozen_string_literal: true

# Parent class for Models
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
