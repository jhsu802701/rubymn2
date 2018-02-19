# == Schema Information
#
# Table name: projects
#
#  id              :integer          not null, primary key
#  title           :string
#  source_code_url :string
#  deployed_url    :string
#  description     :text
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

#
class Project < ApplicationRecord
  belongs_to :user
end
