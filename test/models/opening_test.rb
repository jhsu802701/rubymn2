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

require 'test_helper'

class OpeningTest < ActiveSupport::TestCase
  def setup
    @user = users(:justice)
    @op = @user.openings.create(title: 'Deputy',
                                description: 'Help catch the Bandit!')
  end

  test 'should be valid' do
    assert @op.valid?
  end

  test 'must have description' do
    @op.description = ''
    assert_not @op.valid?
  end

  test 'must have title' do
    @op.title = ''
    assert_not @op.valid?
  end

  test 'description should not be too long' do
    @op.description = 'a' * 4096
    assert_not @op.valid?
    @op.description = 'a' * 4095
    assert @op.valid?
  end

  test 'title should not be too long' do
    @op.title = 'a' * 256
    assert_not @op.valid?
    @op.title = 'a' * 255
    assert @op.valid?
  end

  test 'deleting the user should delete the associated openings' do
    assert_difference 'Opening.count', -1 do
      @user.destroy
    end
  end
end
