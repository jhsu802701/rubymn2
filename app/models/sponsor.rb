# == Schema Information
#
# Table name: sponsors
#
#  id            :integer          not null, primary key
#  name          :string
#  phone         :string
#  description   :text
#  contact_email :string
#  contact_url   :string
#  current       :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

#
class Sponsor < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :phone, length: { maximum: 255 }
  validates :description, length: { maximum: 4095 }
  validates :contact_email, length: { maximum: 255 }
  validates :contact_url, length: { maximum: 255 }
end