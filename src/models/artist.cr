class Artist < Granite::ORM::Base
  adapter pg
  table_name artists

  belongs_to user

  field name : String
  field introduction : String
  timestamps
end
