class Product < Granite::ORM::Base
  adapter pg
  table_name products

  belongs_to artist

  field name : String
  field introduction : String
  field cost : Int32
  field price : Int32
  field storage : Int32
  field shelf : Int32
  field sold : Int32
  timestamps

  def stock(count : Int32)
    self.storage += count
    storage >= 0
  end

  def replenish(count : Int32)
    self.shelf += count
    self.storage -= count
    storage >= 0 && shelf >= 0
  end
end
