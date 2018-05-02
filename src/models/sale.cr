class Sale < Granite::ORM::Base
  adapter pg
  table_name sales

  belongs_to product
  belongs_to clerk : User

  field! count : Int32
  field! price : Int32
  timestamps

  before_create sell_product
  before_destroy restore_product

  def sell_product
    if (product = Product.find(product_id)) && product.sell(count) && product.valid? && product.save
      self.price = product.price
    else
      abort!
    end
  end

  def restore_product
    if (product = Product.find(product_id)) && product.sell(-count) && product.valid? && product.save
      self.price = product.price
    else
      abort!
    end
  end
end
