# == Schema Information
#
# Table name: forhires
#
#  id          :integer          not null, primary key
#  description :text
#  email       :string
#  title       :string
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

#
class Forhire < ApplicationRecord
  belongs_to :user
end
