class Rule < ApplicationRecord
  has_paper_trail
  belongs_to :creator, class_name: 'User', required: false, foreign_key: :user_id
end
