class ProductRenderer < Crinder::Base(Product)
  field id
  field name : String
  field introduction : String
  field cost
  field price
  field storage
  field shelf
  field sold
end
