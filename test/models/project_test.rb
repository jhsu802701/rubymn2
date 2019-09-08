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

require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  def setup
    @user = users(:connery)
    url_s = 'https://github.com/sconnery/anti_spectre'
    url_d = 'http://www.antispectre.com'
    @p = @user.projects.create(title: 'Anti-SPECTRE',
                               description: "Blow up Blofeld's hideout",
                               source_code_url: url_s,
                               deployed_url: url_d)
  end

  test 'should be valid' do
    assert @p.valid?
  end

  test 'must have description' do
    @p.description = ''
    assert_not @p.valid?
  end

  test 'must have title' do
    @p.title = ''
    assert_not @p.valid?
  end

  test 'description should not be too long' do
    @p.description = 'a' * 4096
    assert_not @p.valid?
    @p.description = 'a' * 4095
    assert @p.valid?
  end

  test 'title should not be too long' do
    @p.title = 'a' * 256
    assert_not @p.valid?
    @p.title = 'a' * 255
    assert @p.valid?
  end

  test 'source_code_url should not be too long' do
    @p.source_code_url = 'http://www.' + 'a' * 241 + '.com'
    assert_not @p.valid?
    @p.source_code_url = 'http://www.' + 'a' * 240 + '.com'
    assert @p.valid?
  end

  test 'deployed_url should not be too long' do
    @p.deployed_url = 'http://www.' + 'a' * 241 + '.com'
    assert_not @p.valid?
    @p.deployed_url = 'http://www.' + 'a' * 240 + '.com'
    assert @p.valid?
  end

  test 'deleting the user should delete the associated projects' do
    assert_difference 'Project.count', -1 do
      @user.destroy
    end
  end
end
