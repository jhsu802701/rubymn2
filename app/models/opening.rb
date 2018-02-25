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
  belongs_to :user
end
