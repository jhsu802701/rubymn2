# rubocop:disable Style/ColonMethodCall
# rubocop:disable Metrics/LineLength

#
module UsersHelper
  # Returns the Gravatar for the given user.
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest('default@rubyonracetracks.com')
    gravatar_id = Digest::MD5::hexdigest(user.gravatar_email.downcase) if user.gravatar_email?
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url,
              alt: "#{user.first_name} #{user.last_name}",
              class: 'gravatar')
  end
end

# rubocop:enable Style/ColonMethodCall
# rubocop:enable Metrics/LineLength
