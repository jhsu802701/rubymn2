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

require 'test_helper'

class ForhireTest < ActiveSupport::TestCase
  def setup
    @user = users(:connery)
    @fh = @user.forhires.create(description: 'I stopped Blofeld 4 times!',
                                email: 'first_bond@rubyonracetracks.com',
                                title: 'James Bond 1962-1971')
  end

  test 'should be valid' do
    assert @fh.valid?
  end

  test 'must have description' do
    @fh.description = ''
    assert_not @fh.valid?
  end

  test 'must have email' do
    @fh.email = ''
    assert_not @fh.valid?
  end

  test 'must have title' do
    @fh.title = ''
    assert_not @fh.valid?
  end

  test 'description should not be too long' do
    @fh.description = 'a' * 4096
    assert_not @fh.valid?
    @fh.description = 'a' * 4095
    assert @fh.valid?
  end

  test 'email should not be too long' do
    @fh.email = 'a' * 244 + '@example.com'
    assert_not @fh.valid?
    @fh.email = 'a' * 243 + '@example.com'
    assert @fh.valid?
  end

  test 'title should not be too long' do
    @fh.title = 'a' * 256
    assert_not @fh.valid?
    @fh.title = 'a' * 255
    assert @fh.valid?
  end

  test 'deleting the user should delete the associated forhires' do
    assert_difference 'Forhire.count', -1 do
      @user.destroy
    end
  end
end
