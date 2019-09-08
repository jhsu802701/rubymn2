# == Schema Information
#
# Table name: projects
#
#  id              :bigint           not null, primary key
#  title           :string
#  source_code_url :string
#  deployed_url    :string
#  description     :text
#  user_id         :bigint
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

#
class Project < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :description, presence: true, length: { maximum: 4095 }
  validates :title, presence: true, length: { maximum: 255 }
  validates :source_code_url, length: { maximum: 255 }
  validates :deployed_url, length: { maximum: 255 }

  # Limit the parameters available for searching the project database
  RANSACKABLE_ATTRIBUTES = %w[title description].freeze
  def self.ransackable_attributes(_auth_object = nil)
    RANSACKABLE_ATTRIBUTES + _ransackers.keys
  end
end
