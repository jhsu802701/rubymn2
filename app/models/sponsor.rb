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
#  picture       :string
#

#
class Sponsor < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :phone, length: { maximum: 255 }
  validates :description, length: { maximum: 4095 }
  validates :contact_email, length: { maximum: 255 }
  validates :contact_url, length: { maximum: 255 }

  # Allows the file uploading process to fill in the picture parameter
  mount_uploader :picture, PictureUploader
end
