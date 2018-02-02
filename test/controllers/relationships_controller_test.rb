require 'test_helper'

class RelationshipsControllerTest < ActionDispatch::IntegrationTest
  # NOTE: I was unable to create suitable controller tests of the
  # relationship creation process.  The relationship creation process
  # is tested in the integration tests.

  def destroy_relationship
    delete relationship_path(@r8)
  end

  def destroy_relationship_disabled
    assert_no_difference 'Relationship.count' do
      destroy_relationship
    end
  end

  test 'visitor cannot destroy relationship' do
    destroy_relationship_disabled
  end

  test 'the wrong user cannot destroy relationship' do
    sign_in @u1, scope: :user
    destroy_relationship_disabled
    sign_in @u8, scope: :user
    destroy_relationship_disabled
  end

  test 'the correct user can destroy relationship' do
    sign_in @u13, scope: :user
    assert_difference 'Relationship.count', -1 do
      destroy_relationship
    end
    assert_redirected_to user_path(@u9)
  end

  test 'regular admin cannot destroy relationship' do
    sign_in @a4, scope: :admin
    destroy_relationship_disabled
  end

  test 'super admin cannot destroy relationship' do
    sign_in @a1, scope: :admin
    destroy_relationship_disabled
  end
end
