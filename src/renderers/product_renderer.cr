class ProductRenderer < Crinder::Base(Product)
  field id
  field name : String
  field introduction : String
  field cost : Int
  field price : Int
  field storage : Int
  field shelf : Int
end
