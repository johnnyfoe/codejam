module UsersHelper
  # Returns the Gravatar (http://gravater.com/) for the given user.
  def gravatar_for (user, size="40")
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: "#{user.first_name} #{user.surname}", class: "gravatar")
  end
end
