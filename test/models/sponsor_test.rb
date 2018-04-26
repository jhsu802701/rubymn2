# == Schema Information
#
# Table name: sponsors
#
#  id            :bigint(8)        not null, primary key
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

require 'test_helper'

class SponsorTest < ActiveSupport::TestCase
  def setup
    @sponsor = Sponsor.new(name: 'Valere Consulting and Recruiting',
                           phone: '612-555-0100',
                           description: 'Exceptional talent',
                           contact_email: 'valere@rubyonracetracks.com',
                           contact_url: 'http://valere.com/',
                           current: true)
  end

  test 'should be valid' do
    assert @sponsor.valid?
  end

  test 'name must be present' do
    @sponsor.name = nil
    assert_not @sponsor.valid?
  end

  test 'name should be no more than 255 characters long' do
    @sponsor.name = 'a' * 256
    assert_not @sponsor.valid?
    @sponsor.name = 'a' * 255
    assert @sponsor.valid?
  end

  test 'phone number should be no more than 255 characters long' do
    @sponsor.phone = '5' * 256
    assert_not @sponsor.valid?
    @sponsor.phone = '5' * 255
    assert @sponsor.valid?
  end

  test 'description should be no more than 4095 characters long' do
    @sponsor.description = 'a' * 4096
    assert_not @sponsor.valid?
    @sponsor.description = 'a' * 4095
    assert @sponsor.valid?
  end

  test 'contact_email should be no more than 255 characters long' do
    @sponsor.contact_email = 'a' * 244 + '@example.com'
    assert_not @sponsor.valid?
    @sponsor.contact_email = 'a' * 243 + '@example.com'
    assert @sponsor.valid?
  end

  test 'contact_url should be no more than 255 characters long' do
    @sponsor.contact_url = 'http://www' + 'a' * 242 + '.com'
    assert_not @sponsor.valid?
    @sponsor.contact_url = 'http://www' + 'a' * 241 + '.com'
    assert @sponsor.valid?
  end
end
