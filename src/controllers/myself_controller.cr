class MyselfController < ApplicationController
  before_action do
    all { authenticate!(User::Level::Clerk, scopes: ["ghshop.own", "ghshop.manage", "ghshop.sell"]) }
  end

  def index
    UserRenderer.render current_user
  end
end
