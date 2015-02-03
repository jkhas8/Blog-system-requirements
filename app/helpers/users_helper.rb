module UsersHelper
  # Returns the Gravatar for the given user.
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  # Login
  def log_in(user)
    session[:user_id] = user.id
  end

  # Current user
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Logged in?
  def logged_in?
    !current_user.nil?
  end

  # Log out
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
