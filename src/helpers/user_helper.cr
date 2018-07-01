module UserHelper
  include OAuth::Helper

  @current_user : User?

  def current_user
    @current_user ||= find_or_create_user
  end

  def find_or_create_user
    if user = User.find_by(oauth_id: token_info.user.id)
      user
    else
      User.create(oauth_id: token_info.user.id, email: token_info.user.email, name: token_info.user.name)
    end
  end

  def authenticate!(level : User::Level, scopes : Array(String))
    return nil unless oauth_authenticate!(scopes, realm = "GHShop")
    return forbidden!(t("user.errors.denied")) unless current_user.level >= level
  end
end
