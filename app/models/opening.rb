# == Schema Information
#
# Table name: openings
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

#
class Opening < ApplicationRecord
  validates :user_id, presence: true
  validates :description, presence: true, length: { maximum: 4095 }
  validates :title, presence: true, length: { maximum: 255 }

  # Limit the parameters available for searching the opening database
  RANSACKABLE_ATTRIBUTES = %w[title description].freeze
  def self.ransackable_attributes(_auth_object = nil)
    RANSACKABLE_ATTRIBUTES + _ransackers.keys
  end
end
