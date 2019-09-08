# == Schema Information
#
# Table name: forhires
#
#  id          :bigint           not null, primary key
#  description :text
#  email       :string
#  title       :string
#  user_id     :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

#
class Forhire < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :description, presence: true, length: { maximum: 4095 }
  validates :email, presence: true, length: { maximum: 255 }
  validates :title, presence: true, length: { maximum: 255 }

  # Limit the parameters available for searching the forhire database
  RANSACKABLE_ATTRIBUTES = %w[title description email].freeze
  def self.ransackable_attributes(_auth_object = nil)
    RANSACKABLE_ATTRIBUTES + _ransackers.keys
  end
end
