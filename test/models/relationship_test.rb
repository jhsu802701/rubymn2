# == Schema Information
#
# Table name: relationships
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  def setup
    @relationship = Relationship.new(follower_id: users(:lazenby).id,
                                     followed_id: users(:connery).id)
  end

  test 'should be valid' do
    assert @relationship.valid?
  end

  test 'should allow the opposite relationship to exist as well' do
    @relationship_opp = Relationship.new(follower_id: users(:connery).id,
                                         followed_id: users(:lazenby).id)
    assert @relationship_opp.valid?
  end

  test 'should require a follower_id' do
    @relationship.follower_id = nil
    assert_not @relationship.valid?
  end

  test 'should require a followed_id' do
    @relationship.followed_id = nil
    assert_not @relationship.valid?
  end

  test 'deleting the follower deletes the relationship' do
    assert_difference 'Relationship.count', -2 do
      users(:lazenby).destroy
    end
  end

  test 'deleting the followed deletes the relationship' do
    assert_difference 'Relationship.count', -3 do
      users(:connery).destroy
    end
  end
end
