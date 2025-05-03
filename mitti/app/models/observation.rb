class ContentValidator < ActiveModel::Validator
  def validate(record)
    begin
      JSON.parse(record.content)
    rescue JSON::ParserError
      record.errors.add(:content, 'must be valid json')
    rescue Exception => e
      logger.error("Failed to parse Observation content with unknown error -> #{e}")
    end
  end
end

class Observation < ApplicationRecord
  belongs_to :property

  validates_with ContentValidator
end
