class Property < ApplicationRecord
  has_many :observations, dependent: :destroy
end
