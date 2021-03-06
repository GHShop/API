class ProductController < ApplicationController
  before_action do
    only [:index, :create, :update, :destroy] { authenticate!(User::Level::Manager, scopes: ["ghshop.own", "ghshop.manage"]) }
    only [:show, :stock, :replenish] { authenticate!(User::Level::Clerk, scopes: ["ghshop.own", "ghshop.manage", "ghshop.sell"]) }
  end

  def index
    if artist = Artist.find params["id"]
      ProductRenderer.render artist.products.to_a
    else
      not_found! t("artist.errors.not_found", {id: params["id"]})
    end
  end

  def show
    if product = Product.find params["id"]
      ProductRenderer.render product
    else
      not_found! t("product.errors.not_found", {id: params["id"]})
    end
  end

  def create
    if artist = Artist.find params["id"]
      product = Product.new(product_params.validate!)
      product.artist = artist

      if product.valid? && product.save
        ProductRenderer.render product
      else
        bad_request! t("product.errors.create")
      end
    else
      not_found! t("product.errors.not_found", {id: params["id"]})
    end
  end

  def update
    if product = Product.find params["id"]
      product.set_attributes(product_params.validate!)
      if product.valid? && product.save
        ProductRenderer.render product
      else
        bad_request! t("product.errors.update")
      end
    else
      not_found! t("product.errors.not_found", {id: params["id"]})
    end
  end

  def stock
    if product = Product.find params["id"]
      if product.stock(params["count"].to_i) && product.save
        ProductRenderer.render product
      else
        bad_request! t("product.errors.stock", {count: params["count"]})
      end
    else
      not_found! t("product.errors.not_found", {id: params["id"]})
    end
  end

  def replenish
    if product = Product.find params["id"]
      if product.replenish(params["count"].to_i) && product.save
        ProductRenderer.render product
      else
        bad_request! t("product.errors.replenish", {count: params["count"]})
      end
    else
      not_found! t("product.errors.not_found", {id: params["id"]})
    end
  end

  def destroy
    if product = Product.find params["id"]
      product.destroy
      ProductRenderer.render product
    else
      not_found! t("product.errors.not_found", {id: params["id"]})
    end
  end

  def product_params
    params.validation do
      required(:name) { |f| !f.nil? }
      required(:introduction) { |f| !f.nil? }
      required(:cost) { |f| !f.nil? }
      required(:price) { |f| !f.nil? }
      required(:storage) { |f| !f.nil? }
      required(:shelf) { |f| !f.nil? }
    end
  end
end
