class SaleRenderer < Crinder::Base(Sale)
  field id
  field count : Int
  field price : Int
  field product, with: ProductRenderer
  field clerk, with: UserRenderer

  class ProductRenderer < ::ProductRenderer
    remove introduction
    remove cost
    remove price
  end
end
