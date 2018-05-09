class SaleController < ApplicationController
  before_action do
    only [:destroy] { authenticate!(User::Level::Owner, scopes: ["ghshop.own"]) }
    only [:index, :show] { authenticate!(User::Level::Manager, scopes: ["ghshop.own", "ghshop.manage"]) }
    only [:create] { authenticate!(User::Level::Clerk, scopes: ["ghshop.own", "ghshop.manage", "ghshop.sell"]) }
  end

  def index
    if (from = parse params[:from]?, default: Time.now.at_beginning_of_day) && (to = parse params[:to]?, default: Time.now)
      sales = Sale.all("WHERE created_at >= ? AND created_at <= ?", [from, to])
      SaleRenderer.render sales.to_a
    else
      bad_request! t("time.errors.format")
    end
  end

  def show
    if sale = Sale.find params["id"]
      SaleRenderer.render sale
    else
      not_found! t("sale.errors.not_found", {id: params["id"]})
    end
  end

  def create
    if product = Product.find params["id"]
      sale = Sale.new(sale_params.validate!)
      sale.product = product
      sale.clerk = current_user

      if sale.valid? && sale.save
        SaleRenderer.render sale
      else
        bad_request! t("sale.errors.create")
      end
    else
      bad_request! t("product.errors.not_found")
    end
  end

  def destroy
    if sale = Sale.find params["id"]
      sale.destroy
      SaleRenderer.render sale
    else
      not_found! t("sale.errors.not_found", {id: params["id"]})
    end
  end

  def sale_params
    params.validation do
      required(:count) { |f| !f.nil? }
    end
  end
end
