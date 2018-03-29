class UserController < ApplicationController
  before_action do
    all { authenticate!(User::Level::Owner, scopes: ["ghshop.own"]) }
  end

  def index
    users = User.all
    UserRenderer.render users
  end

  def show
    if user = User.find? params["id"]
      UserRenderer.render user
    else
      not_found! t("user.errors.not_found", {id: params["id"]})
    end
  end

  def update
    if user = User.find? params["id"]
      user.set_attributes(user_params.validate!)
      user.level = params["level"]
      if user.valid? && user.save
        UserRenderer.render user
      else
        bad_request! t("user.errors.update")
      end
    else
      not_found! t("user.errors.not_found", {id: params["id"]})
    end
  end

  def destroy
    if user = User.find? params["id"]
      user.destroy
      UserRenderer.render user
    else
      not_found! t("user.errors.not_found", {id: params["id"]})
    end
  end

  def user_params
    params.validation do
      required(:level) { |f| !f.nil? && !!User::Level.parse?(f) }
    end
  end
end
